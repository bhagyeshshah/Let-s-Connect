import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_connect/modules/app/bloc/app_flow_bloc.dart';
import 'package:lets_connect/utils/components/lc_button.dart';
import 'package:lets_connect/utils/components/lc_text.dart';
import 'package:lets_connect/utils/components/lc_textfield.dart';
import 'package:lets_connect/utils/translation_service.dart';
import 'package:lets_connect/utils/validator.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTitle(),
          _buildEmailField(),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildTitle(){
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          LcText.pageHeader(text: translationService.text('key_forgot_password')!, textAlign: TextAlign.left,),
        ],
      ),
    );
  }

  Widget _buildEmailField(){
    return LcTextField(
      controller: _emailController,
      validator: Validator.email,
      labelText: translationService.text('key_email'),
    );
  }


  Widget _buildSubmitButton(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LcButton(
        title: translationService.text('key_submit'),
        onPressed: () {
          BlocProvider.of<AppFlowBloc>(context).add(SignInEvent());
        },
      ),
    );
  }

  
}