import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:lets_connect/utils/app_storage_singleton.dart';
import 'package:lets_connect/utils/components/lc_text.dart';
import 'package:lets_connect/utils/translation_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bubble(),
    );
  }

  Widget bubble(){
    return Center(
      child: ChatBubble(
        alignment: Alignment.center,
        backGroundColor: Theme.of(context).primaryColor,
        clipper: ChatBubbleClipper3(type:BubbleType.sendBubble, radius: 20, nipSize: 12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LcText.chatMessageSent(text: translationService.text('key_app_name')!,),
        ),
      ),
    );
  }
}