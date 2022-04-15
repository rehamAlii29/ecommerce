import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

navigationandclose(BuildContext context,Widget widget)=>
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>widget));