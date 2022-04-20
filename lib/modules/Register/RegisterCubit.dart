import 'package:bloc/bloc.dart';
import 'package:ecommerce/DioHelper.dart';
import 'package:ecommerce/EndPoints.dart';
import 'package:ecommerce/models/ShopLoginModel.dart';
import 'package:ecommerce/modules/Register/RegisterState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState>{
  RegisterCubit() : super(initialRegister());
  static RegisterCubit get(context)=> BlocProvider.of(context);
ShopLoginModel ? shopLoginModel ;
register ({
    @required String ?name ,
    @required String ?password ,
    @required String ?email ,
    @required String ?phone ,
}){
  DioHelper.postData(url: REGISTER,

      data: {
    'name':name,
    'password': password,
    'email' :email,
    'phone':phone,
  }).then((value) {
    shopLoginModel = ShopLoginModel.fromApi(value.data);
    emit(successRegister(shopLoginModel));
  });
}

}