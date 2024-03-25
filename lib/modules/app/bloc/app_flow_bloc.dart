import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_connect/utils/api_client_service.dart';

abstract class AppFlowEvent{}
class AppStart extends AppFlowEvent{}
class SignInEvent extends AppFlowEvent{}
class SignUpEvent extends AppFlowEvent{}
class ForgotPasswordEvent extends AppFlowEvent{}
class ProfileEvent extends AppFlowEvent{}
class DashboardEvent extends AppFlowEvent{}
class SignOutEvent extends AppFlowEvent{}


abstract class AppFlowState{}
class SplashState extends AppFlowState{}
class SignInState extends AppFlowState{}
class SignUpState extends AppFlowState{}
class ForgotPasswordState extends AppFlowState{}
class ProfileState extends AppFlowState{}
class DashboardState extends AppFlowState{}

class AppFlowBloc extends Bloc<AppFlowEvent, AppFlowState>{
  AppFlowBloc():super(SplashState()){
    on<AppStart>(_mapAppStartToState);
    on<SignInEvent>(_mapSignInToState);
    on<SignUpEvent>(_mapSignUpToState);
    on<ForgotPasswordEvent>(_mapForgotPasswordToState);
    on<ProfileEvent>(_mapProfileToState);
    on<DashboardEvent>(_mapDashboardToState);
    on<SignOutEvent>(_mapSignOutToState);
  }

  FutureOr _mapAppStartToState(AppStart event, Emitter<AppFlowState> emit) async {
    try{
      //Show splash before checking the session validity
      emit(SplashState());

      //Showing splash screen
      await Future.delayed(const Duration(seconds: 2));

      if(ApiClientService.currentUser != null){
        emit(DashboardState());
      }
      else{
        emit(SignInState());
      }
    }catch(_){
      emit(SignInState());
    }
  }
  FutureOr _mapSignInToState(SignInEvent event, Emitter<AppFlowState> emit) async {
    emit(SignInState());
  }
  FutureOr _mapSignUpToState(SignUpEvent event, Emitter<AppFlowState> emit) async {
    emit(SignUpState());
  }
  FutureOr _mapForgotPasswordToState(ForgotPasswordEvent event, Emitter<AppFlowState> emit) async {
    emit(ForgotPasswordState());
  }
  FutureOr _mapProfileToState(ProfileEvent event, Emitter<AppFlowState> emit) async {
    emit(ProfileState());
  }
  FutureOr _mapDashboardToState(DashboardEvent event, Emitter<AppFlowState> emit) async {
    emit(DashboardState());
  }
  FutureOr _mapSignOutToState(SignOutEvent event, Emitter<AppFlowState> emit) async {
    await ApiClientService.signOut();
    emit(SignInState());
  }
}