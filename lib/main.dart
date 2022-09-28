// ignore_for_file: must_be_immutable

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:ogas_driver_app/viewModel/accept_order_view_model.dart';
import 'package:ogas_driver_app/viewModel/cancel_order_view_model.dart';
import 'package:ogas_driver_app/viewModel/edit_profile_view_model.dart';
import 'package:ogas_driver_app/viewModel/login_view_model.dart';
import 'package:ogas_driver_app/viewModel/signup_view_model.dart';
import 'package:ogas_driver_app/util/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'auth/app_notifications.dart';
import 'splash/view/splash_screen.dart';
import 'util/language_constants.dart';
import 'viewModel/check_driver_view_model.dart';

SharedPreferences? pref;
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  ///local notification...

  pref = await SharedPreferences.getInstance();
  await AppNotificationHandler.firebaseNotificationSetup();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      debugShowCheckedModeBanner: false,
      title: 'Ogas Driver App',
      // builder: (context, child) {
      //     return Directionality(textDirection: TextDirection.rtl, child: child!);
      //   },
      theme: ThemeData(
        colorSchemeSeed: ColorConstnt.mainorange,
        fontFamily: "DMSans",
      ),
      home: SplashScreen(),
    );
  }

  SignupViewModel signupViewModel = Get.put(SignupViewModel());

  EditProfileViewModel editProfileViewModel = Get.put(EditProfileViewModel());

  LoginViewModel loginViewModel = Get.put(LoginViewModel());

  AcceptOrderViewModel acceptOrderViewModel = Get.put(AcceptOrderViewModel());

  CancelOrderViewModel cancelOrderViewModel = Get.put(CancelOrderViewModel());

  CheckDriverViewModel checkDriverViewModel = Get.put(CheckDriverViewModel());
}
