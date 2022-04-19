import 'package:ecommerce/ShopLayout/Cubit/ShopLayoutCubit.dart';
import 'package:ecommerce/ShopLayout/Cubit/ShopLayoutStates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class ShopLayout extends StatefulWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  State<ShopLayout> createState() => _ShopLayoutState();
}

class _ShopLayoutState extends State<ShopLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(builder: (context, state){
      return  Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation:0,
          centerTitle: true,
          title: Text(ShopLayoutCubit.get(context).Titles[ShopLayoutCubit.get(context).currentindex],
            style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w900),),
        ),
        body: ShopLayoutCubit.get(context).Screens[ShopLayoutCubit.get(context).currentindex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          currentIndex:  ShopLayoutCubit.get(context).currentindex,

          onTap: (index){
            ShopLayoutCubit.get(context).changebottomnavbarcubit(index);
            print(index);
            print(ShopLayoutCubit.get(context).currentindex);
          },
          items:  [
            BottomNavigationBarItem(icon:Icon(Icons.home, color:HexColor('2F80ED') ,), label: 'home', ),
            BottomNavigationBarItem(icon:Icon(Icons.app_registration,color:HexColor('2F80ED')  ), label: 'catogeries', ),
            BottomNavigationBarItem(icon:Icon(Icons.favorite,color:HexColor('2F80ED')  ), label: 'favorites', ),
            BottomNavigationBarItem(icon:Icon(Icons.settings, color:HexColor('2F80ED') ), label: 'settings', ),


          ],

        ),
      );
    },
        listener: (context, state){

    });
  }
}
