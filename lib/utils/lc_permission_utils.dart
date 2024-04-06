// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:lets_connect/utils/components/lc_button.dart';
import 'package:lets_connect/utils/translation_service.dart';
import 'package:permission_handler/permission_handler.dart';



class LcPermissionUtils{

  static Future<bool> validateFilePickerPermission({required BuildContext context}) async{
    if (Platform.isIOS) {
      return await validatePermission(permission: Permission.storage, context: context);
    } 
    else {
      bool storage = true;
      // Only check for storage < Android 13
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt < 33) {
        storage = await validatePermission(permission: Permission.storage, context: context);
      }
      return storage;
    }                      
  }


  static Future<bool> validatePermission({required Permission permission, required BuildContext context}) async{
    PermissionStatus newPermissionStatus =  await permission.request();

    if(newPermissionStatus.isPermanentlyDenied){
      await _showSettingsDialog(context: context, permission: permission);
    }
    return newPermissionStatus.isGranted;
    
  }

  static _showSettingsDialog({required BuildContext context, required Permission permission}) async{
    await showDialog(
      barrierDismissible: true,
      context: context, builder: (context){
      return AlertDialog(shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text('Permission required: ${permission.toString()}'),
        content: const Text('You do not have enough access permissions. Please go to your settings to grant the required permission.'),
        actions: [
          LcButton(
            type: ButtonType.solid,
            onPressed: openAppSettings,
            title: translationService.text('key_settings')!,
          )
        ],
      );
    });
  }
}