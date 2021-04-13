import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:complegate/app/AppConstants.dart';
import 'package:complegate/app/AppPreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:complegate/app/HttpClient.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../main.dart';

class ThankuPage extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return  ThankuPageState();
  }
}

class  ThankuPageState extends State<ThankuPage> {


  var mobileno;

  bool _passwordVisible;
  final kTitleStyle = TextStyle(
      color: Colors.black,
      fontSize: 16.0,
      height: 1.5,
      fontFamily: "Product Sans");
  final kTitleStylesign = TextStyle(
      color: Colors.greenAccent,
      fontSize: 16.0,
      height: 1.5,
      fontFamily: "Product Sans");

  @override
  void initState() {


    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _load = false;

  String validatpassword(String value) {
    if (value.length == 0) {
      return 'Enter key';
    }
    return null;
  }

  String Code;
  String Code1;

  void navigationPage() {
    //  Navigator.of(context).pushReplacementNamed(HOME_SCREEN);
  }

  @override
  Widget build(BuildContext context) {
    var Height = MediaQuery.of(context).size.height;
    var Width = MediaQuery.of(context).size.width;
    String optvalue1,otpvalue2;
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/imgapp/thanku.jpg"),
            fit: BoxFit.cover,
          ),
        ),

      ),
    );
  }
}
