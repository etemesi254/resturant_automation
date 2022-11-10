import 'package:flutter/material.dart';
import 'package:resturant_automation/constants.dart';
import 'package:resturant_automation/main.dart';

class AppTheme {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      fontFamily:"Outfit",
      primarySwatch: Colors.orange,
      primaryColor: isDarkTheme ? const Color(0xFF151515) : Colors.white,

      backgroundColor: isDarkTheme ?  const Color(0xFF151515) : Colors.white,

      indicatorColor:mainColor,
     
      hintColor: isDarkTheme ? const Color(0xff280C0B) : const Color(0xffEECED3),

      highlightColor: isDarkTheme ? const Color(0xff372901) : const Color(0xffFCE192),
      hoverColor: isDarkTheme ? const Color(0xff3A3A3B) : const Color(0xff4285F4),

      focusColor: isDarkTheme ? const Color(0xff0B2512) : const Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      cardColor: isDarkTheme ? const Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ?  const Color(0xFF151515) : const Color(0xffF1F5FB),
      scaffoldBackgroundColor: isDarkTheme ? const Color(0xFF151515) : Colors.white,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      unselectedWidgetColor: Colors.grey.withOpacity(0.5),
     
      // buttonTheme: Theme.of(context).buttonTheme.copyWith(
      //     colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
      appBarTheme: AppBarTheme(
        color: isDarkTheme ? Color(0xFF151515) : Colors.white,
        elevation: 0.0,
      ), textSelectionTheme: TextSelectionThemeData(selectionColor: isDarkTheme ? Colors.white : Colors.black),
    );
  }
}