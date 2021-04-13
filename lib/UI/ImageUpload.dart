import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:complegate/app/AppConstants.dart';
import 'package:complegate/app/AppPreferences.dart';

import 'package:complegate/app/HttpClient.dart';
import 'package:complegate/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'BackImage.dart';

class ImageUpload extends StatefulWidget {
  final CameraDescription camera;
  const ImageUpload({
    Key key, @required this.camera,}) : super(key: key);


  @override
   createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  ProgressDialog pr;

  var image=null;
  bool flag, flagcamera;
  int _counter = 0;
  List<int> imageBytes;
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  @override
  Future<void> initState()  {

    super.initState();
    flag=false;
    flagcamera = true;
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

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }
  final kTitleStyle = TextStyle(
    color: Colors.black,
    fontSize: 15.0,
    fontWeight: FontWeight.bold,
    height: 1.5,
    //  fontFamily: "Product Sans"
  );
Future<void> cameradata() async {
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;


}
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
        actions: [
          InkWell(onTap: (){},
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: IconButton(icon: Icon(Icons.camera_alt_outlined,color: Colors.white,),onPressed: () async {
                final cameras = await availableCameras();
                final firstCamera = flagcamera?cameras[1]:cameras.first;
                setState(() {
                  flagcamera = !flagcamera;
                  _controller = CameraController(firstCamera, ResolutionPreset.medium,);
                  _initializeControllerFuture = _controller.initialize();
                });


                // Get a specific camera from the list of available cameras.C

              },),
            ),
          ),
          InkWell(onTap: (){},
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: IconButton(
                icon: Icon(

                  flag?Icons.flash_off:Icons.flash_on_outlined,
                  color: Colors.white,
                ),onPressed: (){
                setState(() {
                  setState(() {
                    flag = !flag;
                  });
                });

                flag? _controller.setFlashMode(FlashMode.torch):_controller.setFlashMode(FlashMode.off);

              },
              ),
            ),
          ),
          InkWell(onTap: (){},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:10.0),
              child: Icon(Icons.close_rounded,color: Colors.white,),
            ),
          )


        ],
        centerTitle:true ,
        backgroundColor: Colors.pink,
        title: Text("FrontSideImage" ),
      ),
      body:  Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/imgapp/bg.png"),
            fit: BoxFit.cover,
          ),),
        child: Stack(children: <Widget>[

          Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child:  Container(

                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/imgapp/bg.png"),
                            fit: BoxFit.cover,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 20.0,
                                offset: Offset(0, 10)
                            )
                          ]
                      ),

                      child: Column(
                        children: [
                           Container(height: Height*0.10,
                            child: Row(
                              children: [
                                Center(
                                  child: Container(width: Width*0.30,

                                    child: CircularPercentIndicator(
                                      startAngle: 260,
                                      radius: 60.0,
                                      lineWidth: 6.0,
                                      animation: true,
                                      percent: 0.40,
                                      center: new Text(
                                        "2/5",
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
                                      child: Text("FrontSideImage Upload",style: kSubtitleStyle,),
                                    ),
                                    Text("Next:BackSideImage",style: kStyle,)

                                  ],
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),






              )),
          Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child:   Padding(
                  padding: const EdgeInsets.fromLTRB(4, 100, 5, 100),
                  child:image?.path==null? Stack(
                    children:<Widget> [
                      FutureBuilder<void>(
                        future: _initializeControllerFuture,
                        builder: (context, snapshot) {

                            // If the Future is complete, display the preview.
                            return CameraPreview(_controller);
                          }
                            // Otherwise, display a loading indicator.


                      ),
                      Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child:  Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FloatingActionButton(
onPressed: () async {
    try {
    // Ensure that the camera is initialized.
    await _initializeControllerFuture;


     image = await _controller.takePicture();
     setState(() {
       //print(image);
       image;

     });
     File file = File(image?.path);
     imageBytes = await file.readAsBytesSync();
    String imagecode= base64Encode(imageBytes);
if(imageBytes!=null) {
  HttpClient().baseimageupload(imagecode).then((value) {
    setState(() {
      var response = jsonDecode(value);
      AppPreferences.setString(AppConstants.SecondPageData, response['url'].toString()??"Null");
      print(response['url']);
      //  _list.add(e);

    });
  });
}
    // If the picture was taken, display it on a new screen.

    } catch (e) {
    // If an error occurs, log the error to the console.
    print(e);
    }
    },
                                backgroundColor: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.camera_alt_outlined,color: Colors.black,),
                                ),
                              ),
                            )






                          )),
                    ],
                  ):Image.file(File(image?.path)),
                ),




              )),
          Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: Height*0.110,
                  child:



                  Column(
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
    ImageBkUpload(camera: widget.camera,)
    ),
    );});});






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
                                            MyHomePage(camera: widget.camera,)
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

                ),)




          )
        ]),
      ),


      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

