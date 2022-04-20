 import '../../models/ShopLoginModel.dart';

abstract class RegisterState {}
class initialRegister extends RegisterState{}
 class successRegister extends RegisterState{
 ShopLoginModel ? shopLoginModel;
 successRegister(this.shopLoginModel);
 }