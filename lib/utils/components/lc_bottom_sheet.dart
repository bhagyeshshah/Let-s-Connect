

import 'package:flutter/material.dart';
import 'package:lets_connect/utils/app_constants.dart';


showLcBottomSheet({required BuildContext context, required Widget child, double heightFactor = 1.0})async{
  return await showModalBottomSheet(
    context: context, 
    isScrollControlled: true,
    backgroundColor: Colors.white,
    isDismissible: true,
    elevation: 20,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(NumericConstants.borderRadius))
    ),
    // barrierColor: Colors.transparent,
    enableDrag: false,
    builder: (context){
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(NumericConstants.borderRadius)),
        child: FractionallySizedBox(
          heightFactor: heightFactor,
          child: child));
    }
  );
}