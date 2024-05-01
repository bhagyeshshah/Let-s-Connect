import 'package:flutter/material.dart';
import 'package:lets_connect/utils/components/lc_text.dart';
import 'package:lets_connect/utils/translation_service.dart';

class LcEmptyScreen extends StatelessWidget {
  String? title;
  VoidCallback? onLoadAgain;
  LcEmptyScreen({super.key, this.title, this.onLoadAgain});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 40,),
        Center(
          child: LcText.empty(text: title ?? translationService.text('key_no_results_found')!),
        ),
        Visibility(
          visible: onLoadAgain != null,
          child: IconButton(onPressed: onLoadAgain, icon: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              shape: BoxShape.circle,
              boxShadow:[
                BoxShadow(
                  spreadRadius: 2.0,
                  blurRadius: 8.0,
                  color: Theme.of(context).disabledColor,)
              ],
            ),
            child: Center(child: Icon(Icons.refresh, color: Theme.of(context).primaryColor,)))),
        )
      ],
    );
  }
}