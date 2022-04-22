import 'package:flutter/cupertino.dart';

class InCartScreen extends StatefulWidget {
  const InCartScreen({Key? key}) : super(key: key);

  @override
  State<InCartScreen> createState() => _InCartScreenState();
}

class _InCartScreenState extends State<InCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}/*
buildCartItem(Dataproduct favproduct , context){
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
*/