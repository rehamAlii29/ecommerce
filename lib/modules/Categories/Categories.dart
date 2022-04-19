import 'package:ecommerce/ShopLayout/Cubit/ShopLayoutCubit.dart';
import 'package:ecommerce/ShopLayout/Cubit/ShopLayoutStates.dart';
import 'package:ecommerce/models/Categories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return
   BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
       builder: (context, state){
         return ListView.separated(itemBuilder: (context, index){
           return buuldCategories(ShopLayoutCubit.get(context).categories!.data!.data[index]);
         },
             separatorBuilder:(context , state){
           return SizedBox(height: 10,);
             } ,
             itemCount: ShopLayoutCubit.get(context).categories!.data!.data.length)  ;
       },
       listener: (context, state){});


  }
}
buuldCategories (DataOfDataModel model){
  return  SingleChildScrollView(child: Row(children: [
    Container(
      width: 100,
      height: 100,
      child: Image(image:
      NetworkImage(model.image!),
        width: 100,
        height: 100,),

    ),
    SizedBox(width: 10,),
    Text(model.name!),
    Spacer(),
    IconButton(onPressed: (){}, icon: Icon(Icons.chevron_right_rounded))


  ],));
}
