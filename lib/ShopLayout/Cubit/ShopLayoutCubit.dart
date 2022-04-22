

import 'dart:convert';
import 'dart:io';

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
import 'package:ecommerce/models/SearchModel.dart';
import 'package:ecommerce/models/ShopHome.dart';
import 'package:ecommerce/models/ShopLoginModel.dart';
import 'package:ecommerce/modules/Categories/Categories.dart';
import 'package:ecommerce/modules/Favorites/Favorites.dart';
import 'package:ecommerce/modules/Home/ProductsScreen.dart';
import 'package:ecommerce/modules/Settings/Settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutStates>{
  ShopLayoutCubit() : super(ShopLayoutInitialState());
static ShopLayoutCubit get(context)=>BlocProvider.of(context);
int currentindex= 0;
changebottomnavbarcubit( int index){
  currentindex=index;
  if(index ==3)
    getUserInfo();
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
  DioHelper.postData(url: LOGOUT, token: token).then((value) {
CasheHelper.clearCashe(key: 'token');
emit(Logout());
  });
}

  final ImagePicker _picker = ImagePicker();
String? base;
File? profileimage;
Future<void> pickimage()async{
  XFile? xFile = await _picker.pickImage(source: ImageSource.gallery,imageQuality: 50);
  if (xFile != null){
    profileimage=File(xFile.path);
   base = base64Encode(profileimage!.readAsBytesSync());

  }
  emit(Uploadimage());

}
updateProfileImage(){
  emit(UPdateimageLoading());
  DioHelper.updateData(url: UPDADTEPROFILE,
      token:  token,
      data: {
        'name':shopLoginModel!.data!.name ,
        'email':shopLoginModel!.data!.email,
        'phone':shopLoginModel!.data!.phone,
        'image': base
      }).then((value) {

    shopLoginModel = ShopLoginModel.fromApi(value.data);
    emit(UpdateserInformationSuccess());
  });
}

updateUserInfo( {
  @required String ? name,
  @required String ? email,
  @required String ? phone,
}) async{
  emit(UpdateserInformationLoading());
  // if the data in postman sent as form data
 /* String fileName = profileimage!.path.split('/').last;
  FormData formData = FormData.fromMap({
    "image":
    await MultipartFile.fromFile(profileimage!.path, filename:fileName,
       contentType: MediaType.parse("image/png",)
    )
  });*/
  DioHelper.updateData(url: UPDADTEPROFILE,
      token:  token,
      data: {
    'name':name ,
    'email':email,
    'phone':phone,
      //  'image': base
  }).then((value) {

    shopLoginModel = ShopLoginModel.fromApi(value.data);
    emit(UpdateserInformationSuccess());
  });

}
SearchModel? searchModel;
search({@required searchKey})
{
emit(SearchResultLoading());
DioHelper.postData(url: SEARCH, data: {
  'text': searchKey
}, token: token).then((value) {
  searchModel = SearchModel.fromjson(value.data);
  emit(SearchResultSuccess());
});
}


}