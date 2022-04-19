

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/Components/Const.dart';
import 'package:ecommerce/DioHelper.dart';
import 'package:ecommerce/EndPoints.dart';
import 'package:ecommerce/Shared/Network/Local/CasheHelper.dart';
import 'package:ecommerce/ShopLayout/Cubit/ShopLayoutStates.dart';
import 'package:ecommerce/models/Categories.dart';
import 'package:ecommerce/models/Favorites.dart';
import 'package:ecommerce/models/GetFavModel.dart';
import 'package:ecommerce/models/ShopHome.dart';
import 'package:ecommerce/models/ShopLoginModel.dart';
import 'package:ecommerce/modules/Categories/Categories.dart';
import 'package:ecommerce/modules/Favorites/Favorites.dart';
import 'package:ecommerce/modules/Home/ProductsScreen.dart';
import 'package:ecommerce/modules/Settings/Settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
List<String> Titles= ["Home", "Categories" , " Favorites", "Setting"];

ShopHomeModel? shopHomeModel;
Map<int , bool> FavoritesList ={};
getHomeData(){
  emit(ShopLayoutLoadingState());
  DioHelper.getData(url: HOME,token: token ).then((value)  {
print(token);
  shopHomeModel=  ShopHomeModel.fromApi(value.data as Map<String,dynamic>);
  for(var elemnt in shopHomeModel!.data!.products!){
FavoritesList.addAll({
  elemnt.id! : elemnt.in_favorites!

});
  }
  print(FavoritesList.toString());
    emit(ShopLayoutSuccessState());
  });
}
CategoriesModel? categories ;

getCategories(){
  DioHelper.getData(url:CATEGORIES ,).then((value) {
    categories =CategoriesModel.fromApi(value.data);

    emit(getcategoriessuccess());
  }
  );

}
ChangeFavorites? favorites;
changeFavorites(int? productID){
  FavoritesList[productID!]= ! FavoritesList[productID]!;
  emit(ChangFavStatus());

  DioHelper.postData(url: CHANGEFAVORITES, data: {
    'product_id' :productID
  },
    token: token
  ).then((value) {
    favorites= ChangeFavorites.fromApi(value.data);
    if(!favorites!.status!){
      FavoritesList[productID]= ! FavoritesList[productID]!;
    }
    else{
      getFav();
    }
    emit(ChanFavSuccessState(favorites));
    print(value.data);
  }
  ).catchError((onError){
    FavoritesList[productID]= ! FavoritesList[productID]!;
    emit(ChanfeFavErrorState(onError.toString()));
  });
}
GetFavModel? getFavModel;
getFav(){
  emit(GetFavLoading());
  DioHelper.getData(url: GETFAV, token: token).then((value){
    getFavModel =GetFavModel.fromJson(value.data);
    print(value.data.toString());
    emit(GetFavsuccess());
  });
}
ShopLoginModel? shopLoginModel;
getUserInfo(){
DioHelper.getData(url: GETPROFILE, token: token).then((value) {
  shopLoginModel = ShopLoginModel.fromApi(value.data);
  emit(GetUserInfoSuceessState());
});
}
logOut(){
  DioHelper.getData(url: LOGOUT, token: token).then((value) {
CasheHelper.clearCashe(key: 'token');
emit(Logout());
  });
}
}