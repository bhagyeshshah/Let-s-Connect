import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_connect/modules/feeds/model/feed_dm.dart';
import 'package:lets_connect/utils/api_client_service.dart';

abstract class FeedFormState{}
class FeedFormInitialState extends FeedFormState{}
class FeedFormSaving extends FeedFormState{}
class FeedFormSaved extends FeedFormState{}
class FeedFormError extends FeedFormState{
  String error;
  FeedFormError(this.error);
}

abstract class FeedFormEvent{}
class SaveFeedForm extends FeedFormEvent{
  FeedListDm formDm;
  SaveFeedForm({required this.formDm});
}


class FeedFormBloc extends Bloc<FeedFormEvent, FeedFormState>{
  FeedFormBloc():super(FeedFormInitialState()){
    on<SaveFeedForm>(mapSaveFeedFormToState);
  }

  FutureOr mapSaveFeedFormToState(SaveFeedForm event, Emitter<FeedFormState> emit) async{
    try{
      emit(FeedFormSaving());
      //Api Call
      await ApiClientService.createFeed(event.formDm);
      emit(FeedFormSaved());
    }
    catch(e){
      emit(FeedFormError(e.toString()));
    }
  }

}




