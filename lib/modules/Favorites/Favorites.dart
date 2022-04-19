import 'package:ecommerce/ShopLayout/Cubit/ShopLayoutCubit.dart';
import 'package:ecommerce/ShopLayout/Cubit/ShopLayoutStates.dart';
import 'package:ecommerce/models/GetFavModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(builder: (context, state){
      return ListView.separated(itemBuilder: (context , index){
        return buildFavoritItem(ShopLayoutCubit.get(context).getFavModel!.data!.data![index], context);
      },
          separatorBuilder: (context , index){
        return SizedBox(height: 10);
          },
          itemCount:ShopLayoutCubit.get(context).getFavModel!.data!.data!.length );
    },
        listener: (context , state ){});
  }
}
buildFavoritItem(Dataproduct favproduct , context){
  return Row(


    children: [
      Container(
        width: 100,
        height: 100,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [

            Image(image: NetworkImage('${favproduct.product!.image}'),),
            if(favproduct.product!.discount != 0)
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
            Text('${favproduct.product!.name}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Row(children: [

              Expanded(
                child: Row(
                    children: [
                      Text(favproduct.product!.price.toString(), style: TextStyle( color: HexColor('2F80ED')),),
                      SizedBox(width: 5,),
                      if(favproduct.product!.oldPrice != favproduct.product!.price)
                        Text(favproduct.product!.oldPrice.toString(), style: TextStyle( fontSize:  10,

                            decoration: TextDecoration.lineThrough),


                        ),
                    ]  ),
              ),

              IconButton(
                  alignment: AlignmentDirectional.bottomEnd,
                  onPressed: (){
                    ShopLayoutCubit.get(context).changeFavorites(favproduct.product!.id!);
                  },
                  icon: Icon(Icons.favorite,
                    color: ShopLayoutCubit.get(context).FavoritesList[favproduct.product!.id]! ?  Colors.red : Colors.grey,
                  ))
            ],)
          ],
        ),
      ),

    ],
  );

}