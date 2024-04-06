import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lets_connect/utils/api_constants.dart';
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
  
  static Future post({required String endPoint, String? value, DataModel? body}) async{
    String url = '${ApiConstants.baseAPI}$endPoint';
    if(value != null){
      url += '/$value';
    }
    DatabaseReference db = firebaseDatabase.ref(url);

    db.set(body?.toJson());
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

}