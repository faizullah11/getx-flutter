// import 'package:get/get.dart';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:my_app/models/login/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPrefrenceViewModel extends GetxController {
  Future<bool> saveUser(UserModel responseModel) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("token", responseModel.token.toString());
    return true;
  }

  Future<UserModel> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return UserModel(token: sp.getString("token"));
  }

  Future<bool> removeUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    return true;
  }
}
