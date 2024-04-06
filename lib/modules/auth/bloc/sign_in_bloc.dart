import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_connect/utils/api_client_service.dart';

abstract class SignInState{}
class SignInInitial extends SignInState{}
class SignInLoading extends SignInState{}

class SignInSuccess extends SignInState{}
class SignInError extends SignInState{
  String error;
  SignInError(this.error);
}

abstract class SignInEvent{}
class SignInButtonPressed extends SignInEvent{
  String email;
  String password;
  SignInButtonPressed({required this.email, required this.password});
}

class SignOutButtonPressed extends SignInEvent{}


class SignInBloc extends Bloc<SignInEvent, SignInState>{
  SignInBloc():super(SignInInitial()){
    on<SignInButtonPressed>(_mapSignInButtonPressedToState);    
    on<SignOutButtonPressed>(_mapSignOutButtonPressedToState);    
  }

  FutureOr _mapSignInButtonPressedToState(SignInButtonPressed event, Emitter<SignInState> emit) async{
    try{
      emit(SignInLoading());
    
      //API Call
      await ApiClientService.signIn(email: event.email, password: event.password);

      emit(SignInSuccess());
    }
    on FirebaseException catch(e ){
      emit(SignInError(e.message.toString()));
    }
    catch(e){
      emit(SignInError(e.toString()));
    }
  }
  FutureOr _mapSignOutButtonPressedToState(SignOutButtonPressed event, Emitter<SignInState> emit) async{
    try{
      emit(SignInLoading());
    
      //API Call
      await ApiClientService.signOut();

      emit(SignInSuccess());
    }
    on FirebaseException catch(e ){
      emit(SignInError(e.message.toString()));
    }
    catch(e){
      emit(SignInError(e.toString()));
    }
  }

}