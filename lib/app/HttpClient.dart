import 'dart:convert';
import 'package:dio/dio.dart';

import 'AppConstants.dart';

import 'package:http/http.dart' as http;

class HttpClient extends AppConstants {
  String  tokenbase;


  //final String base = 'https://meo.co.in/meoApiPro/konnectBusiness_v4/index.php/';
  final String base = 'https://devservice.complygate.co.uk/';
  Future<String> usergettoken(String code, String Code1) async {
    Map params = Map<String, dynamic>();


    final http.Response response = await http.post(
      '${base}api/getaccesstoken',

      body: jsonEncode(params),
    );
    var responseas = jsonDecode(response.body);
    tokenbase =responseas['token'].toString();
    print('Response Body ${tokenbase.toString()}');
    return response.body;
  }
  Dio getInstance() {
    return Dio(
      BaseOptions(
        headers: {'contentType': 'multipart/form-data',
      'authorization':tokenbase,
      'access_token':tokenbase},
        baseUrl: base,
        connectTimeout: 90 * 1000,
        receiveTimeout: 60 * 1000,
      ),
    );
  }
  Future<Response<Map>>  getPartyMasterQuotation(  String userid, datestart,dateexpiry,nationalid,visatype,visano,imageselfie,imageback,imagefront,isrighttowork,iscurrent) async {
    FormData formData = new FormData.fromMap({
    'employeeid':userid,
    'visastart':datestart,
    'visaexpiry':dateexpiry,
    'visatype':visatype,
    'visanumber':visano,
    'imagename':imagefront,
    'imagebackname':imageback,
    'visaprofileimage':imageselfie,
    'nationalityid':datestart,
    'iscurrent':iscurrent,
    'isrighttowork':isrighttowork
    });



    Map params = Map<String, dynamic>();



    return await getInstance().post('api/mobilevisaupdate', data:formData);
  }

  Future<String> countrylist() async {
    Map params = Map<String, dynamic>();


    final http.Response response = await http.post(
      '${base}employee/countrylist',

      body: jsonEncode(params),
    );

    print('Response Body ${response.body}');
    return response.body;
  }
  Future<String> sumitdata( String EID,String VisaStrat,String Visaexpiry,String visatype, String visanumber,String visaimg,String imageback,String Imagename,   ) async {
    Map params = Map<String, dynamic>();
    params['employeeid']=EID;
    params['visastart']=VisaStrat;
    params['visaexpiry']=Visaexpiry;
    params['visatype']= visatype;
    params['visanumber']=visanumber;
    params['imagename']=visaimg;
    params['imagebackname']=imageback;
    params['visaprofileimage']=Imagename;
    params['nationalityid']="70";
    params['iscurrent']=0;
    params['isrighttowork']=1;

    final http.Response response = await http.post(
      '${base}api/mobilevisaupdate',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization':tokenbase,
        'access_token':tokenbase
      },
      body:jsonEncode(params),
    );

    /*var request = http.MultipartRequest("POST", Uri.parse('${base}api/mobilevisaupdate'));
    request.headers['authorization']=tokenbase;
    request.headers['access_token']=tokenbase;
    request.fields['employeeid'] = userid;
    request.fields['visastart'] = datestart;
    request.fields['visaexpiry'] = dateexpiry;
    request.fields['visatype'] =visatype;
    request.fields['visanumber'] = visano;
    request.fields['imagename'] = imagefront;
    request.fields['imagebackname'] = imageback;
    request.fields['visaprofileimage'] = imageselfie;
    request.fields['nationalityid'] = nationalid;
    request.fields['iscurrent'] = iscurrent;
    request.fields['isrighttowork'] = isrighttowork;

    request.files.add(await http.MultipartFile.fromString('Text', "5")
    );


*/
    print(response.body);
    return response.body;
  }
  Future<String> userloginbytoken(String token) async {
    Map params = Map<String, dynamic>();


    final http.Response response = await http.post(
      '${base}api/userloginbytoken',
      headers: <String, String>{
        'authorization':token,
        'access_token':token
      },
      body: jsonEncode(params),
    );

    print('Response Body ${response.body}');
    return response.body;
  }

  Future<String> baseimageupload(imagebytes) async {
    Map params = Map<String, dynamic>();
params['imageBinary']=imagebytes;
params['userid']="99";

    final http.Response response = await http.post(
      '${base}baseimageupload',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization':tokenbase,
        'access_token':tokenbase
      },
      body: jsonEncode(params),
    );

    print('Response Body ${response.body}');
    return response.body;
  }

}
