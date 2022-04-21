import 'package:ecommerce/ShopLayout/Cubit/ShopLayoutCubit.dart';
import 'package:ecommerce/ShopLayout/Cubit/ShopLayoutStates.dart';
import 'package:ecommerce/models/SearchModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}
var searchController = TextEditingController();
var formKey = GlobalKey<FormState>();
class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(builder: (context, state){
    return  Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body:  SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child:   TextFormField(
                    controller:  searchController,
                    validator: (value){
                      if (value!.isEmpty)
                        return "Enter the key you eant to search before press searchkey";

                    },
                    decoration: InputDecoration(
                        suffixIcon: IconButton(onPressed: (){
                          if(formKey.currentState!.validate())
                            ShopLayoutCubit.get(context).search(searchKey: searchController.text);
                        },icon: Icon(Icons.search),),
                        border: OutlineInputBorder(

                        )
                    ),
                  ),
                ),
                if(state is SearchResultSuccess)
                  ListView.separated(
                    shrinkWrap: true,
                      itemBuilder: (context, index){
                    return
                      buildItem(ShopLayoutCubit.get(context).searchModel!.date!.products[index], context);
                  },
                      separatorBuilder: (context, index){
                    return SizedBox(height: 20,);
                      },
                      itemCount:ShopLayoutCubit.get(context).searchModel!.date!.products.length )


              ],
            ),
          ),
        ),
      );
    }, listener: (context, state){});
  }
}
buildItem (Product searchproduct , context){

  return Row(


    children: [
      Container(
        width: 100,
        height: 100,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [

            Image(image: NetworkImage('${searchproduct.image}'),),
            if(searchproduct.discount != 0)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                color:  Colors.red,
                child: Text("disCount"),),
          ],
        ),
      ),
      SizedBox(width: 10,),
      Expanded(
        child:
        Column(
          children: [
            Text('${searchproduct.name}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Row(children: [

              Expanded(
                child: Row(
                    children: [
                      Text(searchproduct.price.toString(), style: TextStyle( color: HexColor('2F80ED')),),
                      SizedBox(width: 5,),
                      if(searchproduct.oldPrice != searchproduct.price)
                        Text(searchproduct.oldPrice.toString(), style: TextStyle( fontSize:  10,

                            decoration: TextDecoration.lineThrough),


                        ),
                    ]  ),
              ),

              IconButton(
                  alignment: AlignmentDirectional.bottomEnd,
                  onPressed: (){
                    ShopLayoutCubit.get(context).changeFavorites(searchproduct.id!);
                  },
                  icon: Icon(Icons.favorite,
                    color: ShopLayoutCubit.get(context).FavoritesList[searchproduct.id]! ?  Colors.red : Colors.grey,
                  ))
            ],)
          ],
        ),
      ),

    ],
  );
}