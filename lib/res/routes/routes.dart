

import 'package:get/get.dart';

import 'package:my_app/views/home/home_view.dart';
import 'package:my_app/views/login/login_view.dart';
import 'package:my_app/views/splash_screen.dart';

import 'package:my_app/res/routes/routes_name.dart';

class AppRoutes{
  static appRoutes()=>[
     GetPage(
      name:RouteName.splashScreen,
      page: () => SplashScreen()

    ),
    GetPage(
      name:RouteName.loginScreen,
      page: () => LoginPage()

    ),
    GetPage(
      name:RouteName.homeScreen,
      page: () => MyHomePage()
    ),
  ];
}