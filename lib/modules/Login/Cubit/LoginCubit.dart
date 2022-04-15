

import 'package:bloc/bloc.dart';
import 'package:ecommerce/DioHelper.dart';
import 'package:ecommerce/EndPoints.dart';
import 'package:ecommerce/models/ShopLoginModel.dart';
import 'package:ecommerce/modules/Login/Cubit/LoginState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit() : super(LoginInitialState());
  ShopLoginModel? shopLoginModel;
static LoginCubit get(context)=>BlocProvider.of(context);
login({@required String? email , @required String?password}){
  emit(LoginLoadingState());
  DioHelper.postData(url: LOGIN, data: {
    'email':email,
    'password':password
  }).then((value)
  {
   shopLoginModel= ShopLoginModel.fromApi(value.data);
    emit(LoginSuccessState(shopLoginModel));
  }
  ).catchError((onError){print(onError);
    emit(LoginErrorState(onError.toString()));
  });
}
}