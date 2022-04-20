import 'package:ecommerce/Reusable/Reusable.dart';
import 'package:ecommerce/ShopLayout/Cubit/ShopLayoutCubit.dart';
import 'package:ecommerce/ShopLayout/Cubit/ShopLayoutStates.dart';
import 'package:ecommerce/modules/Login/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        child: Column(children: [
          Row(
            mainAxisAlignment:  MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar( radius:  50,
                    backgroundImage:
                    NetworkImage(ShopLayoutCubit.get(context).shopLoginModel!.data!.image!),),
                  IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt_outlined))
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
