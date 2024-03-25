import 'package:flutter/material.dart';

class LcActivityIndicator extends StatelessWidget {
  const LcActivityIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),
    );
  }
}

class LcRootActivityIndicator{
  static void showLoader(BuildContext context, {bool avoidInitialPop = false, bool transparentBackground = false}){
    try{
     if(!avoidInitialPop){
       hideLoader(context);
     }
    }catch(_){}
    try{
      showDialog(
        context: context,
        useRootNavigator: true,
        barrierDismissible: false,
        barrierColor: transparentBackground ? Colors.transparent : Colors.black54,
        builder: (BuildContext context) {
          return const LcActivityIndicator();
        },
      );
    }catch(_){}
  }

  static void hideLoader(BuildContext context){
   if(Navigator.of(context, rootNavigator: true).canPop()){
     Navigator.of(context, rootNavigator: true).pop();
   }
  }
}