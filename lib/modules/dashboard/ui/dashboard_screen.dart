import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_connect/modules/app/bloc/app_flow_bloc.dart';
import 'package:lets_connect/utils/components/lc_button.dart';
import 'package:lets_connect/utils/translation_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LcButton(
          title: translationService.text('key_sign_out'),
          onPressed: (){
            BlocProvider.of<AppFlowBloc>(context).add(SignOutEvent());
          },
        )
        
      ),
    );
  }
}