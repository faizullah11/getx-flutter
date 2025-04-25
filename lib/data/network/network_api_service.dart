
import 'dart:convert';
// import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../app_exceptions.dart';
import 'base_api_services.dart';

class NetworkApiService extends BaseApiServices {

  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson ;
    try {
      final response = await http.get(
          Uri.parse(url)).timeout(Duration(seconds: 15));
      responseJson = returnResponse(response);
    }on SocketException {

      throw FetchDataException('---- No Internet Connection ----');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url , dynamic data,[String? token]) async{
    dynamic responseJson ;
    try {
      Response response = await post(
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json"
          },//
          //"Content-Type": jsonHeader??false?"application/json":"application/x-www-form-urlencoded"
          Uri.parse(url),
        body: jsonEncode(data)
      ).timeout( Duration(seconds:15),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return http.Response('Error', 408); // Request Timeout response status code
        },);
      responseJson = returnResponse(response);
    }
    on SocketException {

      throw FetchDataException('No Internet Connection');
    }
    return responseJson ;
  }

  dynamic returnResponse (http.Response response){

    switch(response.statusCode){
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson ;
      case 400:
        dynamic responseJson = (jsonDecode(response.body)['Message'])??(jsonDecode(response.body)['error'])??(jsonDecode(response.body)['errorMessage']);
        throw BadRequestException(" [${response.statusCode}] \n\n$responseJson");
      case 500:
        dynamic responseJson = jsonDecode(response.body)['Message'];
        throw BadRequestException(" [${response.statusCode}] \n\n$responseJson");
      case 401:
        dynamic responseJson = (jsonDecode(response.body)['Message'])??(jsonDecode(response.body)['error'])??(jsonDecode(response.body)['errorMessage']);
        throw UnauthorisedException(" [${response.statusCode}] \n\n$responseJson");
      case 404:
        dynamic responseJson = jsonDecode(response.body)['Message'];
        throw UnauthorisedException(" [${response.statusCode}] \n\n$responseJson");
      case 408:
        throw TimeOutException(" [${response.statusCode}]");
      default:
        throw FetchDataException(" [${response.statusCode}] \n\nError accrued while communicating with server with status code");
    }
  }
}