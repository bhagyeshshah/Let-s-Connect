import 'package:flutter/material.dart';
import 'package:lets_connect/modules/auth/ui/sign_out_button.dart';
import 'package:lets_connect/utils/components/lc_app_bar.dart';
import 'package:lets_connect/utils/translation_service.dart';

class UserProfileScreen extends StatefulWidget {
  final String? userId;
  const UserProfileScreen({super.key, required this.userId});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            LcAppBar(
              title: translationService.text('key_user_profile'),
              actions: widget.userId == null ? Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: SignOutButton(
                  child: const Icon(Icons.logout),
                ),
              ): null
            ),
            
          ],
        )
      ),
    );
  }
}