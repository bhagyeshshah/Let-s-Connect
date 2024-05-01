
import 'package:flutter/material.dart';
import 'package:lets_connect/modules/user_profile/model/user_profile_dm.dart';
import 'package:lets_connect/utils/app_storage_singleton.dart';
import 'package:lets_connect/utils/components/lc_button.dart';
import 'package:lets_connect/utils/components/lc_text.dart';
import 'package:lets_connect/utils/components/lc_text_styles.dart';
import 'package:lets_connect/utils/translation_service.dart';

class CreateFeedView extends StatefulWidget {
  const CreateFeedView({super.key});

  @override
  State<CreateFeedView> createState() => _CreateFeedViewState();
}

class _CreateFeedViewState extends State<CreateFeedView> {

  //Controllers
  TextEditingController titleController = TextEditingController();
  TextEditingController subTitleController = TextEditingController();

  FocusNode subTitleFocus = FocusNode();

  @override
  void dispose() {
    titleController.dispose();
    subTitleController.dispose();
    subTitleFocus.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildTopRow(),
           Expanded(
             child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildProfileBar(appStorageSingleton.loggedInUser),
                  _buildTitleField(),
                  _buildSubTitleField(),
                ],
              ),
             ),
           )
            
          ],
        ),
      ),
    );
  }

  Widget _buildTopRow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDismissButton(),
        _buildSubmitButton()
      ],
    );
  }

  Widget _buildDismissButton(){
    return IconButton(
      onPressed: (){
        FocusScope.of(context).unfocus();
        Navigator.of(context).maybePop();
      }, 
      icon: const Icon(Icons.close, size: 35,)
    );
  }
  
  Widget _buildSubmitButton(){
    return LcButton(
      onPressed: (){
        FocusScope.of(context).unfocus();
        Navigator.of(context).maybePop();
      }, 
      title: translationService.text('key_post'),
    );
  }

  Widget _buildProfileBar(UserProfileDm? profile){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(profile?.profilePicUrl ?? ''),
          ),
          const SizedBox(width: 8.0,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LcText.title(text: profile?.userName ?? ''),
                LcText.subTitle(text: profile?.email ?? ''),
              ],
            )
          ),
        ],
      ),
    );
  }

  Widget _buildTitleField(){
    return TextFormField(
      controller: titleController,
      style: LcTextStyle.title()?.copyWith(fontSize: 22),
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      onFieldSubmitted: (value){
        FocusScope.of(context).requestFocus(subTitleFocus);
      },
      textInputAction: TextInputAction.next,
      maxLines: 2,
      minLines: 1,
      maxLength: 100,
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        hintText: translationService.text('key_post_about'),
        hintStyle: LcTextStyle.title()?.copyWith(color: Colors.grey, fontSize: 22),
        counterStyle: LcTextStyle.title()?.copyWith(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.normal, height: 0.0001),

      ),
    );
  }

  Widget _buildSubTitleField(){
    return TextFormField(
      controller: subTitleController,
      focusNode: subTitleFocus,
      style: LcTextStyle.title()?.copyWith(fontSize: 18, fontWeight: FontWeight.normal),
      maxLines: 8,
      minLines: 1,
      maxLength: 1000,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        hintText: translationService.text('key_post_description'),
        hintStyle: LcTextStyle.title()?.copyWith(color: Colors.grey, fontSize: 18),
        counterStyle: LcTextStyle.title()?.copyWith(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.normal),
      ),
    );
  }
}