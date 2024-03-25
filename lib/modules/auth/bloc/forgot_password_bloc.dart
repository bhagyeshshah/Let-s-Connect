import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_connect/utils/api_client_service.dart';


abstract class ForgotpasswordState{}
class ForgotpasswordInitial extends ForgotpasswordState{}
class ForgotpasswordLoading extends ForgotpasswordState{}
class ForgotpasswordSuccess extends ForgotpasswordState{}
class ForgotpasswordError extends ForgotpasswordState{
  String error;
  ForgotpasswordError(this.error);
}

abstract class ForgotpasswordEvent{}
class ForgotpasswordButtonPressed extends ForgotpasswordEvent{
  String email;
  ForgotpasswordButtonPressed({required this.email});
}

class ForgotpasswordBloc extends Bloc<ForgotpasswordEvent, ForgotpasswordState>{
  ForgotpasswordBloc():super(ForgotpasswordInitial()){
    on<ForgotpasswordButtonPressed>(_mapForgotpwdButtonPressedToState);
  }

  FutureOr _mapForgotpwdButtonPressedToState(ForgotpasswordButtonPressed event, Emitter<ForgotpasswordState> emit) async{
    try{
      emit(ForgotpasswordLoading());
    
      //API Call
      await ApiClientService.forgotPassword(email: event.email);
     
      emit(ForgotpasswordSuccess());
    }
    catch(e){
      emit(ForgotpasswordError(e.toString()));
    }
  }
}