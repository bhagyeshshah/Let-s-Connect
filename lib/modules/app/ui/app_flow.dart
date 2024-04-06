import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_connect/modules/app/bloc/app_flow_bloc.dart';
import 'package:lets_connect/utils/app_storage_singleton.dart';
import 'package:lets_connect/utils/base_state.dart';
import 'package:lets_connect/utils/components/lc_activity_indicator.dart';
import 'package:lets_connect/utils/route_utils.dart';

class AppFlow extends StatefulWidget {
  const AppFlow({super.key});

  @override
  State<AppFlow> createState() => _AppFlowState();
}

class _AppFlowState extends BaseState<AppFlow> {

  late AppFlowBloc appBloc;

  //Navigator key: This key will help us to manage the navigations at root level.
  GlobalKey<NavigatorState> get appFlowNavigatorKey => appStorageSingleton.appFlowNavigatorKey;
  
  @override
  void initState() {
    appBloc = BlocProvider.of<AppFlowBloc>(context);
    appBloc.add(AppStart());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => appBloc,
      child: BlocConsumer(
        bloc: appBloc,
        listener: (context, state) {
          if(state is SignInState){
            appFlowNavigatorKey.currentState!.pushNamedAndRemoveUntil(ConstRoutes.signIn, (route) => false);
          }
          else if(state is SignUpState){
            appFlowNavigatorKey.currentState!.pushNamedAndRemoveUntil(ConstRoutes.signUp, (route) => false);
          }
          else if(state is DashboardState){
            LcRootActivityIndicator.hideLoader(context);
            appFlowNavigatorKey.currentState!.pushNamedAndRemoveUntil(ConstRoutes.dashboard, (route) => false);
          }
          else if(state is ProfileState){
            LcRootActivityIndicator.hideLoader(context);
            appFlowNavigatorKey.currentState!.pushNamedAndRemoveUntil(ConstRoutes.userProfile, (route) => false);
          }
          else if(state is ForgotPasswordState){
            appFlowNavigatorKey.currentState!.pushNamed(ConstRoutes.forgotpassword);
          }
          else if(state is ErrorState){
            LcRootActivityIndicator.hideLoader(context);
            showErrorMessage(state.error);
          }
          else if(state is LoadingState){
            LcRootActivityIndicator.showLoader(context);
          }
          
        },
        builder: (context, AppFlowState state) {
          return PopScope(
            onPopInvoked: (bool didPop)async{
              if(didPop){
                return;
              }
              bool val = await popCondition(state);
              if(val){
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              }
            },
            canPop: false,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: GestureDetector(
                onTap: (){
                  FocusScope.of(context).unfocus();
                },
                child: Navigator(
                  key: appFlowNavigatorKey,
                  onGenerateRoute: ConstRoutes.generateRoute,
                  initialRoute: ConstRoutes.splash,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<bool> popCondition(AppFlowState state)async{
    if(state is DashboardState){
      bool? val = await appStorageSingleton.dashboardNavigatorKey.currentState?.maybePop();
      //Fixing to minimize the app from home page.
      // If we don't need this, then simply comment out the below if-condition.
      if(val == false){
        return true;
      }
      return false;
    }
    return false;
  }

}