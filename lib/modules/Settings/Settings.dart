import 'package:ecommerce/Reusable/Reusable.dart';
import 'package:ecommerce/ShopLayout/Cubit/ShopLayoutCubit.dart';
import 'package:ecommerce/ShopLayout/Cubit/ShopLayoutStates.dart';
import 'package:ecommerce/modules/Login/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}
var nameController= TextEditingController();
var emailController= TextEditingController();
var phoneController= TextEditingController();
class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(builder: (context , state){
     nameController.text =ShopLayoutCubit.get(context).shopLoginModel!.data!.name!;
     emailController.text =ShopLayoutCubit.get(context).shopLoginModel!.data!.email!;
    phoneController.text =ShopLayoutCubit.get(context).shopLoginModel!.data!.phone!;
   return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            if(state is UpdateserInformationLoading )
              LinearProgressIndicator(),
          Row(
            mainAxisAlignment:  MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar( radius:  50,
                    backgroundImage:
                    NetworkImage(ShopLayoutCubit.get(context).shopLoginModel!.data!.image!),),
                  Positioned( left: 60,
                      child: InkWell(
                        onTap: (){
                          ShopLayoutCubit.get(context).pickimage().then((value) {
                            if(ShopLayoutCubit.get(context).profileimage.toString() != null)
                            {
                              showDialog(context: context,
                                  builder: (context){
                                    return Dialog(

                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                        elevation: 16,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min
                                          ,children: [
                                          Image(image:

                                          FileImage(ShopLayoutCubit.get(context).profileimage!)),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround
                                            , children: [
                                            ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor: MaterialStateProperty.all(Colors.green)
                                                )
                                                ,onPressed: (){
                                              ShopLayoutCubit.get(context).updateProfileImage();
                                              Navigator.of(context, rootNavigator: true).pop();
                                            }, child: Text ("okay")),
                                            ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor: MaterialStateProperty.all(Colors.red)
                                                )
                                                ,onPressed: (){
                                              Navigator.of(context, rootNavigator: true).pop();
                                            }, child: Text ("cancle"))
                                          ],)
                                        ],)
                                    );
                                  });
                            }

                          });

                        },
                        child: const CircleAvatar(
                          radius: 15,
                          backgroundImage: AssetImage('assets/images/camera.png'),

                        ),
                      ))
                ],
              ),
          

          ],),
Padding(
  padding: const EdgeInsets.all(20.0),
  child:   Column(children: [

    const SizedBox(height: 10,),

    TextFormField(

      controller: nameController,

      decoration: const InputDecoration(

          prefixIcon: Icon(Icons.account_box_rounded),

          labelText: "UserName",

          border: OutlineInputBorder()

      ),

    ),

    const SizedBox(height: 10,),

    TextFormField(

      controller: emailController,

      decoration: const InputDecoration(

          prefixIcon: Icon(Icons.email),

          labelText: "email",

          border: OutlineInputBorder()

      ),

    ),

    const SizedBox(height: 10,),

    TextFormField(

      controller: phoneController,

      decoration: const InputDecoration(

          prefixIcon: const Icon(Icons.phone),

          labelText: "phone number",

          border: const OutlineInputBorder()

      ),

    )

    ,

    const SizedBox(height: 20,),
    ElevatedButton(onPressed: (){

    ShopLayoutCubit.get(context).updateUserInfo(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text
      );



    }, child: const Text("Update")),
    const SizedBox(height: 20,),
    ElevatedButton(onPressed: (){

      ShopLayoutCubit.get(context).logOut();

      navigationandclose(context, const LoginScreen());

    }, child: const Text("LogOut"))

  ],),
)


        ],),
      );
    },
        listener: (context,state){});
  }
}
