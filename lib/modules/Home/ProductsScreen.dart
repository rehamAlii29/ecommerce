

import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce/ShopLayout/Cubit/ShopLayoutCubit.dart';
import 'package:ecommerce/ShopLayout/Cubit/ShopLayoutStates.dart';
import 'package:ecommerce/models/ShopHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
  return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(

      listener: (context, state) {},
      builder: (context, state) {
     //   ShopLayoutCubit.get(context).getHomeData();
        return
  ConditionalBuilder(
  condition: ShopLayoutCubit.get(context).shopHomeModel?.data!.banners !=null,
    builder: (context)=>buildProductsData( ShopLayoutCubit.get(context).shopHomeModel!),
    fallback: (context)=> Center(child: CircularProgressIndicator()),
    );
      }
    );
  }
}
buildProductsData(ShopHomeModel shopHomeModel)=> SingleChildScrollView(
  child:   Column(children: [
  
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

          buildProducts(shopHomeModel.data!.products![index])

       )



     ),
   ),
  
  
  
  ],),
);
buildProducts(Products products){
return
  SingleChildScrollView(
    physics: BouncingScrollPhysics(),
      child: Column(
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
                onPressed: (){}, icon: Icon(Icons.favorite_border))
          ],)

        ],
      ));
}