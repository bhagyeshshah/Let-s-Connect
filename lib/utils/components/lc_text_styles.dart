import 'package:flutter/material.dart';
import 'package:lets_connect/utils/app_storage_singleton.dart';

class LcTextStyle{
  static TextStyle? pageHeaderStyle(){
    return currentTheme.textTheme.headlineLarge;
  }
  static TextStyle? chatMessageSent(){
    return currentTheme.textTheme.bodySmall;
  }
  static TextStyle? appBar(){
    return currentTheme.textTheme.headlineMedium;
  }
  static TextStyle? title(){
    return currentTheme.textTheme.titleMedium;
  }
  static TextStyle? subTitle(){
    return currentTheme.textTheme.titleSmall;
  }

}