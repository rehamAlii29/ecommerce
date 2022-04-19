

import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce/ShopLayout/Cubit/ShopLayoutCubit.dart';
import 'package:ecommerce/ShopLayout/Cubit/ShopLayoutStates.dart';
import 'package:ecommerce/models/Categories.dart';
import 'package:ecommerce/models/ShopHome.dart';
import 'package:ecommerce/modules/Categories/Categories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:motion_toast/motion_toast.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
  return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(

      listener: (context, state) {
        if(state is ChanFavSuccessState){
          if(!state.changeFavorites!.status!){
            MotionToast.error(

                description:  Text(state.changeFavorites!.message!)
            ).show(context);

          }
          if(state.changeFavorites!.status!)
            MotionToast.success(

                description:  Text(state.changeFavorites!.message!)
            ).show(context);
        }
      },
      builder: (context, state) {
     //   ShopLayoutCubit.get(context).getHomeData();
        return
  ConditionalBuilder(
  condition: ShopLayoutCubit.get(context).shopHomeModel?.data!.banners !=null,
    builder: (context)=>buildProductsData( ShopLayoutCubit.get(context).shopHomeModel!, ShopLayoutCubit.get(context).categories!, context),
    fallback: (context)=> Center(child: CircularProgressIndicator()),
    );
      }
    );
  }
}
buildProductsData(ShopHomeModel shopHomeModel, CategoriesModel categories, context)=> SingleChildScrollView(
  child:   Column(
    crossAxisAlignment:CrossAxisAlignment.start
    ,children: [
  
    CarouselSlider(
  
      //need alist
  
        items:shopHomeModel.data!.banners!.map((e) {
  
          return
  
          Image(image:  NetworkImage("${e.image}",
  
          ),
  
            width: double.infinity,
  
            fit: BoxFit.cover
  
            ,);
  
        }).toList() ,
  
  
  
        options: CarouselOptions(
  
  
  
          height: 200,
  
          initialPage: 0,
  
          enableInfiniteScroll: true,
  
          reverse: false,
  
          autoPlay: true,
  
          autoPlayInterval: Duration(seconds: 3),
  
          autoPlayAnimationDuration: Duration(seconds: 3),
  
          autoPlayCurve: Curves.fastLinearToSlowEaseIn,
  
          scrollDirection: Axis.horizontal,
  
          viewportFraction: 1,
  
  
  
  
  
        )
  
    ),
   SizedBox(height: 10,),
    Text("Categories", style: TextStyle(fontWeight: FontWeight.w800 ,fontSize: 15),),

  Container(
   width: double.infinity,
    height: 100,
    child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap:  true,
        itemBuilder: (context , index){
          return buildCategoriesSection(categories.data!.data[index]);
        },
        separatorBuilder: (context , index){
          return SizedBox(width: 10,);
        },
        itemCount:categories.data!.data.length ),
  ),
    SizedBox(height: 10,),
    Row(
      children: [
        Text("Products", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),),
      ],
    ),

   Padding(
     padding: const EdgeInsets.all(8.0),
     child: GridView.count(

       physics: NeverScrollableScrollPhysics(),

      //   scrollDirection: Axis.vertical ,

       shrinkWrap: true,

         crossAxisCount: 2,

      crossAxisSpacing: 3,

      mainAxisSpacing: 2,

       childAspectRatio: 1/1.58,

       children: List.generate(shopHomeModel.data!.products!.length, (index) =>

          buildProducts(shopHomeModel.data!.products![index], context)

       )



     ),
   ),

  
  
  
  ],),
);
buildProducts(Products products , context){
return
  SingleChildScrollView(
    physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Stack(
              alignment: Alignment.bottomLeft,
              children: [

                Image(image: NetworkImage('${products.image}'),),
                if(products.discount != 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  color:  Colors.red,
                  child: Text("disCount"),),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${products.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
            ),
            Row(children: [

              Expanded(
                child: Row(
                  children: [
                    Text(products.price.toString(), style: TextStyle( color: HexColor('2F80ED')),),
  SizedBox(width: 5,),
  if(products.old_price != products.price)
  Text(products.old_price.toString(), style: TextStyle( fontSize:  10,

  decoration: TextDecoration.lineThrough),


  ),
              ]  ),
              ),

              IconButton(
                alignment: AlignmentDirectional.bottomEnd,
                  onPressed: (){
                  ShopLayoutCubit.get(context).changeFavorites(products.id!);
                  },
                  icon: Icon(Icons.favorite,
                    color: ShopLayoutCubit.get(context).FavoritesList[products.id]! ?  Colors.red : Colors.grey,
                  ))
            ],)

          ],
        ),
      ));
}
buildCategoriesSection(DataOfDataModel model ){
  return
      Stack( alignment: Alignment.bottomLeft,
        children: [
      Image(image:   NetworkImage(model.image!),
        width: 100,
        height: 100
        ,),

        Container( color: Colors.black.withOpacity(.8),
            child: Text(model.name!, style: TextStyle(color: Colors.white),))
      ],)
  ;

}