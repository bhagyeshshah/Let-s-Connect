import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_connect/modules/feeds/model/feed_dm.dart';
import 'package:lets_connect/utils/api_client_service.dart';
import 'package:lets_connect/utils/app_constants.dart';

////////////////////
/// STATES
////////////////////

abstract class FeedState{}

class FeedListInitialState extends FeedState{}
class FeedListLoading extends FeedState{
  bool isRefershing;
  FeedListLoading({this.isRefershing = false});
}
class FeedListLoadingMore extends FeedState{}
class FeedListLoaded extends FeedState{
  List<FeedListDm> feedList;
  bool hasReachedMax;
  FeedListLoaded({required this.feedList, required this.hasReachedMax});
}
class FeedListError extends FeedState{
  List<FeedListDm> preloadedFeedList;
  String error;
  FeedListError({required this.error, required this.preloadedFeedList});
}

////////////////////
/// EVENTS
////////////////////

abstract class FeedEvent{}
class FetchFeedList extends FeedEvent{
  bool isRefresh;
  FetchFeedList({this.isRefresh = false});
}

////////////////////
/// BLOC
////////////////////

class FeedListBloc extends Bloc<FeedEvent, FeedState>{
  FeedListBloc():super(FeedListLoading()){
    on<FetchFeedList>(mapFetchFeedListToState);
  }
  num? lastReceivedPostId;
  FutureOr mapFetchFeedListToState(FetchFeedList event, Emitter<FeedState> emit) async{
    List<FeedListDm> preLoadedList = [];
    try{
      if(lastReceivedPostId == null){
        emit(FeedListLoading(isRefershing: event.isRefresh));
      }
      else if(state is FeedListLoaded){
        preLoadedList.addAll((state as FeedListLoaded).feedList);
        emit(FeedListLoadingMore());
      }
      else if(state is FeedListError){
        preLoadedList.addAll((state as FeedListError).preloadedFeedList);
        emit(FeedListLoadingMore());
      }

      //API Call
      List<FeedListDm>? result =  await ApiClientService.fetchFeedList(lastReceivedPostId: lastReceivedPostId);
      bool hasReachedMax = false;
      if(result == null || (result.length < NumericConstants.defaultPageLimit)){
        hasReachedMax = true;
      }
      if(result?.isNotEmpty ?? false){
        lastReceivedPostId = (result.last.lastUpdatedAt ?? 0) * -1;
      }
      emit(FeedListLoaded(feedList: preLoadedList + (result ?? []), hasReachedMax: hasReachedMax));
    }
    catch(e){
      emit(FeedListError(error: e.toString(), preloadedFeedList: preLoadedList));
    }
  }
}