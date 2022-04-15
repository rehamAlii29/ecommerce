import 'package:ecommerce/models/ShopLoginModel.dart';

abstract class LoginState {}
class LoginInitialState extends LoginState{}
class LoginLoadingState extends LoginState{}
class LoginSuccessState extends LoginState{
ShopLoginModel ? shopLoginModel;
LoginSuccessState(this.shopLoginModel);
}
class LoginErrorState extends LoginState{
  final String?onError ;
  LoginErrorState(this.onError);
}