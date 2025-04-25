import 'package:my_app/models/login/user_model.dart';
import 'package:my_app/res/routes/routes_name.dart';
import 'package:my_app/utils/utils.dart';
import 'package:my_app/view_models/controllers/user_prefrence/user_prefrence_view_model.dart';

import '../../../repository/login/login_repository.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginViewModel extends GetxController {
  final myRepo = LoginRepository();

  final formUserFieldKey = GlobalKey<FormFieldState>();
  final userController = TextEditingController().obs;
  final userFocusNode = FocusNode().obs;

  final passwordController = TextEditingController().obs;
  final passwordFocusNode = FocusNode().obs;
  final formPasswordFieldKey = GlobalKey<FormFieldState>();
  final UserPrefrenceViewModel _userPrefrenceViewModel =
      UserPrefrenceViewModel();

  RxBool loading = false.obs;

  Future<void> loginApi(BuildContext context) async {
    loading.value = true;
    FocusManager.instance.primaryFocus?.unfocus();
    final username = userController.value.text.trim();
    final password = passwordController.value.text.trim();

    if (username.isEmpty || password.isEmpty) {
      debugPrint("---- Enter email or password  ------- ");
      loading.value = false;
      return;
    }

    final Map authData = {
      "email": userController.value.text.trim(),
      "password": passwordController.value.text.trim(),
    };

    myRepo
        .loginApi(authData)
        .then((value) async {
          loading.value = false;
          debugPrint("Login response is -----  ${value}");

          if (value["token"] != null && value["token"].toString().isNotEmpty) {
            _userPrefrenceViewModel
                .saveUser(UserModel.fromJson(value))
                .then((onValue) {
                  Get.delete<LoginViewModel>();
                  Get.toNamed(RouteName.homeScreen);
                })
                .onError((error, stackTrace) {
                  Utils.snackBar(
                    "saveUser ",
                    "saveUser loginApi ------- $error",
                  );
                });
          } else {
            Utils.snackBar("Response ", "Login Response is  $value !!! ");
          }
        })
        .onError((error, stackTrace) {
          loading.value = false;
          Utils.snackBar("Error ", "Login Api ------- $error");
           debugPrint(" $authData Login Api ------- $error");
        });
  }
}
