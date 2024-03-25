import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_connect/utils/api_client_service.dart';


abstract class ForgotPasswordState{}
class ForgotPasswordInitial extends ForgotPasswordState{}
class ForgotPasswordLoading extends ForgotPasswordState{}
class ForgotPasswordSuccess extends ForgotPasswordState{}
class ForgotPasswordError extends ForgotPasswordState{
  String error;
  ForgotPasswordError(this.error);
}

abstract class ForgotPasswordEvent{}
class ForgotPasswordButtonPressed extends ForgotPasswordEvent{
  String email;
  ForgotPasswordButtonPressed({required this.email});
}

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState>{
  ForgotPasswordBloc():super(ForgotPasswordInitial()){
    on<ForgotPasswordButtonPressed>(_mapForgotpwdButtonPressedToState);
  }

  FutureOr _mapForgotpwdButtonPressedToState(ForgotPasswordButtonPressed event, Emitter<ForgotPasswordState> emit) async{
    try{
      emit(ForgotPasswordLoading());
    
      //API Call
      await ApiClientService.forgotPassword(email: event.email);
     
      emit(ForgotPasswordSuccess());
    }
    catch(e){
      emit(ForgotPasswordError(e.toString()));
    }
  }
}