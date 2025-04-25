import 'dart:developer';

import 'package:my_app/models/home/user_list_model.dart';

import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_service.dart';


class HomeRepository  {
  final BaseApiServices _apiServices = NetworkApiService();
  Future<UserListModel> userListApi()async{
    try{
      final url = "https://reqres.in/api/users?page=2";
      dynamic response = await _apiServices.getGetApiResponse(url);
      return UserListModel.fromJson(response);
    }
    catch(e){
      log("----- Home api error ----  $e");
      rethrow ;
    }
  }
}

