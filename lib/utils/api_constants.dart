class ApiConstants{

  //Header key constants
  static const String headerAuthorization = 'Authorization';
  static const String headerContentType = 'Content-Type';

  /*Developemnt Environment*/
  static String devBaseAPI = 'dev/';
 
  /*UAT Environment*/
  static String uatBaseAPI = 'uat/';
  
  /*QA Environment*/
  static String qaBaseAPI = 'uat/';

  /*Production Environment*/
  static String prodBaseAPI = 'prod/';
  
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


}