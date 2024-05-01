import 'package:lets_connect/modules/feeds/model/feed_dm.dart';
import 'package:lets_connect/utils/api_constants.dart';
import 'package:lets_connect/utils/app_storage_singleton.dart';
import 'package:lets_connect/utils/lc_firebase_utils.dart';

class FeedApi{
  static createFeeds() async{
    for(int i = 0; i <= 20; i++){
      Future.delayed(const Duration(seconds: 1));
      await LcFirebaseUtils.post(endPoint: ApiConstants.feeds, body: FeedListDm(
        authorId: appStorageSingleton.loggedInUser?.userId,
        authorName: appStorageSingleton.loggedInUser?.userName,
        authorPic: appStorageSingleton.loggedInUser?.profilePicUrl,
        description: 'Description $i',
        title: 'Title $i',
      ));
    }
  }

  static Future<List<FeedListDm>> fetchFeedList({num? lastReceivedPostId}) async{
    List response = await LcFirebaseUtils.fetchList(endPoint: ApiConstants.feeds, lastFetchedId: lastReceivedPostId);
    return response.map((e) => FeedListDm.fromJson(e)).toList();

  }
}