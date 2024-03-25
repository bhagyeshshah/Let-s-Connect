import 'package:firebase_auth/firebase_auth.dart';
import 'package:lets_connect/network/firebase_auth_service.dart';
import 'package:lets_connect/utils/api_exception.dart';

class ApiClientService{

  static User? get currentUser => FirebaseAuthService.currentUser;

  static Future<User> signIn({required String email, required String password}) async{
    return await _handleApiException(FirebaseAuthService.signIn(email: email, password: password));
  }

  static Future<void> signUp({required String email, required String password}) async{
    return await _handleApiException(FirebaseAuthService.signUp(email: email, password: password));
  }

  static Future<void> forgotPassword({required String email}) async{
    return await _handleApiException(FirebaseAuthService.forgotPassword(email: email));
  }
  static Future<void> signOut() async{
    return await _handleApiException(FirebaseAuthService.signOut());
  }


  // HANDLE API EXCEPTIONS
  static Future _handleApiException(Future apiCall)async{
    try{
      return await apiCall;  
    }on ApiException catch(_){
      rethrow;
    }
  }
}