// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_constructors_in_immutables

import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ogas_driver_app/Model/apiModel/requestModel/login_request_model.dart';
import 'package:ogas_driver_app/Model/apiModel/responseModel/login_response_model.dart';
import 'package:ogas_driver_app/Model/apis/api_response.dart';
import 'package:ogas_driver_app/Model/apis/pref_string.dart';
import 'package:ogas_driver_app/auth/app_notifications.dart';
import 'package:ogas_driver_app/auth/not_approved.dart';
import 'package:ogas_driver_app/auth/signin.dart';
import 'package:ogas_driver_app/homescreen/home.dart';
import 'package:ogas_driver_app/util/utiliti.dart';
import 'package:ogas_driver_app/viewModel/login_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? status;
  String? status2;
  String? phone;
  String? deviceToken;
  LoginViewModel loginViewModel = Get.find();
  LoginRequestModel loginReq = LoginRequestModel();
  LoginResponseModel loginRes = LoginResponseModel();
  @override
  void initState() {
    getNotificationToken();
    getToken();
    AppNotificationHandler.onMsgOpen(context);
    AppNotificationHandler.getInitialMsg(context);
    AppNotificationHandler.showMsgHandler(context);
    super.initState();
    _navigateToHome();
  }

  getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    deviceToken = await FirebaseMessaging.instance.getToken();
    setState(() {});
    print('T-O-K-E-N-->$deviceToken');
    pref.setString(PrefString.deviceToken, deviceToken.toString());
  }

  getNotificationToken() async {
    await AppNotificationHandler.firebaseNotificationSetup();
  }

  _navigateToHome() {
    Timer(Duration(seconds: 1), () async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      status = pref.getString(PrefString.loggedIn);
      phone = pref.getString(PrefString.phoneNumber);
      setState(() {});
      Utility.isFirstTime = pref.getString(PrefString.firstTimeUser);
      print(PrefString.loggedIn);
      print(status);
      print(status2);
      print('status $status');

      if (status == 'loggedIn') {
        loginReq.mobile = phone;
        await loginViewModel.login(loginReq);
        if (loginViewModel.loginApiResponse.status == Status.COMPLETE) {
          LoginResponseModel response = loginViewModel.loginApiResponse.data;
          status2 = response.data?.user?.status;
          pref.setString(PrefString.token, response.data!.token.toString());
          setState(() {});
          print('LOGIN status ${response.success}');
          if (response.success == true) {
            if (status2 == null || status2 == 'null') {
              Get.offAll(NotApproved());
            } else {
              Get.offAll(() => HomePage());
            }
          } else {
            Get.offAll(NotApproved());
          }
        }
      } else {
        Get.offAll(() => SignUpScreen(sign: false));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("asset/splash.png"), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
