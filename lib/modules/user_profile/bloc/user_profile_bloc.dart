import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_connect/modules/user_profile/model/user_profile_dm.dart';
import 'package:lets_connect/utils/api_client_service.dart';


abstract class ProfileState{}
class ProfileInitial extends ProfileState{}
class ProfileLoading extends ProfileState{}
class ProfileLoaded extends ProfileState{
  UserProfileDm? profileDm;
  ProfileLoaded(this.profileDm);
}

class ProfileError extends ProfileState{
  String error;
  ProfileError(this.error);
}

abstract class ProfileEvent{}

class FetchProfile extends ProfileEvent{
  String? userId;
  bool? isRefresh;
  FetchProfile({required this.userId, this.isRefresh = false});
}

class UserDetails extends ProfileEvent{
  String? id;
  UserDetails({required this.id});
}

class ProfileBloc extends Bloc<ProfileEvent, ProfileState>{
  ProfileBloc():super(ProfileInitial()){
    on<FetchProfile>(mapFetchProfileToState);
  }


  FutureOr mapFetchProfileToState(FetchProfile event, Emitter<ProfileState> emit) async{
    try{
      if(!(event.isRefresh ?? false)){
        emit(ProfileLoading());
      }
      //Api Call
      UserProfileDm? result = await ApiClientService.fetchProfile(userId: event.userId ?? '');
      emit(ProfileLoaded(result));

    }
    catch(e){
      emit(ProfileError(e.toString()));
    }
  }

}

