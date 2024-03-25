import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_connect/modules/app/bloc/app_flow_bloc.dart';
import 'package:lets_connect/modules/auth/bloc/forgot_password_bloc.dart' as fpBloc;
import 'package:lets_connect/utils/base_state.dart';
import 'package:lets_connect/utils/components/lc_activity_indicator.dart';
import 'package:lets_connect/utils/components/lc_alert_dialog.dart';
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

class _ForgotPasswordScreenState extends BaseState<ForgotPasswordScreen> {

  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final fpBloc.ForgotPasswordBloc _forgotPasswordBloc = fpBloc.ForgotPasswordBloc();

  @override
  void dispose() {
    _emailController.dispose();
    _forgotPasswordBloc.close();
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
            _buildSubmitButton(),
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
    return BlocConsumer(
      bloc: _forgotPasswordBloc,
      listener: (context, fpBloc.ForgotPasswordState state){
        if(state is fpBloc.ForgotPasswordError){
          showErrorMessage(state.error);
          LcRootActivityIndicator.hideLoader(context);
        }
        else if(state is fpBloc.ForgotPasswordSuccess){
          LcRootActivityIndicator.hideLoader(context);
          showVerificationDialog();
        }
        else if(state is fpBloc.ForgotPasswordLoading){
          LcRootActivityIndicator.showLoader(context);
        }
        
      },
      builder: (context, fpBloc.ForgotPasswordState state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: LcButton(
            title: translationService.text('key_submit'),
            onPressed: () {
              if(_formKey.currentState?.validate() ?? false){
                _forgotPasswordBloc.add(fpBloc.ForgotPasswordButtonPressed(email: _emailController.text));              
              }
            },
          ),
        );
      }
    );
  }

  showVerificationDialog(){
    LcAlert.showAlertDialog(
      context: context, 
      title: translationService.text('key_password_reset')!,
      subTitle: translationService.text('key_password_reset_subtitle')!,
      actions: [
        LcButton(
          title: translationService.text('key_ok'),
          onPressed: (){
            Navigator.of(context, rootNavigator: true).maybePop();
            BlocProvider.of<AppFlowBloc>(context).add(SignInEvent());
          },
        )
      ]
    );
  }

  
}