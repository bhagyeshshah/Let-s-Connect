import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_connect/modules/app/bloc/app_flow_bloc.dart';
import 'package:lets_connect/modules/auth/ui/sign_out_button.dart';
import 'package:lets_connect/modules/user_profile/bloc/user_profile_bloc.dart';
import 'package:lets_connect/modules/user_profile/model/user_profile_dm.dart';
import 'package:lets_connect/utils/api_client_service.dart';
import 'package:lets_connect/utils/base_state.dart';
import 'package:lets_connect/utils/components/file/file_picker.dart';
import 'package:lets_connect/utils/components/lc_activity_indicator.dart';
import 'package:lets_connect/utils/components/lc_app_bar.dart';
import 'package:lets_connect/utils/components/lc_button.dart';
import 'package:lets_connect/utils/components/lc_text.dart';
import 'package:lets_connect/utils/components/lc_text_styles.dart';
import 'package:lets_connect/utils/components/lc_textfield.dart';
import 'package:lets_connect/utils/translation_service.dart';
import 'package:lets_connect/utils/validator.dart';

class UserProfileScreen extends StatefulWidget {
  final String? userId;
  const UserProfileScreen({super.key, required this.userId});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends BaseState<UserProfileScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  UserProfileDm? userProfileDm;
  ProfileBloc profileBloc = ProfileBloc();
  final _formKey = GlobalKey<FormState>();

  ValueNotifier<Widget> profileTextWidget = ValueNotifier(Container());
  ValueNotifier<ImageProvider?> profileImageWidget = ValueNotifier(null);

  File? profileImageFile;

  @override
  void initState() {
    if(widget.userId != null){
      profileBloc.add(FetchProfile(userId: widget.userId));    
    }
    else{
      _emailController.text = ApiClientService.currentUser?.email ?? '';
      setUpProfileTextWidget();
    }
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _userNameController.dispose();
    _statusController.dispose();
    profileBloc.close();
    super.dispose();
  }

  void _initializeProfileFields(UserProfileDm? profileDm){
    userProfileDm = profileDm ?? UserProfileDm();
    _emailController.text = profileDm?.email ?? '';
    _userNameController.text = profileDm?.userName ?? '';
    _statusController.text = profileDm?.status ?? '';
    if(userProfileDm?.profilePicUrl == null){
      setUpProfileTextWidget();
    }else{
      setUpProfileImageWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
            Expanded(
              child: _buildBody(),
            )
          ],
        ),
      )
    );
  }

  Widget _buildBody(){
    return BlocConsumer(
      bloc: profileBloc,
      listener: (context, state){
        if(state is ProfileError){
          LcRootActivityIndicator.hideLoader(context);
          showErrorMessage(state.error);
        }
        else if(state is ProfileLoaded){
          _initializeProfileFields(state.profileDm);
        }
        else if(state is ProfileLSaving){
          LcRootActivityIndicator.showLoader(context);
        }
        else if(state is ProfileLSaved){
          showSuccessMessage(translationService.text('key_profile_saved')!);
          LcRootActivityIndicator.hideLoader(context);
          if(widget.userId == null){
            BlocProvider.of<AppFlowBloc>(context).add(DashboardEvent());
          }
        }
        
      },
      builder: (context, state) {
        if(state is ProfileLoading){
          return const LcActivityIndicator();
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _builProfilePic(),
                  const SizedBox(height: 24,),
                  _buildUsernameField(),
                  const SizedBox(height: 12,),
                  _buildEmailField(),
                  const SizedBox(height: 12,),
                  _buildStatusField(),
                  const SizedBox(height: 24,),
                  _buildSaveButton(),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  Widget _builProfilePic(){
    double radius = MediaQuery.of(context).size.shortestSide/4;
    return Stack(
      alignment: Alignment.center,
      children: [
        ValueListenableBuilder(
          valueListenable: profileImageWidget,
              builder: (context, value, child) {
            return ValueListenableBuilder(
              valueListenable: profileTextWidget,
              builder: (context, value, child) {
                return Hero(
                  tag: 'profile',
                  transitionOnUserGestures: true,
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.shortestSide/4,
                    backgroundImage: profileImageWidget.value,
                    child: profileImageWidget.value == null ? profileTextWidget.value : null,
                  ),
                );
              }
            );
          }
        ),
        Positioned(
          bottom:(radius) - (radius/(sqrt(2))) - 25,
          right:(radius) - (radius/(sqrt(2))) - 25,
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () async{
              profileImageFile = await LcImagePicker.pickUpImageFile(context, widget.userId ?? ApiClientService.currentUser?.uid);
              setUpProfileImageWidget();
            },
            mini: true,
            child: const Icon(Icons.photo_camera, color: Colors.white, size: 25),
          )
        )
      ],
    );
  }

  Widget _buildEmailField(){
    return LcTextField(
      enabled: false,
      controller: _emailController,
      validator: Validator.email,
      labelText: translationService.text('key_email'),
      onChanged: (val){
        if(userProfileDm?.profilePicUrl?.isEmpty ?? true){
          setUpProfileTextWidget();
        }
      },
    );
  }

  Widget _buildUsernameField(){
    return LcTextField(
      controller: _userNameController,
      validator: (value){
        return Validator.lengthLimitter(value, isRequired: true, label: translationService.text('key_username'));
      },
      labelText: translationService.text('key_username'),
      onChanged: (val){
        if(userProfileDm?.profilePicUrl?.isEmpty ?? true){
          setUpProfileTextWidget();
        }
      },
    );
  }

  Widget _buildStatusField(){
    return LcTextField(
      controller: _statusController,
      validator: (value){
        return Validator.lengthLimitter(value, isRequired: true, label: translationService.text('key_status'));
      },
      labelText: translationService.text('key_status'),
    );
  }

  Widget _buildSaveButton(){
    return LcButton(
      title: translationService.text('key_save'),
      onPressed: () {
        if(_formKey.currentState!.validate()){
          FocusScope.of(context).unfocus();
          userProfileDm ??= UserProfileDm();
          userProfileDm?.userId = widget.userId ?? ApiClientService.currentUser?.uid;
          userProfileDm?.email = _emailController.text;
          userProfileDm?.userName = _userNameController.text;
          userProfileDm?.status = _statusController.text;
          userProfileDm?.profileImageFile = profileImageFile;
          profileBloc.add(SaveProfile(userProfileDm: userProfileDm));
        }
      },
    );
  }

  void setUpProfileImageWidget(){
    if(profileImageFile != null){
      profileImageWidget.value = FileImage(profileImageFile!);
    }
    else if(userProfileDm?.profilePicUrl != null){
      profileImageWidget.value = NetworkImage(userProfileDm!.profilePicUrl!);
    }
  }
  void setUpProfileTextWidget(){
    if(_userNameController.text.isNotNullAndNotEmpty()){
      profileTextWidget.value = LcText.pageHeader(text: _userNameController.text.characters.first.toUpperCase(), style: LcTextStyle.pageHeaderStyle()?.copyWith(fontSize: 96),);
    }
    else if(_emailController.text.isNotNullAndNotEmpty()){
      profileTextWidget.value = LcText.pageHeader(text: _emailController.text.characters.first.toUpperCase(), style: LcTextStyle.pageHeaderStyle()?.copyWith(fontSize: 96),);
    }
  }
}