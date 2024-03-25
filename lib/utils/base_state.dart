import 'dart:async';

import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_connect/utils/translation_service.dart';


class BaseState<T extends StatefulWidget> extends State<T> {

  String screenName = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

  showErrorMessage(String message)async{
    if(message.trim().isEmpty){
      return;
    }
    final bgGradient = LinearGradient(colors: [Colors.red.shade400, Colors.red.shade800]);
    await showFlash(
      context: context,
      duration: const Duration(seconds: 3),
      builder: (context, controller) {
        return FlashBar(
          controller: controller,
          useSafeArea: false,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          position: FlashPosition.bottom,
          behavior: FlashBehavior.floating,
          padding: EdgeInsets.zero,
          margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: MediaQuery.of(context).padding.top),
          insetAnimationDuration: const Duration(milliseconds: 500),
          content: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: bgGradient,
                    borderRadius: BorderRadius.circular(8.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      message, 
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
       
      },
    );
  }
  showSuccessMessage(String message)async{
    final bgGradient = LinearGradient(colors: [Colors.green.shade400, Colors.green.shade800]);
    await showFlash(
      context: context,
      duration: const Duration(seconds: 3),
      builder: (context, controller) {
        return FlashBar(
          controller: controller,
          useSafeArea: false,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          position: FlashPosition.bottom,
          behavior: FlashBehavior.floating,
          padding: EdgeInsets.zero,
          margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: MediaQuery.of(context).padding.top),
          insetAnimationDuration: const Duration(milliseconds: 500),
          content: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: bgGradient,
                    borderRadius: BorderRadius.circular(8.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      message, 
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }  
}

