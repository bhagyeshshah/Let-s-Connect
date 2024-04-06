class ApiConstants{

  //Database
  static const String databaseUrl = 'https://lets-connect-7a023-default-rtdb.asia-southeast1.firebasedatabase.app/';

  //Header key constants
  static const String headerAuthorization = 'Authorization';
  static const String headerContentType = 'Content-Type';

  /*Developemnt Environment*/
  static String devBaseAPI = 'database/dev/';
 
  /*UAT Environment*/
  static String uatBaseAPI = 'database/uat/';
  
  /*QA Environment*/
  static String qaBaseAPI = 'database/qa/';

  /*Production Environment*/
  static String prodBaseAPI = 'database/prod/';
  
  static late final String baseAPI;


  static String getApiUrlFor(String endPoint,{String join = '/', String? baseUrl, String? value, String? trailing}){
    String finalUrl = '${baseUrl ?? baseAPI}$endPoint';
    if(value?.trim().isNotEmpty ?? false){
      finalUrl = '$finalUrl$join$value';
    }
    if(trailing?.trim().isNotEmpty ?? false){
      finalUrl = '$finalUrl/$trailing';
    }
    return finalUrl;
  }
 
  ///////////////////////////////////////////////////////////////////////////////
  ///MODULE NAME
  ///////////////////////////////////////////////////////////////////////////////

  //Endpoints

  static const String users = 'users';


}