import 'package:firebase_database/firebase_database.dart';
import 'package:lets_connect/utils/api_constants.dart';
import 'package:lets_connect/utils/data_model.dart';

class LcFirebaseUtils{

  static late final FirebaseDatabase firebaseDatabase;


  static Future<T?> get<T>({required String endPoint, String? value, required T Function(Map<String, dynamic>) fromJson}) async{
    String url = '/${ApiConstants.baseAPI}$endPoint';
    if(value != null){
      url += '/$value';
    }
    DatabaseReference db = firebaseDatabase.ref(url);
    DataSnapshot snapshot = await db.get();
    if(snapshot.exists && snapshot.value != null){
      return fromJson(snapshot.value as Map<String, dynamic>);
    }
    return null;
  }
  
  static Future post({required String endPoint, String? value, DataModel? body}) async{
    String url = '${ApiConstants.baseAPI}/$endPoint';
    if(value != null){
      url += '/$value';
    }
    DatabaseReference db = firebaseDatabase.ref(url);

    db.set(body?.toJson());
  }

}