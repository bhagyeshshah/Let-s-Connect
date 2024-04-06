import 'package:flutter/material.dart';
import 'package:lets_connect/utils/components/lc_text.dart';


class LcAppBar extends StatelessWidget{
  String? title;
  VoidCallback? onBack;
  Widget? actions;
  bool showBackButton;

  LcAppBar({super.key, this.title, this.onBack, this.actions, this.showBackButton = true});



  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      bottomOpacity: 0.0,
      centerTitle: true,
      automaticallyImplyLeading: true,
      primary: false,
      leading: backButton(context),
      title: LcText.appBar(text: title ?? ''),
      actions: [
        if(actions != null)
          actions!
        
      ],
    );

  }

  
  Widget backButton(BuildContext context){
    return Visibility(
      visible: Navigator.of(context).canPop() && showBackButton,
      child: IconButton(
        onPressed: (){
          if(onBack != null){
            onBack?.call();
          }
          else{
            Navigator.of(context).maybePop();
          }
        }, 
        icon: const Icon(Icons.arrow_back_ios_new)
      ),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

 