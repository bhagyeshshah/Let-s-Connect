
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_connect/modules/feeds/bloc/feed_list_bloc.dart';
import 'package:lets_connect/modules/feeds/model/feed_dm.dart';
import 'package:lets_connect/modules/feeds/ui/create_feed_view.dart';
import 'package:lets_connect/utils/base_state.dart';
import 'package:lets_connect/utils/components/lc_activity_indicator.dart';
import 'package:lets_connect/utils/components/lc_bottom_sheet.dart';
import 'package:lets_connect/utils/components/lc_empty_screen.dart';
import 'package:lets_connect/utils/components/lc_text.dart';
import 'package:lets_connect/utils/lc_date_utils.dart';
import 'package:lets_connect/utils/translation_service.dart';


class FeedListScreen extends StatefulWidget {
  
  const FeedListScreen({super.key});

  @override
  State<FeedListScreen> createState() => _FeedListScreenState();
}

class _FeedListScreenState extends BaseState<FeedListScreen> {
  
  //////////////////////////////////
  ///INITIALIZATION + DISPOSE
  //////////////////////////////////
  final List<FeedListDm> _feedItemList = [];
  final FeedListBloc _feedListBloc = FeedListBloc();
  bool hasReachedMax = false;
  final ScrollController _scrollController = ScrollController();
  Completer<void>? _refreshCompleter;

  @override
  void initState() {
    _feedListBloc.add(FetchFeedList());
    _scrollController.addListener(() { 
      if (!hasReachedMax 
      && (_scrollController.position.maxScrollExtent == _scrollController.position.pixels)
      && (_feedListBloc.state is! FeedListLoadingMore)) {
        _feedListBloc.add(FetchFeedList());
      }
    });
    _refreshCompleter = Completer<void>();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _feedListBloc.close();
    super.dispose();
  }
  
  //////////////////////////////////
  ///UI
  //////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showLcBottomSheet(
            context: context, 
            heightFactor: 0.9,
            child: const CreateFeedView());
        },
        child: const Icon(Icons.add),
      ),
      body: GestureDetector(
        onTap: (){
          //Dismissing the keyboard
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            _buildBody()
          ],
        ),
      )
    );
  }

  


  Widget _buildBody(){
    return Expanded(
      child: BlocConsumer(
        bloc: _feedListBloc,
        listener: (context, FeedState state){
          if(state is FeedListError){
            _feedItemList.clear();
            _feedItemList.addAll(state.preloadedFeedList);
            showErrorMessage(state.error);
          }
          else if(state is FeedListLoaded){
            _feedItemList.clear();
            _feedItemList.addAll(state.feedList);
            hasReachedMax = state.hasReachedMax;
            _refreshCompleter?.complete();
            _refreshCompleter = Completer();
          }
        },
        builder: (context, FeedState state){
          if(state is FeedListLoading && !state.isRefershing){
            return const LcActivityIndicator();
          }
          else if(_feedItemList.isEmpty){
            return LcEmptyScreen(
              title: translationService.text('key_no_data_found'),
              onLoadAgain: (){
                _feedListBloc.add(FetchFeedList());
              },
            );
          }
          return _buildList();
        },
      )
    );
  }

  Widget _buildList(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        backgroundColor: Theme.of(context).cardColor,
        color: Theme.of(context).primaryColor,
        child: ListView.separated(
          padding: EdgeInsets.zero,
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: hasReachedMax ? _feedItemList.length : (_feedItemList.length + 1),
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemBuilder: (context, index){
            if(_feedItemList.isNotEmpty){
              if(!hasReachedMax && index == _feedItemList.length){
                if(_feedListBloc.state is FeedListError){
                  return Container();
                }
                return const LcActivityIndicator();
              }
              return _buildItem(_feedItemList[index]);
            }
            return Container();
          }
        ),
      ),
    );
  }

  Widget _buildItem(FeedListDm item){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProfileBar(item),
        LcText.title(text: item.title ?? ''),
        LcText.subTitle(text: item.description ?? ''),
      ],
    );
  }

  Widget _buildProfileBar(FeedListDm item){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(item.authorPic ?? ''),
          ),
          const SizedBox(width: 8.0,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LcText.title(text: item.authorName ?? ''),
                LcText.subTitle(text: LcDateDbUtils.feedTime(item.lastUpdatedAt?.toInt() ?? 0)),
              ],
            )
          ),
        ],
      ),
    );
  }

  
  

  //////////////////////////////////
  ///ACTIONS
  //////////////////////////////////

  Future<void> _onRefresh() async{
    _feedListBloc.add(FetchFeedList(isRefresh: true));
    return await _refreshCompleter!.future;
  }
}