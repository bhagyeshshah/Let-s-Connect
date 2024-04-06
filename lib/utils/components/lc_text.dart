import 'package:flutter/widgets.dart';
import 'package:lets_connect/utils/components/lc_text_styles.dart';

enum LcTextType{
  pageHeader,
  appBar,
  chatMessageSent,
  free
}

class LcText extends StatelessWidget {
  LcTextType? _type;
  String text;
  TextStyle? style;
  TextAlign? textAlign;

  LcText({super.key, required this.text, this.style, this.textAlign});

  LcText.pageHeader({super.key, required this.text, this.style, this.textAlign}){
    _type = LcTextType.pageHeader;
  }
  LcText.appBar({super.key, required this.text, this.style, this.textAlign}){
    _type = LcTextType.appBar;
  }
  LcText.chatMessageSent({super.key, required this.text, this.style, this.textAlign}){
    _type = LcTextType.chatMessageSent;
  }

  @override
  Widget build(BuildContext context) {
    return Text(text, style: style ?? getTextStyle(), textAlign: textAlign);
  }

  TextStyle? getTextStyle(){
    switch(_type ?? LcTextType.free){
      case LcTextType.pageHeader:
        return LcTextStyle.pageHeaderStyle();
      case LcTextType.chatMessageSent:
        return LcTextStyle.chatMessageSent();
      case LcTextType.appBar:
        return LcTextStyle.appBar();
      default: return null;
    }
  }
}