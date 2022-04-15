import 'package:ecommerce/DioHelper.dart';
import 'package:ecommerce/modules/OnBoarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/services.dart';
void main () async
{
  WidgetsFlutterBinding.ensureInitialized();
//  await ScreenUtil.ensureScreenSize();
 DioHelper.init();

 SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,

  ),

  );
 runApp(ECommerce());
}
class ECommerce extends StatefulWidget {


  @override
  State<ECommerce> createState() => _ECommerceState();
}

class _ECommerceState extends State<ECommerce> {
  @override
  Widget build(BuildContext context) {

     return MaterialApp(
        debugShowCheckedModeBanner: false,
       useInheritedMediaQuery: true,
        theme: ThemeData(

          scaffoldBackgroundColor:HexColor('FFFFFF'),
              textTheme:  GoogleFonts.openSansTextTheme(
                Theme.of(context).textTheme, // If this is not set, then ThemeData.light().textTheme is used.
              ),
        ),
        home: OnBoarding(),
      );}


}
