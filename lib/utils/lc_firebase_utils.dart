import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lets_connect/utils/api_constants.dart';
import 'package:lets_connect/utils/app_constants.dart';
import 'package:lets_connect/utils/data_model.dart';

class LcFirebaseUtils{

  static late final FirebaseDatabase firebaseDatabase;
  static late final FirebaseStorage firebaseStorage;


  static Future<T?> get<T>({required String endPoint, String? value, required T Function(Map<String, dynamic>) fromJson}) async{
    String url = '${ApiConstants.baseAPI}$endPoint';
    if(value != null){
      url += '/$value';
    }
    DatabaseReference db = firebaseDatabase.ref(url);
    DataSnapshot snapshot = await db.get();
    if(snapshot.exists && snapshot.value != null){
      return fromJson(json.decode(json.encode(snapshot.value)) as Map<String, dynamic>);
    }
    return null;
  }
  
  static Future put({required String endPoint, String? value, DataModel? body}) async{
    String url = '${ApiConstants.baseAPI}$endPoint';
    if(value != null){
      url += '/$value';
    }
    DatabaseReference db = firebaseDatabase.ref(url);

    await db.set(body?.toJson());
  }

  static Future post({required String endPoint, DataModel? body}) async{
    String url = '${ApiConstants.baseAPI}$endPoint';
    
    DatabaseReference db = firebaseDatabase.ref(url).push();
    Map<String, dynamic>? bodyMap = body?.toJson();
    if(bodyMap != null){
      bodyMap['id'] = db.key;
    }
    await db.set(bodyMap);
  }

  static Future<String?> uploadFile(File file, {required String endPoint, String? value}) async{

    String url = '/${ApiConstants.baseAPI}$endPoint';
    if(value != null){
      url += '/$value';
    }
    final fileRef = firebaseStorage.ref(url);
    await fileRef.putFile(file);
    return await fileRef.getDownloadURL();
  }

  static Future fetchList({required String endPoint, num? lastFetchedId}) async{
    String url = '${ApiConstants.baseAPI}$endPoint';
    
    DatabaseReference db = firebaseDatabase.ref(url);
   
    // Query to fetch the list of feeds in chronological order
    Query query = db.orderByChild('lastUpdatedAt').limitToFirst(NumericConstants.defaultPageLimit);

    // If lastFetchedId is provided, start querying from the item after it
    if (lastFetchedId != null) {
      query = query.startAfter(lastFetchedId);
    }

    // Fetching the data
    DataSnapshot snapshot = (await query.once()).snapshot;

    // Extracting the value of the snapshot
    Map<String, dynamic>? values = json.decode(json.encode(snapshot.value)) as Map<String, dynamic>?;

    if (values != null) {
      // Convert values to a list and sort chronologically
      List<Map<String, dynamic>> list = values.values.toList().map((e) => json.decode(json.encode(e)) as Map<String, dynamic>).toList();
      list.sort((a, b) => (a['lastUpdatedAt'] as num).compareTo(b['lastUpdatedAt'] as num));

      // Printing the sorted feeds
      print(list);

      return list;
    } 

    return [];
  }

}