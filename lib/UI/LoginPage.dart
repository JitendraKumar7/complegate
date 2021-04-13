import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:complegate/app/AppConstants.dart';
import 'package:complegate/app/AppPreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:complegate/app/HttpClient.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../main.dart';

class LoginPage extends StatefulWidget {
  final CameraDescription camera;

  const LoginPage({
    Key key,
    @required this.camera,
  });

  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  TextEditingController code1 = TextEditingController();
  TextEditingController code2 = TextEditingController();
  TextEditingController code3 = TextEditingController();
  TextEditingController code4 = TextEditingController();
  TextEditingController code5 = TextEditingController();
  TextEditingController code6 = TextEditingController();
  TextEditingController code7 = TextEditingController();
  TextEditingController code8 = TextEditingController();

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
    _passwordVisible = false;
    mobileno = widget.camera;

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
            image: AssetImage("assets/imgapp/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
            key: _formKey,
            child: ListView(
             shrinkWrap: true,
              children: [
                Container(
                  height:Height*.8275,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: Height * 0.02,
                      ),
                      Container(
                        height: 40,
                        alignment: Alignment.center,
                        child: Image(
                          image: AssetImage('assets/imgapp/logo .png'),
                        ),
                      ),
                      SizedBox(
                        height: Height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "Verify your mobile ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "sent to 82XXXXXX31",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),

                          ],
                        ),
                      ),

                      /* Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 30, 60, 0),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    child: new TextFormField(
                                      validator: validatpassword,
                                      controller: code1,
                                      keyboardType: TextInputType.number,
                                    ),
                                    height: 50,
                                  ),
                                )),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    child: new TextFormField(
                                      validator: validatpassword,
                                      controller: code2,
                                      keyboardType: TextInputType.number,
                                    ),
                                    height: 50,
                                  ),
                                )),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    child: new TextFormField(
                                      controller: code3,
                                      validator: validatpassword,
                                      keyboardType: TextInputType.number,
                                    ),
                                    height: 50,
                                  ),
                                )),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    child: new TextFormField(
                                      validator: validatpassword,
                                      controller: code4,
                                      keyboardType: TextInputType.number,
                                    ),
                                    height: 50,
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 30, 60, 0),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    child: new TextFormField(
                                      validator: validatpassword,
                                      controller: code5,
                                      keyboardType: TextInputType.number,
                                    ),
                                    height: 50,
                                  ),
                                )),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    child: new TextFormField(
                                      validator: validatpassword,
                                      controller: code6,
                                      keyboardType: TextInputType.number,
                                    ),
                                    height: 50,
                                  ),
                                )),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    child: new TextFormField(
                                      validator: validatpassword,
                                      controller: code7,
                                      keyboardType: TextInputType.number,
                                    ),
                                    height: 50,
                                  ),
                                )),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    child: new TextFormField(
                                      validator: validatpassword,
                                      controller: code8,
                                      keyboardType: TextInputType.number,
                                    ),
                                    height: 50,
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),*/
                      SizedBox(
                        height: Height * 0.10,
                      ),
                      Container(
                        child: OTPTextField(

                          length: 4,
                          width: MediaQuery.of(context).size.width-40,
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldWidth: 50,
                          fieldStyle: FieldStyle.underline,
                          style: TextStyle(fontSize: 17),
                          onChanged: (pin) {
                            print("Changed: " + pin);
                          },
                          onCompleted: (pin) {
                            print("Completed: " + pin);

                            Code=pin;
                          },
                        ),
                      ),
                      OTPTextField(

                        length: 4,
                        width: MediaQuery.of(context).size.width-40,
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        fieldWidth: 50,
                        fieldStyle: FieldStyle.underline,
                        style: TextStyle(fontSize: 17),
                        onChanged: (pin) {
                          print("Changed: " + pin);
                        },
                        onCompleted: (pin) {
                          print("Completed: " + pin);
                          Code1=pin;
                        },
                      ),
                      SizedBox(
                        height: Height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "Enter 8 digit code",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
                    child: InkWell(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            gradient:
                            LinearGradient(colors: [Colors.pinkAccent, Colors.pink])),
                        child: Center(
                          child: Text(
                            "Verify",
                            style:
                            TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      onTap: () async {
                        String v1 = code1.text + code2.text + code3.text + code4.text;
                        String v2 = code5.text + code6.text + code7.text + code8.text;
                        if (_formKey.currentState.validate()) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('Verifiying Otp')));

                          HttpClient().usergettoken(Code,Code1).then((value) {
                            setState(() {
                              var response = jsonDecode(value);
                             if( response['status']=="success"){
                               Fluttertoast.showToast(
                                   msg: "Registred Successfully ",
                                   toastLength: Toast.LENGTH_LONG,
                                   gravity: ToastGravity.SNACKBAR,
                                   timeInSecForIosWeb: 1,
                                   backgroundColor: Colors.white,
                                   textColor: Colors.pink,
                                   fontSize: 16.0
                               );

                               Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MyHomePage(camera: widget.camera,)),
                               );
                               AppPreferences.setString(AppConstants.token, response['token'].toString());
                               print(response);
                             }else{
                               Fluttertoast.showToast(
                                   msg: "Retry ",
                                   toastLength: Toast.LENGTH_LONG,
                                   gravity: ToastGravity.SNACKBAR,
                                   timeInSecForIosWeb: 1,
                                   backgroundColor: Colors.white,
                                   textColor: Colors.pink,
                                   fontSize: 16.0
                               );
                             }

                              //  _list.add(e);
                            });
                          });
                        }

                        /*  pr.show();

                                    Future.delayed(Duration(seconds: 2)).then((value) {

                                      pr.hide().whenComplete(() {

                                        _futureAlbum = createAlbum(textphn.text,

                                            tetpass.text);

                                      });

                                    });



  */

                        //Navigator.of(context).pushReplacementNamed(HOME_SCREEN);
                      },
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
