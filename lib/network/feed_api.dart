import 'dart:math';

import 'package:lets_connect/modules/feeds/model/feed_dm.dart';
import 'package:lets_connect/utils/api_constants.dart';
import 'package:lets_connect/utils/app_storage_singleton.dart';
import 'package:lets_connect/utils/lc_firebase_utils.dart';

class FeedApi{
  static createFeed(FeedListDm feedListDm) async{
    feedListDm.authorId = appStorageSingleton.loggedInUser?.userId;
    feedListDm.authorName = appStorageSingleton.loggedInUser?.userName;
    feedListDm.authorPic = appStorageSingleton.loggedInUser?.profilePicUrl;
    await LcFirebaseUtils.post(endPoint: ApiConstants.feeds, body: feedListDm);
  }

  static Future<List<FeedListDm>> fetchFeedList({num? lastReceivedPostId}) async{
    List response = await LcFirebaseUtils.fetchList(endPoint: ApiConstants.feeds, lastFetchedId: lastReceivedPostId);
    return response.map((e) => FeedListDm.fromJson(e)).toList();
  }
}