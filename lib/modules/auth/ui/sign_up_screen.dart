import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_connect/modules/app/bloc/app_flow_bloc.dart';
import 'package:lets_connect/utils/components/lc_button.dart';
import 'package:lets_connect/utils/components/lc_text.dart';
import 'package:lets_connect/utils/components/lc_textfield.dart';
import 'package:lets_connect/utils/translation_service.dart';
import 'package:lets_connect/utils/validator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
          _buildPasswordField(),
          _buildSignUpButton(),
          _buildSignInButton(),
        ],
      ),
    );
  }

  Widget _buildTitle(){
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          LcText.pageHeader(text: translationService.text('key_sign_up')!, textAlign: TextAlign.left,),
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

  Widget _buildPasswordField(){
    return LcTextField(
      controller: _passwordController,
      validator: Validator.password,
      labelText: translationService.text('key_password'),
    );
  }

  Widget _buildSignUpButton(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LcButton(
        title: translationService.text('key_sign_up'),
        onPressed: () {
        },
      ),
    );
  }

  Widget _buildSignInButton(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LcText(text: translationService.text('key_already_account')!),
        LcButton(
          type: ButtonType.text,
          title: translationService.text('key_signin'),
          onPressed: (){
            BlocProvider.of<AppFlowBloc>(context).add(SignInEvent());
          },
        )
      ],
    );
  }
}