import 'package:flutter/material.dart';
import 'package:lets_connect/utils/components/lc_button.dart';
import 'package:lets_connect/utils/translation_service.dart';

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

  static showConfirmationAlertDialog({
    required BuildContext context, 
    required String title, 
    VoidCallback? onAgree
  }) async{
    var val = await showDialog(
      context: context, 
      builder: (context){
        return MwConfirmationDialog(
          text: title,
        );
      });
    if(val == true){
     onAgree?.call();
    }
  }

}

class MwConfirmationDialog extends StatelessWidget {
  final String? text;
  const MwConfirmationDialog({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shadowColor: Colors.transparent,
      title: Text(
        translationService.text('key_are_you_sure')!
      ),
      content: Text(text ?? ''),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LcButton(
              type: ButtonType.outline, 
              title: translationService.text('key_yes')!,
              onPressed: (){
                Navigator.of(context).maybePop(true);
              },
            ),
            const SizedBox(width: 10,),
            LcButton(
              type: ButtonType.solid, 
              title: translationService.text('key_no')!,
              onPressed: (){
                Navigator.of(context).maybePop(false);
              },
            ),
          ],
        ),
      ],
    );
  }
}
