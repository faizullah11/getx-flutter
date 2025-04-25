import 'dart:developer';

import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_service.dart';


class LoginRepository  {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> loginApi(dynamic data )async{
    try{
      final url = "https://reqres.in/api/login";
      log("$url ======= $data");
      dynamic response = await _apiServices.getPostApiResponse(url, data,null);
      return response ;
    }
    catch(e){
      log("login api ---- $e $data");
      rethrow ;
    }
  }


}

