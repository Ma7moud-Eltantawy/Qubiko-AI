import 'package:flutter/material.dart';

import '../manager/colors_manager.dart';

ThemeData appTheme(BuildContext context) {
  return ThemeData(



    hintColor: ColorsManager.black, // This will set the slider color

    fontFamily: "Rubink",
    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: ColorsManager.burble,
      unselectedItemColor: Color.fromRGBO(158, 158, 158, 1),
      unselectedLabelStyle: TextStyle(
        color: Color.fromRGBO(158, 158, 158, 1),
      ),
      selectedLabelStyle: TextStyle(
        color: Color.fromRGBO(158, 158, 158, 1),
      ),


    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(ColorsManager.burble))),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            color: ColorsManager.primary,
            fontFamily: "Rubink",
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
        fontFamily: "Rubink",

        color: ColorsManager.black,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ),
  );
}
