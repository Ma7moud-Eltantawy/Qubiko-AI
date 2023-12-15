import 'package:flutter/material.dart';

import '../manager/colors_manager.dart';

ThemeData appTheme(BuildContext context) {
  return ThemeData(

    hintColor: ColorsManager.black, // This will set the slider color

    fontFamily: "varela",
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(ColorsManager.primary))),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            color: ColorsManager.primary,
            fontFamily: "varela",
          ),
        ),
      ),
    ),
    appBarTheme:  AppBarTheme(
      iconTheme: IconThemeData(
        color: ColorsManager.black,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: "varela",

        color: ColorsManager.primary,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ),
  );
}
