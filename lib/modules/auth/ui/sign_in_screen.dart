import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_connect/modules/app/bloc/app_flow_bloc.dart';
import 'package:lets_connect/utils/components/lc_button.dart';
import 'package:lets_connect/utils/components/lc_text.dart';
import 'package:lets_connect/utils/components/lc_textfield.dart';
import 'package:lets_connect/utils/translation_service.dart';
import 'package:lets_connect/utils/validator.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

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
          _buildForgotPasswordButton(),
          _buildSignInButton(),
          _buildSignUpButton()
        ],
      ),
    );
  }

  Widget _buildTitle(){
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          LcText.pageHeader(text: translationService.text('key_signin')!, textAlign: TextAlign.left,),
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

  Widget _buildSignInButton(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LcButton(
        title: translationService.text('key_signin'),
        onPressed: () {
        },
      ),
    );
  }

  Widget _buildForgotPasswordButton(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        LcButton(
          type: ButtonType.text,
          title: translationService.text('key_forgot_password'),
          onPressed: (){
            BlocProvider.of<AppFlowBloc>(context).add(ForgotPasswordEvent());
          },
        ),
      ],
    );
  }
  Widget _buildSignUpButton(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LcText(text: translationService.text('key_no_account')!),
        LcButton(
          type: ButtonType.text,
          title: translationService.text('key_sign_up'),
          onPressed: (){
            BlocProvider.of<AppFlowBloc>(context).add(SignUpEvent());
          },
        )
      ],
    );
  }
}