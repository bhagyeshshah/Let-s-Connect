import 'package:lets_connect/utils/data_model.dart';
import 'package:lets_connect/utils/lc_date_utils.dart';


class FeedResponseDm extends DataModel{
  List<FeedListDm>? items;
  int? totalSize;

  FeedResponseDm({this.items, this.totalSize});

  FeedResponseDm.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <FeedListDm>[];
      json['items'].forEach((v) {
        items!.add(FeedListDm.fromJson(v));
      });
    }
    totalSize = json['totalSize'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['totalSize'] = totalSize;
    return data;
  }
}



class FeedListDm extends DataModel{
  String? id;
  String? title;
  String? description;
  num? lastUpdatedAt;
  String? authorId;
  String? authorName;
  String? authorPic;
  int? likes;
  int? comments;
  List<String>? attachments;

  FeedListDm(
      {
      // this.id,
      this.title,
      this.description,
      // this.lastUpdatedAt,
      // this.authorId,
      // this.authorName,
      // this.authorPic,
      this.likes,
      this.comments,
      this.attachments});

  FeedListDm.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    lastUpdatedAt = (json['lastUpdatedAt'] * -1);
    authorId = json['authorId'];
    authorName = json['authorName'];
    authorPic = json['authorPic'];
    likes = json['likes'];
    comments = json['comments'];
    attachments = json['attachments']?.cast<String>();
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['lastUpdatedAt'] = LcDateDbUtils.getLastUpdatedNegativeTimeStamp();
    data['authorId'] = authorId;
    data['authorName'] = authorName;
    data['authorPic'] = authorPic;
    data['likes'] = likes;
    data['comments'] = comments;
    data['attachments'] = attachments;
    return data;
  }
}






  // "comments":[
  //   {
  //     "id": "",
  //     "postId": "",
  //     "description": "desc",
  //     "lastUpdated": "lastUpdated",
  //     "commentorId": "id",
  //     "commentorName": "name",
  //     "commentorPic": "url"
  //   }
  // ],