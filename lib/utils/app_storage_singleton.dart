import 'package:flutter/material.dart';
import 'package:lets_connect/modules/user_profile/model/user_profile_dm.dart';
import 'package:lets_connect/utils/lc_theme.dart';

class AppStorageSingleton{
  GlobalKey<NavigatorState> dashboardNavigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> appFlowNavigatorKey = GlobalKey<NavigatorState>(); 
  UserProfileDm? loggedInUser;

  reset(){
    loggedInUser = null;
  }
}

AppStorageSingleton appStorageSingleton = AppStorageSingleton();
ThemeData get currentTheme{
  if(appStorageSingleton.appFlowNavigatorKey.currentContext == null){
    return AppTheme.lightTheme;
  }
  return Theme.of(appStorageSingleton.appFlowNavigatorKey.currentContext!);
}