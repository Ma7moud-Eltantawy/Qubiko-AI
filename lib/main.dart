// localization.dart
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quickai/Features/Aboutapp/view/Aboutapp_Screen.dart';
import 'package:quickai/Features/Auth/Login/view/Login_screen.dart';
import 'package:quickai/Features/Auth/profile_screen/view/profile_screen.dart';
import 'package:quickai/Features/Home_Screen/home/view/Home_Screen_view.dart';
import 'package:quickai/Features/Home_Screen/screens/Chat_Screen/Chat/view/chat_view.dart';
import 'package:quickai/Features/Home_Screen/screens/History_Screen/view/History_view.dart';
import 'package:quickai/Features/Search_screen/view/search_view.dart';
import 'package:quickai/Features/Splash_Screen/view/Splash_screen_view.dart';
import 'package:quickai/Features/help_center/Screens/FaqsScreen/view/faqsscreen.dart';
import 'package:quickai/Features/help_center/Screens/contactmescreen/view/contactmescreen.dart';
import 'package:quickai/Features/language/controller/language_controller.dart';
import 'package:quickai/Features/language/view/language_selected_view.dart';
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
import 'Features/Privacy&policy/view/privacyscreen.dart';
import 'Features/help_center/Screens/FaqsScreen/controller/faqscontroller.dart';
import 'Features/help_center/controller/helpcenter_controller.dart';
import 'Features/help_center/view/helpcenter_view.dart';
import 'Features/otp_screen/view/otpscreen_view.dart';
import 'Features/payments/payment_method/view/paymentsscreenview.dart';
import 'Features/payments/review_summary/view/reviewSummary_Screen.dart';
import 'Features/payments/upgrade_to_pro/view/proplanscreen.dart';
import 'Features/personal_info/view/personalinfo_screen.dart';
import 'Features/security_screen/view/security_screen.dart';
import 'core/constants.dart';
import 'core/theme/theme.dart';
import 'data/Google_Ads.dart';
import 'options/Binding.dart';
import 'options/Localization_options.dart';


Future<void> main() async {
  Stripe.publishableKey=Publishablekey;

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );
  MobileAds.instance.initialize();
  LanguageController controller=Get.put(LanguageController());
  //final snapshot = await _firestore.collection("user_data").doc(id).get();


  runApp(


       FutureBuilder(
           future: controller.getlangfromdb() ,
           builder: (context,snapshot){
             if(snapshot.connectionState==ConnectionState.done)
               {
                 return MyApp(lang: snapshot.data!,);
               }
             else{return Container();
             }

             })

  );
}

class MyApp extends StatelessWidget {
   MyApp({Key? key,required this.lang}) : super(key: key);
   final String lang;


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

        debugShowCheckedModeBanner: false,
        theme: appTheme(context),
       initialBinding: HomeBinding(),

       getPages: [
         GetPage(name: Splash_screen.scid, page: () => Splash_screen(),transitionDuration:kTransitionDuration,transition: kTransition2,binding:HomeBinding()),
         GetPage(name: HelpCebterScreen.scid, page: () => HelpCebterScreen(),transitionDuration:kTransitionDuration,transition: kTransition2,binding:HomeBinding()),
         GetPage(name: Faqsscreen.scid, page: () => Faqsscreen(),transitionDuration:kTransitionDuration,transition: kTransition2,binding:HomeBinding()),
         GetPage(name: ContactmeScreen.scid, page: () => ContactmeScreen(),transitionDuration:kTransitionDuration,transition: kTransition2,binding:HomeBinding()),
         GetPage(name: Privacyscreen.scid, page: () => Privacyscreen(),transitionDuration:kTransitionDuration,transition: kTransition2,binding:HomeBinding()),
         GetPage(name: AboutappScreen.scid, page: () => AboutappScreen(),transitionDuration:kTransitionDuration,transition: kTransition2,binding:HomeBinding()),
         GetPage(name: Language_screen.scid, page: () => Language_screen(),transitionDuration:kTransitionDuration,transition: kTransition2,binding:HomeBinding()),




       ],
        textDirection:lang=="en"?TextDirection.ltr:TextDirection.rtl,


        title: 'Flutter Localization Demo',
        localizationsDelegates: const [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ar', 'EG'), // Add this line for Arabic (Egypt) support
        ],
        locale:lang=="en"? Locale('en', 'US'):Locale('ar', 'EG'),
        initialRoute: Splash_screen.scid,

      );

  }
}



// firebase_auth.dart

