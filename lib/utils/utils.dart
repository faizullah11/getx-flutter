
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:my_app/res/colors/app_colors.dart';

class Utils {
  static void feildFocusChangeg(BuildContext context, FocusNode curret,FocusNode next){
    curret.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static toastMesssage(String message){
   Fluttertoast.showToast(
    msg: message,
    backgroundColor: AppColors.redColor,
   );
  }

  static snackBar(String title,String message){
   Get.snackbar(title,message);
  }
}
