import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_connect/modules/app/bloc/app_flow_bloc.dart';
import 'package:lets_connect/modules/auth/bloc/sign_in_bloc.dart' as signInBloc;
import 'package:lets_connect/utils/base_state.dart';
import 'package:lets_connect/utils/components/lc_activity_indicator.dart';
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

class _SignInScreenState extends BaseState<SignInScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool obscureText = true;
  final _formKey = GlobalKey<FormState>();
  final signInBloc.SignInBloc _signInBloc = signInBloc.SignInBloc();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _signInBloc.close();
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
      child: Form(
        key: _formKey,
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
      obscureText: obscureText,
      validator: Validator.password,
      labelText: translationService.text('key_password'),
      suffix: GestureDetector(
        child: Icon(obscureText ? Icons.visibility : Icons.visibility_off, color: Theme.of(context).primaryColor,),
        onTap: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
      ),
    );
  }

  Widget _buildSignInButton(){
    return BlocConsumer(
      bloc: _signInBloc,
      listener: (context, signInBloc.SignInState state) {
        if(state is signInBloc.SignInError){
          LcRootActivityIndicator.hideLoader(context);
          showErrorMessage(state.error);
        }
        else if(state is signInBloc.SignInSuccess){
          LcRootActivityIndicator.hideLoader(context);
          BlocProvider.of<AppFlowBloc>(context).add(DashboardEvent());
        }
        else if(state is signInBloc.SignInLoading){
          LcRootActivityIndicator.showLoader(context);
        }
      },
      builder: (context, signInBloc.SignInState state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: LcButton(
            title: translationService.text('key_signin'),
            onPressed: () {
              if(_formKey.currentState!.validate()){
                FocusScope.of(context).unfocus();
                _signInBloc.add(signInBloc.SignInButtonPressed(email: _emailController.text.trim(), password: _passwordController.text));
              }
            },
          ),
        );
      }
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