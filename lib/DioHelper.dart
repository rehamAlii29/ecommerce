import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper{
static Dio? dio;
static init()
{
  dio = Dio(
    BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
// مكتبتش هنا هيدر ليه ؟ عشان الهيدر اللى فى البوست والجت هتشيل دى وتكتب مكانها
    // طب ليه مكتبتش هنا الهيدر مرة واحدة وخلاص بدل ما اكتبها مع كل ريكسوت ؟ عشان لو عايزة ادخل authorization

    )
  );
}
static Future<Response> getData({@required String?url ,
  @required Map<String, dynamic>? query ,
String? lang='en',
  String?token
})async{
  dio!.options.headers={
    'Content-Type':'application/json',
    'lang':lang,
    'Authorization':token??''
  };
  return  await dio!.get(url!, queryParameters: query);
}
static Future<Response> postData({
  @required String?url ,
 Map<String, dynamic>? query,
  @required Map<String, dynamic>? data,
  String? lang='en',
  String?token// elly hab3tha fel post :D
})async {
  dio!.options.headers={
    'Content-Type':'application/json',
    'lang':lang,
    'Authorization':token??''
  };
  return await dio!.post(url!,data: data, queryParameters: query);
}

}
//abdullah.ali@gmail.com