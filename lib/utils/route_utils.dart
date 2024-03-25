import 'package:flutter/material.dart';
import 'package:lets_connect/modules/app/ui/splash_screen.dart';
import 'package:lets_connect/modules/auth/ui/forgot_password_screen.dart';
import 'package:lets_connect/modules/auth/ui/sign_in_screen.dart';
import 'package:lets_connect/modules/auth/ui/sign_up_screen.dart';

class ConstRoutes {

  //AUTH
  static const String splash = '/';
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String forgotpassword = '/forgotPassword';

  
  //APP
  static const String home = '/';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ConstRoutes.splash:
        return _createRoute(screen: const SplashScreen());
      case ConstRoutes.signIn:
        return _createRoute(screen: const SignInScreen());
      case ConstRoutes.signUp:
        return _createRoute(screen: const SignUpScreen());
      case ConstRoutes.forgotpassword:
        return _createRoute(screen: const ForgotPasswordScreen());
      
      default:
        return MaterialPageRoute(builder: (context) =>  Container());
    }
  }

  static Route _createRoute({required Widget screen}) {
    return MaterialPageRoute(
      builder: (context) => screen,
    );
  }
}