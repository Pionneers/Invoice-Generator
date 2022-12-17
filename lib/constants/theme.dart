import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTheme {

  ThemeData lightTheme(){
    final ThemeData lightmode = ThemeData.light();
    return lightmode.copyWith(
      platform: TargetPlatform.iOS,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.white,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        color: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black,),
        titleTextStyle: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
      ),
      dividerTheme: const DividerThemeData(
        color: Colors.grey,
        thickness: 1.0,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.red,
      ),
      textTheme: const TextTheme(
        bodyText1: TextStyle(
          color: Colors.black
        ),
        bodyText2: TextStyle(
          color: Colors.black
        ),
        headline1: TextStyle(
          color: Colors.black
        ),
        caption: TextStyle(
          color: Colors.black
        )
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }
      ),
    );
  }

}