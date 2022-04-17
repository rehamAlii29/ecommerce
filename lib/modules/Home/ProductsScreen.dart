

import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce/ShopLayout/Cubit/ShopLayoutCubit.dart';
import 'package:ecommerce/ShopLayout/Cubit/ShopLayoutStates.dart';
import 'package:ecommerce/models/ShopHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
buildProductsData(ShopHomeModel shopHomeModel)=> Column(children: [
  CarouselSlider(
    //need alist
      items:shopHomeModel.data!.banners!.map((e) {
        return
        Image(image:  NetworkImage("${e.image}",
        ),
          width: double.infinity
          ,);
      }).toList() ,

      options: CarouselOptions(

        height: 100,
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
  )
],);
