import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/res/colors/app_colors.dart';
import 'package:my_app/res/components/round_button.dart';
import 'package:my_app/res/fonts/app_fonts.dart';
import 'package:my_app/utils/utils.dart';
import 'package:my_app/view_models/controllers/login/login_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginVM = Get.put(LoginViewModel());
  final _formKey=GlobalKey<FormState>();

  void onLoginPress() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.redColor,
        title: Text(
          "Login",
          style: TextStyle(fontFamily: AppFonts.poppinsRegular,color: Color(0xffffffff)),
        ),
      ),
      body: Center(
        child:Form(
        //  key: _formKey,
          child:
         Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ), // You can adjust 16 to your need
              child: TextFormField(
                key: loginVM.formUserFieldKey,
                controller: loginVM.userController.value,
                focusNode: loginVM.userFocusNode.value,
                decoration: const InputDecoration(labelText: 'Username'),
                keyboardType: TextInputType.text,
                onTapOutside: (obj) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                //controller: numberController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a username!';
                  }
                  return null;
                },
                onSaved: (value) {},
                onFieldSubmitted: (value) {
                  Utils.feildFocusChangeg(context, loginVM.userFocusNode.value, loginVM.passwordFocusNode.value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ), // You can adjust 16 to your need
              child: TextFormField(
                key: loginVM.formPasswordFieldKey,
                controller: loginVM.passwordController.value,
                focusNode: loginVM.passwordFocusNode.value,
                decoration: const InputDecoration(labelText: 'Password'),
                keyboardType: TextInputType.text,
                obscureText: true,
                onTapOutside: (obj) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                //controller: numberController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Password .. ';
                  }
                  return null;
                },
                onSaved: (value) {},
                onFieldSubmitted: (value) {},
              ),
            ),

            SizedBox(height: 20),
            RoundButton(
              title: "Login",
              onPress: () {
              loginVM.loginApi(context);
              },
              loading: loginVM.loading.value,
              width: 200,
              buttonColor: AppColors.redColor,
            ),
          ],
        )),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: onLoginPress,
      //   tooltip: 'Submit',
      //   child: const Icon(Icons.login),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
