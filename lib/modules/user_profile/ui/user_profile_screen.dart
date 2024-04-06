import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_connect/modules/auth/ui/sign_out_button.dart';
import 'package:lets_connect/modules/user_profile/bloc/user_profile_bloc.dart';
import 'package:lets_connect/modules/user_profile/model/user_profile_dm.dart';
import 'package:lets_connect/utils/api_client_service.dart';
import 'package:lets_connect/utils/base_state.dart';
import 'package:lets_connect/utils/components/lc_activity_indicator.dart';
import 'package:lets_connect/utils/components/lc_app_bar.dart';
import 'package:lets_connect/utils/components/lc_button.dart';
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

  @override
  void initState() {
    if(widget.userId != null){
      profileBloc.add(FetchProfile(userId: widget.userId));    
    }
    else{
      _emailController.text = ApiClientService.currentUser?.email ?? '';
    }
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _userNameController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  void _initializeProfileFields(UserProfileDm? profileDm){
    userProfileDm = profileDm;
    _emailController.text = profileDm?.email ?? '';
    _userNameController.text = profileDm?.userName ?? '';
    _statusController.text = profileDm?.status ?? '';
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
            Expanded(
              child: _buildBody(),
            )
          ],
        )
      ),
    );
  }

  Widget _buildBody(){
    return BlocConsumer(
      bloc: profileBloc,
      listener: (context, state){
        if(state is ProfileError){
          showErrorMessage(state.error);
        }
        else if(state is ProfileLoaded){
          _initializeProfileFields(state.profileDm);
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
        CircleAvatar(
          radius: MediaQuery.of(context).size.shortestSide/4,
          child: Container(),
        ),
        Positioned(
          bottom:(radius) - (radius/(sqrt(2))) - 25,
          right:(radius) - (radius/(sqrt(2))) - 25,
          child: Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.amber,
            ),
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
    );
  }

  Widget _buildUsernameField(){
    return LcTextField(
      controller: _userNameController,
      validator: (value){
        return Validator.lengthLimitter(value, isRequired: true, label: translationService.text('key_username'));
      },
      labelText: translationService.text('key_username'),
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
        }
      },
    );
  }
}