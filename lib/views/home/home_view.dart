import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/data/response/status.dart';

import 'package:my_app/res/colors/app_colors.dart';
import 'package:my_app/res/routes/routes_name.dart';
import 'package:my_app/view_models/controllers/home/home_view_model.dart';
import 'package:my_app/view_models/controllers/user_prefrence/user_prefrence_view_model.dart';
import 'package:my_app/views/home/widgets/user_list_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final homeViewModel = Get.put(HomeViewModel());

  @override
  void initState() {
    super.initState();
    homeViewModel.userListApi();
  }

  void logout() {
    final UserPrefrenceViewModel userPrefrenceViewModel =
        UserPrefrenceViewModel();

    userPrefrenceViewModel.removeUser().then((value) {
      if (value) {
        Get.toNamed(RouteName.loginScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.redColor,
        title: Text("Dashboard", style: TextStyle(color: AppColors.whiteColor)),
      ),
      body: Obx(() {
        switch (homeViewModel.rxRequeststatus.value) {
          case Status.LOADING:
            return Center(child: CircularProgressIndicator());
          case Status.ERROR:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Error'),
                  Text(
                    homeViewModel.error.toString(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            );
          case Status.COMPLETED:
        return  UserListWidget();
        }
      }),

      floatingActionButton: FloatingActionButton(
        onPressed: logout,
        tooltip: 'Increment',
        backgroundColor: AppColors.redColor,
        child: const Icon(Icons.logout_outlined, color: AppColors.whiteColor),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
