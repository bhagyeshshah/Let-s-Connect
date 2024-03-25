import 'package:firebase_auth/firebase_auth.dart';
import 'package:lets_connect/utils/api_exception.dart';
import 'package:lets_connect/utils/translation_service.dart';

class FirebaseAuthService{

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static User? get currentUser => _auth.currentUser;

  static Future<User> signIn({required String email, required String password}) async{
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email,password: password);
    if(userCredential.user?.emailVerified ?? false){
      return userCredential.user!;
    }
    else{
      await verifyEmail(user: userCredential.user);
      await signOut();
      throw(ApiException(ApiExceptionCode.userNotVerified, translationService.text('key_user_not_verified_error')));
    }
  }

  static Future<void> signUp({required String email, required String password}) async{
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password
    ); 
    await verifyEmail(user: userCredential.user);
  }

  static Future<void> verifyEmail({required User? user}) async{
    await user?.sendEmailVerification();
  }

  static Future<void> forgotPassword({required String email}) async{
    await _auth.sendPasswordResetEmail(email: email);
  }

  static Future<void> signOut() async{
    await _auth.signOut();
  }

}