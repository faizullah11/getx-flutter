import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/res/routes/routes_name.dart';
import 'package:my_app/view_models/controllers/user_prefrence/user_prefrence_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  final UserPrefrenceViewModel _userPrefrenceViewModel =
      UserPrefrenceViewModel();
  @override
  void initState() {
    super.initState();

    moveNext();
  }

  void moveNext() {
    debugPrint(" ======== moveNext  ------- ");
    // Navigate to LoginScreen after 3 seconds
    _userPrefrenceViewModel
        .getUser()
        .then((value) {
          if (value.token!.isEmpty || value.token.toString() == null) {
            Future.delayed(const Duration(seconds: 3), () {
              Get.toNamed(RouteName.loginScreen);
            });
          } else {
            Future.delayed(const Duration(seconds: 3), () {
              Get.toNamed(RouteName.homeScreen);
            });
          }
        })
        .onError((error, stackTrace) {
          Future.delayed(const Duration(seconds: 3), () {
            Get.toNamed(RouteName.loginScreen);
          });

          debugPrint("_userPrefrenceViewModel  ------- $error");
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset(
          'assets/images/splash.jpg',
          fit: BoxFit.cover, // fills entire screen
        ),
      ),
    );
  }
}
