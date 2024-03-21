class ApiExceptionCode{
  static int userNotVerified = 1001;
}

class ApiException implements Exception {
  final int code;
  String? message;
  dynamic responseJson;
  
  ApiException(this.code, this.message,{this.responseJson});
  
  @override
  String toString() {
   return message ?? '';
  }
}