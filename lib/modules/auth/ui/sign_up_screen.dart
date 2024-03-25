import 'package:flutter/foundation.dart';
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
  bool obscureText = true;
  final _formKey = GlobalKey<FormState>();
  ValueNotifier<bool> eightChars = ValueNotifier(false);
  ValueNotifier<bool> number = ValueNotifier(false);
  ValueNotifier<bool> upperCaseChar = ValueNotifier(false);
  ValueNotifier<bool> specialChar = ValueNotifier(false);


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
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTitle(),
            _buildEmailField(),
            _buildPasswordField(),
            _buildPasswordStrengthValidator(),
            _buildSignUpButton(),
            _buildSignInButton(),
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
      obscureText: obscureText,
      onChanged: (value){
        eightChars.value = value.length >= 8;
        number.value = value.contains(RegExp(r'\d'), 0);
        upperCaseChar.value = value.contains(RegExp(r'[A-Z]'), 0);
        specialChar.value = value.isNotEmpty && !value.contains(RegExp(r'^[\w&.-]+$'), 0);
      },
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

  Widget _buildPasswordStrengthValidator(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(10)
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        margin: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LcText(text: translationService.text("key_password_must_contain")!),
            _buildPasswordValidatorItem(text: translationService.text("key_eight_character")!, valueListenable: eightChars),
            _buildPasswordValidatorItem(text: translationService.text("key_one_punctuation")!, valueListenable: specialChar),
            _buildPasswordValidatorItem(text: translationService.text("key_one_number")!, valueListenable: number),
            _buildPasswordValidatorItem(text: translationService.text("key_one_letter_uppercase")!, valueListenable: upperCaseChar),

          ],
        ),
      ),
    );
  }

  Widget _buildPasswordValidatorItem({required String text, required ValueListenable valueListenable}){
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: valueListenable,
            builder: ((context, value, child) {
              if(!valueListenable.value){
                return const Icon(Icons.check_box_outline_blank, color: Colors.black38,);
              }
              return const Icon(Icons.check_box_rounded, color: Colors.green,);
            })
        ),
        LcText(text: text),
      ],
    );
  }

  Widget _buildSignUpButton(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LcButton(
        title: translationService.text('key_sign_up'),
        onPressed: () {
          if(_formKey.currentState!.validate()){
            FocusScope.of(context).unfocus();
          }
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