import 'package:bloc/bloc.dart';
import 'package:ecommerce/ShopLayout/Cubit/ShopLayoutStates.dart';
import 'package:ecommerce/modules/Categories/Categories.dart';
import 'package:ecommerce/modules/Favorites/Favorites.dart';
import 'package:ecommerce/modules/Home/ProductsScreen.dart';
import 'package:ecommerce/modules/Settings/Settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutStates>{
  ShopLayoutCubit() : super(ShopLayoutInitialState());
static ShopLayoutCubit get(context)=>BlocProvider.of(context);
int currentindex= 0;
changebottomnavbarcubit( int index){
  currentindex=index;
  emit(ChangeBottomNavBar());
}
List<Widget> Screens=[
  ProductsScreen(),
  Categories(),
  Favorites(),
  Settings()
];
}