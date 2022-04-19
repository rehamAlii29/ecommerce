import 'package:ecommerce/ShopLayout/Cubit/ShopLayoutCubit.dart';
import 'package:ecommerce/ShopLayout/Cubit/ShopLayoutStates.dart';
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
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.account_box_rounded),
                labelText: "UserName",
                border: OutlineInputBorder()
            ),
          ),
          SizedBox(height: 10,),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: "email",
                border: OutlineInputBorder()
            ),
          ),
          SizedBox(height: 10,),
          TextFormField(
            controller: phoneController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone),
                labelText: "phone number",
                border: OutlineInputBorder()
            ),
          )
          ,
          SizedBox(height: 20,),
          ElevatedButton(onPressed: (){}, child: Text("LogOut"))

        ],),
      );
    },
        listener: (context,state){});
  }
}
