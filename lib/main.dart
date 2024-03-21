import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lets_connect/modules/app/ui/app.dart';
import 'package:lets_connect/utils/api_constants.dart';
import 'package:lets_connect/utils/flavor_config.dart';
import 'package:lets_connect/utils/translation_service.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();


  //Flavor Configuration
  FlavorConfig(
    flavor: Flavor.prod, 
  );

  //Translation Initialization
  await translationService.init();

  //Firebase setup
  await Firebase.initializeApp();

  //Setup status bar color
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarColor: Colors.black
  // ));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  
  FlavorConfig.instance?.values = FlavorValues(
    baseUrl: ApiConstants.prodBaseAPI
  );

  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(const App());
}

