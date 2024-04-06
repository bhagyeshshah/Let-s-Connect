import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_connect/modules/app/bloc/app_flow_bloc.dart' as appFlowBloc;
import 'package:lets_connect/modules/auth/bloc/sign_in_bloc.dart';
import 'package:lets_connect/utils/base_state.dart';
import 'package:lets_connect/utils/components/lc_activity_indicator.dart';
import 'package:lets_connect/utils/components/lc_alert_dialog.dart';
import 'package:lets_connect/utils/translation_service.dart';

class SignOutButton extends StatefulWidget {
  Widget child;
  SignOutButton({super.key, required this.child});

  @override
  State<SignOutButton> createState() => _SignOutButtonState();
}

class _SignOutButtonState extends BaseState<SignOutButton> {

  SignInBloc signInBloc = SignInBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: signInBloc,
      listener: (context, SignInState state){
        if(state is SignInLoading){
          LcRootActivityIndicator.showLoader(context);
        }
        else if(state is SignInError){
          LcRootActivityIndicator.hideLoader(context);
          showErrorMessage(state.error);
        }
        else if(state is SignInSuccess){
          LcRootActivityIndicator.hideLoader(context);
          BlocProvider.of<appFlowBloc.AppFlowBloc>(context).add(appFlowBloc.SignOutEvent());
        }
      },
      builder: (context, SignInState state){
        return GestureDetector(
          onTap: (){
            LcAlert.showConfirmationAlertDialog(
              context: context, 
              title: translationService.text('key_signout_title')!,
              onAgree: (){
                signInBloc.add(SignOutButtonPressed());
              }
            );
          },
          child: widget.child,
        );
      }
    );
  }
}