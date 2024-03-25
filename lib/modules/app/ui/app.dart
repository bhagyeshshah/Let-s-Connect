import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_connect/modules/app/bloc/app_flow_bloc.dart';
import 'package:lets_connect/modules/app/ui/app_flow.dart';
import 'package:lets_connect/utils/lc_theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  //////////////////////////////////
  ///UI
  //////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _getBlocProviders(),
      child: _buildApp());
  }

  Widget _buildApp(){
    return MaterialApp(
      title: '',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const AppFlow()
    );
  }


  //List of blocs which should be accessed at global level or root level.
  List<BlocProvider> _getBlocProviders(){
    return [
      BlocProvider<AppFlowBloc>(
        create: (context) => AppFlowBloc(),
      )
    ];
  }
}