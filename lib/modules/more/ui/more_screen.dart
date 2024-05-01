import 'package:flutter/material.dart';
import 'package:lets_connect/modules/auth/ui/sign_out_button.dart';
import 'package:lets_connect/modules/user_profile/model/user_profile_dm.dart';
import 'package:lets_connect/utils/app_storage_singleton.dart';
import 'package:lets_connect/utils/components/lc_button.dart';
import 'package:lets_connect/utils/components/lc_text.dart';
import 'package:lets_connect/utils/route_utils.dart';
import 'package:lets_connect/utils/translation_service.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _buildProfileTile(appStorageSingleton.loggedInUser),
            _buildSignOut(),
            // const Divider(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileTile(UserProfileDm? userProfileDm){
    return GestureDetector(
      onTap: () async{
        await appStorageSingleton.appFlowNavigatorKey.currentState?.pushNamed(ConstRoutes.userProfile, arguments: userProfileDm?.userId);
        setState(() {});
      },
      child: Row(
        children: [
          Hero(
            tag: 'profile',
            transitionOnUserGestures: true,
            child: Container(
              height: MediaQuery.of(context).size.shortestSide/5,
              width: MediaQuery.of(context).size.shortestSide/5,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                shape: BoxShape.circle
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.shortestSide/10),
                child: Image.network(userProfileDm?.profilePicUrl ?? '', fit: BoxFit.fill,)),
            ),
          ),
          const SizedBox(width: 8.0,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LcText.title(text: userProfileDm?.userName ?? '',),
                LcText.subTitle(text: userProfileDm?.email ?? '',),
              ],
            )
          ),
          const Icon(Icons.arrow_forward_ios),
          const SizedBox(width: 8.0,)
        ],
      ),
    );
  }

  Widget _buildSignOut(){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SignOutButton(
        child: AbsorbPointer(
          child: LcButton(
            title: translationService.text('key_sign_out'),
            onPressed: (){
              // BlocProvider.of<AppFlowBloc>(context).add(SignOutEvent());
            },
          ),
        ),
      ),
    );
  }
}