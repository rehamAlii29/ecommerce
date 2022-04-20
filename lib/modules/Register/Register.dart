import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce/Components/Const.dart';
import 'package:ecommerce/DioHelper.dart';
import 'package:ecommerce/Reusable/Reusable.dart';
import 'package:ecommerce/Shared/Network/Local/CasheHelper.dart';
import 'package:ecommerce/ShopLayout/ShopLayout.dart';
import 'package:ecommerce/modules/Register/RegisterCubit.dart';
import 'package:ecommerce/modules/Register/RegisterState.dart';
import 'package:ecommerce/modules/Settings/Settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:motion_toast/motion_toast.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}
var name = TextEditingController();
var email = TextEditingController();
var password = TextEditingController();
var phone = TextEditingController();
var formKey=GlobalKey<FormState>();
class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
  return  BlocProvider(create: (context) => RegisterCubit(),
    child: BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context , state){
        if(state is successRegister){
          if(state.shopLoginModel!.status!){
            CasheHelper.saveDate(key: 'token', value: state.shopLoginModel!.data!.token).then((value){
             // token = state.shopLoginModel!.data!.token;
              MotionToast.success(
                  description: Text(state.shopLoginModel!.message!)
              );
            });

          navigationandclose(context,ShopLayout());}
          else{
            MotionToast.error(description: Text(state.shopLoginModel!.message!));
          }
        }


      },
      builder: (context , state){
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
                      child: Text("SignUp", style: GoogleFonts.nunito(color: HexColor('2F80ED'),
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
                              controller: email,
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
                            "Name",

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
                              controller: name,
                              validator: (value){
                                if(value!.isEmpty)
                                  return "Please Enter Your password";
                              },
                              decoration: const InputDecoration(
                                  border: InputBorder.none

                              ),
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
                              controller: password,
                              validator: (value){
                                if(value!.isEmpty)
                                  return "Please Enter Your password";
                              },
                              decoration: const InputDecoration(
                                  border: InputBorder.none

                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, bottom:2 ,top: 10 ),
                        child: Text(
                            "Phone",

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
                              controller: phone,
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


                Stack(

                  children: [
                    Image.asset('assets/images/vector3.png',),

                    Positioned(
                      left: 257,
                      bottom: 25,
                      child: ConditionalBuilder(
                        condition: true,
                        builder: (context)=>  InkWell(
                          onTap: (){
                            if(formKey.currentState!.validate())
                              RegisterCubit.get(context).register(name: name.text,
                                  password: password.text,
                                  email: email.text,
                                  phone: phone.text);
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
                            child: Center(child: Text("SignUp", style: GoogleFonts.nunito(color:HexColor('FFFFFF'),
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
