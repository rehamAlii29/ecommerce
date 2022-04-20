 import 'package:ecommerce/models/Favorites.dart';

abstract class ShopLayoutStates{}
class ShopLayoutInitialState extends ShopLayoutStates{}
 class ShopLayoutLoadingState extends ShopLayoutStates{}
 class ShopLayoutSuccessState extends ShopLayoutStates{}
 class ChangeBottomNavBar extends ShopLayoutStates{}
class getcategoriessuccess extends ShopLayoutStates{}
 class ChanFavSuccessState extends ShopLayoutStates{
 ChangeFavorites? changeFavorites;
 ChanFavSuccessState(this.changeFavorites);
 }
 class ChangFavStatus extends ShopLayoutStates{
 // بسبب اي سبب من الاسباب مثلا
  // ان التوكن متبعتش
 }
 class ChanfeFavErrorState extends ShopLayoutStates{
 String? onError;
 ChanfeFavErrorState(this.onError);
 }
 class GetFavLoading extends ShopLayoutStates{}
 class GetFavsuccess extends ShopLayoutStates{}
 class GetUserInfoSuceessState extends ShopLayoutStates {}
 class Logout extends ShopLayoutStates{}

class UPdateimageSuccess extends ShopLayoutStates{}
 class UpdateserInformationLoading extends ShopLayoutStates{}
 class UpdateserInformationSuccess extends ShopLayoutStates{}