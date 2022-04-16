import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce/Reusable/Reusable.dart';
import 'package:ecommerce/Shared/Network/Local/CasheHelper.dart';
import 'package:ecommerce/modules/Login/Cubit/LoginCubit.dart';
import 'package:ecommerce/modules/Login/Cubit/LoginState.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:motion_toast/motion_toast.dart';

import '../../ShopLayout/ShopLayout.dart';

var emailController=TextEditingController();
var passwordController=TextEditingController();
var formKey = GlobalKey<FormState>();
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // SystemChrome.setEnabledSystemUIOverlays([]);

    return BlocProvider(
      create: (context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit , LoginState>(
      listener: (context , state){
        if(state is LoginSuccessState)
          {
            if(state.shopLoginModel!.status!)
              {
                MotionToast.success(

                    description:  Text(state.shopLoginModel!.message!),
                    width:  300
                ).show(context);
CasheHelper.saveDate(key: 'token', value: state.shopLoginModel!.data!.token);
navigationandclose(context, ShopLayout());
              }
            else
              {
                MotionToast.warning(

                    description:  Text(state.shopLoginModel!.message!)
                ).show(context);

              }
          }
      },
        builder: (context, state){
        return   Scaffold(
          backgroundColor: HexColor('FFFFFF'),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  ClipRRect
                    (//borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft:Radius.circular(30) ),
                      child: Image.asset('assets/images/vector1.png',)),
                  Image.asset('assets/images/vector2.png',),
                  Positioned(
                      top: 396,
                      left: 21,
                      //   height: 420,
                      width: 360,
                      child: Text("Login", style: GoogleFonts.nunito(color: HexColor('2F80ED'),
                          fontSize: 36
                          ,fontWeight: FontWeight.bold
                      )
                      )),


                ],),

                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[


                      Padding(
                        padding: const EdgeInsets.only(left: 25, bottom:2 , ),
                        child: Text(
                            "E-mail",

                            style: GoogleFonts.nunito(color: HexColor('2F80ED'),
                                fontSize: 14
                                ,fontWeight: FontWeight.normal
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Container(

                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(

                                border: Border.all(color:HexColor('2F80ED') ),
                                borderRadius: BorderRadius.circular(10)

                            ),

                            width: 309,
                            height: 40,
                            child: TextFormField(
                              controller: emailController,
                              validator: (value){
                                if(value!.isEmpty)
                                  return "Please Enter Your e-mail";
                              },
                              decoration: const InputDecoration(border:InputBorder.none ),
                            )),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 25, bottom:2 ,top: 10 ),
                        child: Text(
                            "password",

                            style: GoogleFonts.nunito(color: HexColor('2F80ED'),
                                fontSize: 14
                                ,fontWeight: FontWeight.normal
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Container(
                            decoration: BoxDecoration(border: Border.all(color:HexColor('2F80ED') ),
                                borderRadius: BorderRadius.circular(10)),
                            width: 309,
                            height: 40,
                            child: TextFormField(
                              controller: passwordController,
                              validator: (value){
                                if(value!.isEmpty)
                                  return "Please Enter Your password";
                              },
                              decoration: const InputDecoration(
                                  border: InputBorder.none

                              ),
                            )),
                      ),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 217, top: 17.5, bottom: 17.5),
                  child:   Text("Forgot Password ?",style: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.bold, color:HexColor('2F80ED') ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:25 ),
                  child:   Row(children: [

                    InkWell(child: Image.asset('assets/images/google logo.png', width: 45, height: 45,), onTap: (){},),
                    InkWell(child: Image.asset('assets/images/fb logo.png', width: 45, height: 45,), onTap: (){},),
                    InkWell(child: Image.asset('assets/images/apple logo.png', width: 45, height: 45,), onTap: (){},),


                  ],),
                ),
                Stack(

                  children: [
                    Image.asset('assets/images/vector3.png',),
                    Positioned
                      (
                        left: 24,
                        width: 161,
                        height: 34,
                        bottom: 10,
                        child: InkWell(
                          onTap: (){},
                          child: Row(children: [ Text("New Here?", style: GoogleFonts.nunito(fontSize: 16, color: HexColor('FFFFFF')), ),
                            Text("Register", style: GoogleFonts.nunito(fontSize: 16,fontWeight: FontWeight.bold,  color: HexColor('FFFFFF')),)
                          ],),
                        )),
                    Positioned(
                      left: 257,
                      bottom: 25,
                      child: ConditionalBuilder(
                        condition: state is! LoginErrorState,
                        builder: (context)=>  InkWell(
onTap: (){
  if(formKey.currentState!.validate())
    LoginCubit.get(context).login(email: emailController.text, password: passwordController.text);
  if(state is LoginSuccessState)
    print('done');
},
                          child: Container(

                            decoration: BoxDecoration(
                                boxShadow: kElevationToShadow[1],
                                // color: Theme.of(context).bottomAppBarColor,

                                color:HexColor('2F80ED') ,
                                border:Border.all(
                                    color: HexColor('FFFFFF')
                                ),
                                borderRadius: BorderRadius.circular(7)
                            ),
                            width: 144,
                            height: 60,
                            child: Center(child: Text("Login", style: GoogleFonts.nunito(color:HexColor('FFFFFF'),
                                fontSize: 22, fontWeight: FontWeight.normal) ,)),
                          ),
                        ),
                        fallback: (context)=> const Center(child: const CircularProgressIndicator(),),

                      ),
                    ),


                  ],)
              ],),
          ),
        );
        },
      ),
    );
  }
}
