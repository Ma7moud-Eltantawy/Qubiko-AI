// localization.dart
import 'dart:async';
import 'dart:convert';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:quickai/Features/Auth/Login/view/Login_screen.dart';
import 'package:quickai/Features/Auth/profile_screen/view/profile_screen.dart';
import 'package:quickai/Features/Home_Screen/home/view/Home_Screen_view.dart';
import 'package:quickai/Features/Home_Screen/screens/Chat_Screen/Chat/view/chat_view.dart';
import 'package:quickai/Features/Home_Screen/screens/History_Screen/view/History_view.dart';
import 'package:quickai/Features/Search_screen/view/search_view.dart';
import 'package:quickai/Features/Splash_Screen/view/Splash_screen_view.dart';
import 'package:quickai/Features/on_boarding/view/on_boarding_screen.dart';
import 'package:quickai/options/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:quickai/Features/Auth/Sign_up/view/Signup_screen_view.dart';

import 'package:uuid/uuid.dart';
import 'Features/otp_screen/view/otpscreen_view.dart';
import 'Features/payments/payment_method/view/paymentsscreenview.dart';
import 'Features/payments/review_summary/view/reviewSummary_Screen.dart';
import 'Features/payments/upgrade_to_pro/view/proplanscreen.dart';
import 'Features/personal_info/view/personalinfo_screen.dart';
import 'Features/security_screen/view/security_screen.dart';
import 'core/constants.dart';
import 'core/theme/theme.dart';
import 'options/Localization_options.dart';


Future<void> main() async {
  Stripe.publishableKey=Publishablekey;

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );
  //final snapshot = await _firestore.collection("user_data").doc(id).get();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme(context),
     // textDirection:TextDirection.ltr,


      title: 'Flutter Localization Demo',
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate, // Add this line
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ar', 'EG'), // Add this line for Arabic (Egypt) support
      ],
      locale: Locale('en','US'),

      home:Splash_screen(),
    );
  }
}



// firebase_auth.dart

