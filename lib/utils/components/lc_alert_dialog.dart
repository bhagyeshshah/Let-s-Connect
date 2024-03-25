import 'package:flutter/material.dart';

class LcAlert{
  static showAlertDialog({required BuildContext context, required String title, List<Widget>? actions, String? subTitle}) async{
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text(title),
          content: subTitle != null ? Text(subTitle) : null,
          actions: actions,
        );
      }
    );
  }
}