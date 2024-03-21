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

  //Setup status bar color
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarColor: Colors.black
  // ));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  
  FlavorConfig.instance?.values = FlavorValues(
    baseUrl: ApiConstants.baseAPI
  );

  runApp(const App());
}

