
import 'package:lets_connect/utils/api_constants.dart';

enum Flavor{
  dev,
  qa,
  uat,
  prod
}

class FlavorValues{
  FlavorValues({
    required this.baseUrl,
  });

  final String baseUrl;
}

class FlavorConfig{
  Flavor flavor;
  // FlavorValues? values;
  static FlavorConfig? _instance;

  factory FlavorConfig({required Flavor flavor}){
    _instance ??= FlavorConfig._internal(flavor);
    return _instance!;
  }

  FlavorConfig._internal(this.flavor);

  set values(FlavorValues values){
    ApiConstants.baseAPI = values.baseUrl;
  }

  static FlavorConfig? get instance{
    return _instance;
  }

  static bool isDevelopment() => _instance!.flavor == Flavor.dev;
  static bool isQA() => _instance!.flavor == Flavor.qa;
  static bool isUAT() => _instance!.flavor == Flavor.uat;
  static bool isProduction() => _instance!.flavor == Flavor.prod;
}