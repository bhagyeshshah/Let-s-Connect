import 'package:lets_connect/modules/user_profile/model/user_profile_dm.dart';
import 'package:lets_connect/utils/api_constants.dart';
import 'package:lets_connect/utils/lc_firebase_utils.dart';

class UserProfileApi{
  
  static Future saveProfile({required UserProfileDm userProfileDm}) async{
   await  LcFirebaseUtils.post(endPoint: ApiConstants.users, value: userProfileDm.userId, body: userProfileDm);
  }
  
  static Future<UserProfileDm?> fetchProfile({required String userId}) async{
   return await LcFirebaseUtils.get<UserProfileDm>(endPoint: ApiConstants.users, value: userId, fromJson: UserProfileDm.fromJson);
  }

}