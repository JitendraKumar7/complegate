import 'package:camera/camera.dart';
import 'package:complegate/UI/ThanksScreen.dart';
import 'package:complegate/app/AppConstants.dart';
import 'package:complegate/app/AppPreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'Selfie.dart';

class ReviewUpload extends StatefulWidget {

  final CameraDescription camera;
  const ReviewUpload({
    Key key, @required this.camera,}) : super(key: key);



  @override
  createState() => _ReviewUploadState();
}

class  _ReviewUploadState extends State<ReviewUpload> {
  ProgressDialog pr;
  String Imageupload="" ;
  String Secondupload="" ;
  String Selfieupload="" ;
  int _counter = 0;
  bool data= true;
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  @override
  Future<void> initState()  {

    super.initState();
    AppPreferences.getString(AppConstants.SecondPageData).then((value) {
      setState(() {
        data=false;
        print(Imageupload);
        Imageupload=value;
      });

    });
    AppPreferences.getString(AppConstants.ThirdPageData).then((value) {
      setState(() {
        print(Secondupload);
     Secondupload  = value;
      });

    });
    AppPreferences.getString(AppConstants.SelfieData).then((value) {
      setState(() {
        print(Secondupload);
        Selfieupload  = value;
      });

    });

    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
    // To display the current output from the Camera,
    // create a CameraController.

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
      fontSize: 16.0,
      height: 1.2,
      fontFamily: "Product Sans"
  );
  final kStyle = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 10.0,
      height: 1.2,
      fontFamily: "Product Sans"
  );
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, showLogs: true);
    pr.style(message: 'Loading...');
    var Height= MediaQuery.of(context).size.height;
    var Width= MediaQuery.of(context).size.width;
    return Scaffold(


      appBar: AppBar(
        centerTitle:true ,
        backgroundColor: Colors.pink,
        title: Text("BRP Upload Succesfully"),
      ),
      body:data == true
          ? Container(
        width: MediaQuery.of(context).size.height,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: GFLoader(loaderColorOne: Colors.black26),
        ),
      ) :  Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/imgapp/bg.png"),
            fit: BoxFit.cover,
          ),),
      child: Column(
        children: [
          Container(height:  Height*0.7400,
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Card(child: Container(height: Height*0.10,
                child: Row(
                  children: [
                    Center(
                      child: Container(width: Width*0.30,

                        child: CircularPercentIndicator(
                          startAngle: 260,
                          radius: 60.0,
                          lineWidth: 6.0,
                          animation: true,
                          percent: 1.00,
                          center: new Text(
                            "5/5",
                            style:
                            new TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                          ),

                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: Colors.green,
                        ),

                      ),),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Review Uploading Files",style: kSubtitleStyle,),
                        ),
                        Text("Uploaded Succesfully",style: kStyle,)

                      ],
                    ),
                  ],
                ),
              ),),
                ListView(
                shrinkWrap: true,
                children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(
                        height: 220,
                        width: Width*0.50,
                        child: Padding(

                            padding: const EdgeInsets.symmetric(vertical:10.0,horizontal:8 ),
                            child:Imageupload!=null?Image(image:NetworkImage(Imageupload)):Container(),
                        ),
                      ),
                      Container(
                        height: 220,
                        width: Width*0.50,
                        child: Padding(

                            padding: const EdgeInsets.symmetric(vertical:10.0,horizontal:8 ),
                            child:Secondupload!=null?Image(image:NetworkImage(Secondupload)):Container(),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 220,
                    width: 250,
                    child: Padding(

                        padding: const EdgeInsets.symmetric(vertical:10.0,horizontal:8 ),
                        child:Selfieupload!=null?Image(image: NetworkImage(Selfieupload)):Container(),)

                  ),
                ],
              ),
            ],),
          ),

             Container(

              child: Column(
                children: [
                  Text("Powered by complegate",style: TextStyle(fontSize: 11),),
                  SizedBox(height: 11,),
                  Row(
                    children: [

                      Container(
                        width: Width*0.50,
                        height: Height*0.070,
                        child: RaisedButton(onPressed:(){
                          pr.show();
                          Future.delayed(Duration(seconds: 2))
                              .then((value) {
                            pr.hide().whenComplete(() {

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ThankuPage()),
                              );
                            });});


                        },color: Colors.pink,

                          child: Center(child: Container(alignment: Alignment.center,
                            width:Width*0.40 ,child: Text("NEXT",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight:FontWeight.bold),),)),),
                      ),

                      Container(
                        height: Height*0.070,
                        child: RaisedButton(onPressed:(){

                          pr.show();
                          Future.delayed(Duration(seconds: 2))
                              .then((value) {
                            pr.hide().whenComplete(() {

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SelfieUpload(camera: widget.camera,)
                                ),
                              );
                            });});



                        },color: Colors.black,
                          child: Center(child: Container(alignment: Alignment.center,
                            width:Width*0.40 ,child: Text("PREVIOUS",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight:FontWeight.bold),),)),),
                      ),
                    ],
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

