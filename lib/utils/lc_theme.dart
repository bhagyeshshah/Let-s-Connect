import 'package:flutter/material.dart';

class AppTheme {
  
  //Light Theme Colors
  static Color lightThemePrimaryColor = Colors.purple.shade800;
  static Color lightThemeDisabledColor = Colors.grey.shade400;
  static Color lightThemeDisabledButtonTextColor = Colors.black;
  static Color lightThemeButtonTextColor = Colors.white;
  static Color lightThemeBackgroundColor = Colors.white;
  static Color lightThemeErrorColor = Colors.red;
  static Color lightThemeTextFieldColor = Colors.black;
  static Color lightThemeTextfieldBackgroundColor = Colors.grey.shade200;


  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: lightThemePrimaryColor,
    brightness: Brightness.light,
    disabledColor: lightThemeDisabledColor,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        side: MaterialStateProperty.resolveWith((states){
          return BorderSide(
              width: 1.5,
              color: (states.contains(MaterialState.disabled)) 
                ? lightThemeDisabledColor 
                : lightThemePrimaryColor, 
            );
        }),
        elevation: const MaterialStatePropertyAll(0.0),
        shape: MaterialStateProperty.resolveWith((states){
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          );
        }),
        backgroundColor: MaterialStateProperty.all(lightThemeBackgroundColor),
        textStyle: MaterialStateProperty.resolveWith((states) {
          return TextStyle(
            fontWeight: FontWeight.bold,
            color: states.contains(MaterialState.disabled) 
            ? lightThemeDisabledButtonTextColor 
            : lightThemePrimaryColor
          );
        })
      )
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: const MaterialStatePropertyAll(5.0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )
        ),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return lightThemeDisabledColor;
          }
          return lightThemePrimaryColor;
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return lightThemeDisabledButtonTextColor;
          }
          return lightThemeButtonTextColor;
        }),
        textStyle: MaterialStateProperty.resolveWith((states) {
          return TextStyle(
            fontWeight: FontWeight.bold,
            color: states.contains(MaterialState.disabled) 
            ? lightThemeDisabledButtonTextColor 
            : lightThemeButtonTextColor
          );
        })
      )
    ),

    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.resolveWith((states) {
          return TextStyle(
            fontWeight: FontWeight.w700,
            color: states.contains(MaterialState.disabled) 
            ? lightThemeDisabledButtonTextColor 
            : lightThemeButtonTextColor
          );
        })
      )
    ),

    inputDecorationTheme: InputDecorationTheme(
        fillColor: lightThemeTextfieldBackgroundColor,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          gapPadding: 15,
          borderSide: BorderSide.none
        ),
        errorMaxLines: 2,
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        errorStyle: TextStyle(color: lightThemeErrorColor, fontSize: 16, height: 0.3, fontWeight: FontWeight.w500),
        labelStyle: TextStyle(color: lightThemeTextFieldColor),
        floatingLabelStyle: TextStyle(color: lightThemePrimaryColor, fontSize: 18),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: lightThemePrimaryColor,
            width: 1.5
          )
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: lightThemePrimaryColor,
            width: 0.5
          )
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: lightThemeErrorColor,
            width: 1.5
          )
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: lightThemeErrorColor,
            width: 1.5
          )
        )
      ),
    //display, body, headline, label, title
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontWeight: FontWeight.bold,
        color: lightThemePrimaryColor
      ),
      bodySmall: TextStyle(
        fontWeight: FontWeight.bold,
        color: lightThemeButtonTextColor,
        fontSize: 18
      )
    ),
    scaffoldBackgroundColor: lightThemeBackgroundColor,
    dialogBackgroundColor: lightThemeBackgroundColor,
    dialogTheme: DialogTheme(
      backgroundColor: lightThemeBackgroundColor,
      surfaceTintColor: lightThemeBackgroundColor
    )
  );
}