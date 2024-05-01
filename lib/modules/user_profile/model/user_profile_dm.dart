import 'dart:io';

import 'package:lets_connect/utils/data_model.dart';
import 'package:lets_connect/utils/lc_date_utils.dart';

class UserProfileDm extends DataModel{
  String? userId;
  String? userName;
  String? email;
  String? profilePicUrl;
  String? status;
  bool? isActive;
  num? lastUpdatedAt;
  
  //postId: liked
  Map<String, bool>? likes;

  //For UI Purpose Only
  File? profileImageFile;
  
  UserProfileDm(
    {
      this.userId,
      this.userName,
      this.email,
      this.profilePicUrl,
      this.status,
      this.isActive,
      this.lastUpdatedAt,
      this.profileImageFile,
      this.likes
    }
  );

  UserProfileDm.fromJson(Map<String, dynamic> json){
    userId = json['userId'];
    userName = json['userName'];
    email = json['email'];
    profilePicUrl = json['profilePicUrl'];
    status = json['status'];
    isActive = json['isActive'];
    lastUpdatedAt = json['lastUpdatedAt'];
    likes = json['likes'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['userName'] = userName;
    data['email'] = email;
    data['profilePicUrl'] = profilePicUrl;
    data['status'] = status;
    data['isActive'] = isActive ?? true;
    data['likes'] = likes;
    data['lastUpdatedAt'] = LcDateDbUtils.getLastUpdatedNegativeTimeStamp();
    return data;
  }
}
