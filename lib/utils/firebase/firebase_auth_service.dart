import 'package:firebase_auth/firebase_auth.dart';
import 'package:lets_connect/utils/api_exception.dart';
import 'package:lets_connect/utils/translation_service.dart';

class FirebaseAuthService{

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> signIn({required String email, required String password}) async{
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

  Future<void> signUp({required String email, required String password}) async{
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password
    );
    await verifyEmail(user: userCredential.user);
  }

  Future<void> verifyEmail({required User? user}) async{
    await user?.sendEmailVerification();
  }

  Future<void> forgotPassword({required String email}) async{
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async{
    await _auth.signOut();
  }

}