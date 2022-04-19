import 'package:ecommerce/DioHelper.dart';
import 'package:ecommerce/Shared/Network/Local/CasheHelper.dart';
import 'package:ecommerce/ShopLayout/Cubit/ShopLayoutCubit.dart';
import 'package:ecommerce/ShopLayout/Cubit/ShopLayoutStates.dart';
import 'package:ecommerce/modules/Login/LoginScreen.dart';
import 'package:ecommerce/modules/OnBoarding.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/services.dart';

import 'Components/Const.dart';
import 'ShopLayout/ShopLayout.dart';
void main () async
{
  WidgetsFlutterBinding.ensureInitialized();
//  await ScreenUtil.ensureScreenSize();
 DioHelper.init();
await CasheHelper.init();
 SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, ),);
 bool? onboarding= CasheHelper.getData(key: 'onBoarding');
 token = CasheHelper.getData(key: 'token');
 print(token);
 Widget? startWidget;
 if(onboarding != null)
   {
     if(token!= null)
       {
         startWidget = ShopLayout();
       }
     else
       {
         startWidget = LoginScreen();
       }
   }else
     startWidget = OnBoarding();

 runApp(ECommerce(startWidget: startWidget,));
}
class ECommerce extends StatelessWidget {
  final   Widget? startWidget;
  ECommerce({this.startWidget});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>ShopLayoutCubit()..getHomeData()..getCategories()..getFav()..getUserInfo(),
      child:   BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
        listener: (context, state){},
        builder: (context, state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            useInheritedMediaQuery: true,
            theme: ThemeData(

              scaffoldBackgroundColor:HexColor('FFFFFF'),
              textTheme:  GoogleFonts.openSansTextTheme(
                Theme.of(context).textTheme, // If this is not set, then ThemeData.light().textTheme is used.
              ),
            ),
            home: startWidget,);
        },
      )
    );
  }
}
