import 'dart:convert';

import 'package:complegate/app/AppPreferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:camera/camera.dart';


import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'UI/ImageUpload.dart';
import 'UI/LoginPage.dart';
import 'app/AppConstants.dart';
import 'app/HttpClient.dart';
import 'model/countrylist.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;
  // Obtain a list of the available cameras on the device.

  runApp(MyApp(
    camera: firstCamera,
  ));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;

  const MyApp({
    Key key,
    @required this.camera,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(camera: camera,),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final CameraDescription camera;

  const MyHomePage({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<String> countryname = [];
  Countrylist countrylist;
  String dropdownValue;
  List<Countrylist> _list;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> _lists = new List();
  TextEditingController textvisano = TextEditingController();
  TextEditingController tetvisatype = TextEditingController();
  TextEditingController textstartdate = TextEditingController();
  TextEditingController tetexpiredate = TextEditingController();

  @override
  void initState() {
    _list = new List();
    countryname = new List();

    AppPreferences.getString(AppConstants.token).then((value) {
      setState(() {
        HttpClient().userloginbytoken(value).then((value) {
          setState(() {
            var response = jsonDecode(value);





            // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MyHomePage(camera: widget.camera,)),

            //  _list.add(e);
          });
        });
      });
    });




        // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MyHomePage(camera: widget.camera,)),

        //  _list.add(e);





    HttpClient().countrylist().then((source) => {
          setState(() {
            print("listdata${_list.length}");
            List<dynamic> response = jsonDecode(source);
            response.map((e) {
              //  _list.add(Countrylist.fromJson(e));

              countryname.add(e['countryname']);

              print(countryname.length);
              return Countrylist.fromJson(e);
            }).toList();

            print("listdata${_list.length}");
          })
        });

    super.initState();
  }

  final kTitleStyle = TextStyle(
    color: Colors.black,
    fontSize: 15.0,
    fontWeight: FontWeight.bold,
    height: 1.5,
    //  fontFamily: "Product Sans"
  );

  final kSubtitleStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
      height: 1.2,
      fontFamily: "Product Sans");
  final kStyle = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 10.0,
      height: 1.2,
      fontFamily: "Product Sans");
  final kdropStyle = TextStyle(
      color: Colors.pink,
      fontWeight: FontWeight.bold,
      fontSize: 12.0,
      height: 1.1,
      fontFamily: "Product Sans");

  String validatvisano(String value) {
    if (value.length == 0) {
      return 'Enter visa';
    }
    return null;
  }
  String validatvisatype(String value) {
    if (value.length == 0) {
      return 'Enter visa type';
    }
    return null;
  }
  String validatstartdate(String value) {
    if (value.length == 0) {
      return 'Select Start Date';
    }
    return null;
  }
  String validatenddate(String value) {
    if (value.length == 0) {
      return 'Select End Date';
    }
    return null;
  }
  String validatcountry(String value) {
    if (value.length == 0) {
      return 'Select Country';
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {


     // onChanged(_transaction.text);

    var Height = MediaQuery.of(context).size.height;
    var Width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pink,
        title: Text("Add Visa Details"),
      ),

      body:
      Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: ListView(

          children: [
            Container(
              height: Height*0.7658,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/imgapp/bg.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: ListView(
shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: <Widget>[



                        Card(
                          child: Container(
                            height: Height * 0.10,
                            child: Row(
                              children: [
                                Center(
                                  child: Container(
                                    width: Width * 0.30,
                                    child: CircularPercentIndicator(
                                      startAngle: 260,
                                      radius: 60.0,
                                      lineWidth: 6.0,
                                      animation: true,
                                      percent: 0.20,
                                      center: new Text(
                                        "1/5",
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.0),
                                      ),
                                      circularStrokeCap: CircularStrokeCap.round,
                                      progressColor: Colors.green,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Visa Information",
                                        style: kSubtitleStyle,
                                      ),
                                    ),
                                    Text(
                                      "Next:ForntSideImage",
                                      style: kStyle,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          alignment: Alignment.center,
                          child: Image(
                            image: AssetImage('assets/imgapp/logo .png'),
                          ),
                        ),





                            Padding(
                              padding: const EdgeInsets.only(left: 4.0, top: 4),
                              child: Text(
                                "Visa No.*",
                                style: kTitleStyle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 1),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Text("Visa No*",style: TextStyle(color: Colors.black),),

                                  new TextFormField(

                                    decoration: const InputDecoration(
                                      hintText: "RJ80429123",
                                      // labelText: 'Visa'
                                    ),
                                    validator:validatvisano ,
                                    controller: textvisano,
                                    keyboardType: TextInputType.text,

                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0, top: 4),
                              child: Text(
                                "Visa Type.*",
                                style: kTitleStyle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 1),
                              child: new TextFormField(
                                validator:validatvisatype ,
                                decoration: const InputDecoration(
                                  hintText: "Tier 2 General",
                                  //labelText: 'Visa'
                                ),
                                controller: tetvisatype,
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0, top: 4),
                              child: Text(
                                "Start Date.*",
                                style: kTitleStyle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 1),
                              child:
                              new TextFormField(
                                readOnly: true,
                                validator:validatstartdate ,
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1947, 12),
                                    lastDate: DateTime(2199, 12),
                                  ).then((pickedDate) {
                                    textstartdate.text =
                                        DateFormat.yMMMd().format(pickedDate);
                                  });
                                },
                                decoration: const InputDecoration(
                                  suffixIcon: Icon(Icons.date_range),
                                  hintText: "Start Date",
                                  // labelText: 'Visa'
                                ),
                                controller: textstartdate,

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0, top: 4),
                              child: Text(
                                "Expiry Date.*",
                                style: kTitleStyle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 4),
                              child: new TextFormField(
                                readOnly: true,
                                validator:validatenddate ,
                                onTap: () {
                                  textstartdate.text.isNotEmpty?
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate:DateTime.now(),
                                    lastDate: DateTime(2199, 12),
                                  ).then((pickedDate) {
                                    tetexpiredate.text =
                                        DateFormat.yMMMd().format(pickedDate);
                                  }):
                                  Fluttertoast.showToast(
                                      msg: "Fill Start Date First",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.SNACKBAR,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.white,
                                      textColor: Colors.pink,
                                      fontSize: 16.0
                                  );
                                },
                                decoration: const InputDecoration(

                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.date_range),
                                  ),
                                  hintText: "Expiry Date",
                                  // labelText: 'Visa'
                                ),
                                controller: tetexpiredate,

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0, top: 4),
                              child: Text(
                                "Select visa Country*",
                                style: kTitleStyle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child:
                              Container(
                                width: Width-10,
                                child: DropdownButton<String>(
                                  value: dropdownValue,
                                  icon: const Icon(Icons.arrow_drop_down,color: Colors.pink,),
                                  iconSize: 24,
                                  hint: Text('Select Country'),
                                  elevation: 10,
                                  style: const TextStyle(color: Colors.black),
                                  underline: Container(

                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                  onChanged: (Value) {
                                    setState(() {
                                      print(Value);
                                      dropdownValue = Value;
                                    });
                                  },
                                  items: countryname.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(

                                      value: value,
                                      child: Text(value,),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),





            ),
            Container(

              child: Column(
                children: [
                  Text(
                    "Powered by Complygate",
                    style: TextStyle(fontSize: 11),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Container(
                    height: Height * 0.070,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Map params = Map<String, dynamic>();
                          params['visaname'] = textvisano.text;
                          params['visatype'] = tetvisatype.text;
                          params['visastartdate'] = textstartdate.text;
                          params['visaexpiredate'] = tetexpiredate;
                          params['visacountry'] = "";

                          print(_list);
                          AppPreferences.setString(
                              AppConstants.visanumber, textvisano.text);
                          AppPreferences.setString(
                              AppConstants.visatype, tetvisatype.text);
                          AppPreferences.setString(
                              AppConstants.visastartdate, textstartdate.text);
                          AppPreferences.setString(
                              AppConstants.visaenddate, tetexpiredate.text);


                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => ImageUpload(camera: widget.camera)),
                          );}
                      },
                      color: Colors.pink,
                      child: Center(
                          child: Container(
                            alignment: Alignment.center,
                            width: Width,
                            child: Text(
                              "Next",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
