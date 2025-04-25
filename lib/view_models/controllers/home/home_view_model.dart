import 'package:my_app/data/response/status.dart';
import 'package:my_app/models/home/user_list_model.dart';
import 'package:my_app/repository/home/home_repository.dart';
import 'package:my_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  final _api = HomeRepository();

  RxBool loading = false.obs;

  final rxRequeststatus = Status.LOADING.obs;

  final userListModel = UserListModel().obs;

  RxString error="".obs;

  void setRxRequestStatus(Status value) => rxRequeststatus.value = value;
  void setUserList(UserListModel value) => userListModel.value = value;
    void setError(String value) => error.value = value;

  Future<void> userListApi() async {
    loading.value = true;

    _api
        .userListApi()
        .then((value) async {
          loading.value = false;
          setRxRequestStatus(Status.COMPLETED);
          debugPrint("Home response is -----  $value");
          if (value.data!.isNotEmpty) {
            setUserList(value);
          } 
        })
        .onError((error, stackTrace) {
          loading.value = false;
          setRxRequestStatus(Status.ERROR);
          setError(error.toString());
          Utils.snackBar("Error ", "Home Api ------- $error");
          // debugPrint("Login Api ------- $error");
        });
  }
}
