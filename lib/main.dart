// localization.dart
import 'dart:async';
import 'dart:convert';

import 'package:ai_chatbot/Features/Splash_Screen/view/Splash_screen_view.dart';
import 'package:ai_chatbot/Features/on_boarding/view/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'core/theme/theme.dart';
import 'options/Localization_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme(context),
      textDirection: TextDirection.ltr,
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

      home: const Splash_screen(),
    );
  }
}



// firebase_auth.dart

FirebaseAuth auth = FirebaseAuth.instance;

Future<void> authenticateUser() async {
  await auth.verifyPhoneNumber(
    phoneNumber: '+201015876911',
    verificationCompleted: (PhoneAuthCredential credential) async {
      // ANDROID ONLY!
      // Sign the user in (or link) with the auto-generated credential
      await auth.signInWithCredential(credential);
    },
    verificationFailed: (FirebaseAuthException error) {
      print(error);
    },
    codeSent: (String verificationId, int? forceResendingToken) async {
      print(forceResendingToken);
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: "123456",
      );

      print(credential.smsCode);
    },
    codeAutoRetrievalTimeout: (String verificationId) {
      print(verificationId);
    },
  );
}