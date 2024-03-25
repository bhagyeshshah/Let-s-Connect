import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_connect/utils/api_client_service.dart';

abstract class SignUpState{}
class SignUpInitial extends SignUpState{}
class SignUpLoading extends SignUpState{}
class SignUpSuccess extends SignUpState{}
class SignUpError extends SignUpState{
  String error;
  SignUpError(this.error);
}
class SignUpFormLoaded extends SignUpState{
  SignUpFormLoaded();
}


abstract class SignUpEvent{}
class SignUpButtonPressed extends SignUpEvent{
  String email;
  String password;
  SignUpButtonPressed({required this.email, required this.password});
}

class SignUpBloc extends Bloc<SignUpEvent, SignUpState>{
  SignUpBloc():super(SignUpInitial()){
    on<SignUpButtonPressed>(_mapLoginButtonPressedToState);
  }

  FutureOr _mapLoginButtonPressedToState(SignUpButtonPressed event, Emitter<SignUpState> emit) async{
    try{
      emit(SignUpLoading());
    
      //API Call
      await ApiClientService.signUp(email: event.email, password: event.password);

      emit(SignUpSuccess());
    }
    on FirebaseException catch(e ){
      emit(SignUpError(e.message.toString()));
    }
    catch(e ){
      emit(SignUpError(e.toString()));
    }
  }
}