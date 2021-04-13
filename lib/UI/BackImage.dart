import 'dart:convert';
import 'dart:io';
import 'package:complegate/app/HttpClient.dart';
import 'package:camera/camera.dart';
import 'package:complegate/UI/ImageUpload.dart';
import 'package:complegate/UI/Selfie.dart';
import 'package:complegate/app/AppConstants.dart';
import 'package:complegate/app/AppPreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ImageBkUpload extends StatefulWidget {
  final CameraDescription camera;
  const ImageBkUpload({
    Key key, @required this.camera,}) : super(key: key);



  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".



  @override
  createState() => _ImageBkUploadState();
}

class _ImageBkUploadState extends State<ImageBkUpload> {
  ProgressDialog pr;
  int _counter = 0;
  bool flag,flagcamera;
var image=null;
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  @override
  Future<void> initState()  {

    super.initState();
    flag=false;
    flagcamera=false;
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );
    // To display the current output from the Camera,
    // create a CameraController.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  Future<void> cameradata() async {
    final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    final firstCamera = cameras.first;


    // Next, initialize the controller. This returns a Future.

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
              child:  IconButton(
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
              child: IconButton(icon: Icon(Icons.close_rounded,color: Colors.white,),onPressed: (){
               // _controller.dispose();
              },),
            ),
          )


        ],
        centerTitle:true ,
        backgroundColor: Colors.pink,
        title: Text("Back Side Image" ),
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
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/imgapp/bg.png"),
                      fit: BoxFit.cover,
                    ),),
                  child: Column(
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
                                  percent: 0.60,
                                  center: new Text(
                                    "3/5",
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
                                  child: Text("Back Side Image Upload",style: kSubtitleStyle,),
                                ),
                                Text("Next:Upload Selife Image",style: kStyle,)

                              ],
                            ),
                          ],
                        ),
                      ),),

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

                            // Otherwise, display a loading indicator.


                        },
                      ),
                      Positioned.fill(
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child:  Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FloatingActionButton(
                                  onPressed: () async {
                                    // Ensure that the camera is initialized.
                                    await _initializeControllerFuture;
                                    image = await _controller.takePicture();
                                    setState(() {
                                      print(image);
                                      image;
                                    });
                                    File file= File(image?.path);
                                    List<int> imageBytes = file.readAsBytesSync();
                                    print(imageBytes);
                                    HttpClient().baseimageupload(base64Encode(imageBytes)).then((value) {
                                      setState(() {
                                        var response = jsonDecode(value);
                                        AppPreferences.setString(AppConstants.ThirdPageData, response['url'].toString()??"Null");
                                        print(response);
                                        //  _list.add(e);

                                      });

                                    });

                                  }

                                  ,
                                  backgroundColor: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.camera_alt_outlined),
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
                              child: RaisedButton(onPressed:() async {
                                final cameras = await availableCameras();
                                final vCamera = cameras[1];
                                pr.show();
                                Future.delayed(Duration(seconds: 2))
                                    .then((value) {
                                  pr.hide().whenComplete(() {

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              SelfieUpload(camera: vCamera,)
                                      ),
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
                                            ImageBkUpload(camera: widget.camera,)
                                    ),
                                  );});});


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

