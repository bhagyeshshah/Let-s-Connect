import 'package:lets_connect/utils/data_model.dart';

class UserProfileDm extends DataModel{
  String? userId;
  String? userName;
  String? email;
  String? profilePicUrl;
  String? status;
  bool? isActive;
  num? lastUpdatedAt;

  UserProfileDm(
    {
      this.userId,
      this.userName,
      this.email,
      this.profilePicUrl,
      this.status,
      this.isActive,
      this.lastUpdatedAt
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
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['userName'] = userName;
    data['email'] = email;
    data['profilePicUrl'] = profilePicUrl;
    data['status'] = status;
    data['isActive'] = isActive;
    data['lastUpdatedAt'] = DateTime.now().toUtc();
    return data;
  }
}