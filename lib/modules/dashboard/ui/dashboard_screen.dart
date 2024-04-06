import 'package:flutter/material.dart';
import 'package:lets_connect/modules/dashboard/ui/lc_bottom_navigation_bar.dart';
import 'package:lets_connect/modules/more/ui/more_screen.dart';
import 'package:lets_connect/utils/app_constants.dart';
import 'package:lets_connect/utils/app_storage_singleton.dart';
import 'package:lets_connect/utils/translation_service.dart';
import '../../../../utils/base_state.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends BaseState<DashboardScreen> {


  //////////////////////////////////
  ///INITIALIZATION
  //////////////////////////////////
  int currentDashboardIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  

  //////////////////////////////////
  ///UI
  //////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      
      body: SafeArea(
        bottom: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: _buildBody(),
          bottomNavigationBar: LcBottomNavigationBar(
            currentIndex: currentDashboardIndex,
            navigationItemList: _getNavigationBarItemList(),
            onTap: (index){
              setState(() {
                currentDashboardIndex = index;
              });
              switch(index){
                case DashboardNavigationIndex.home: onHomeNavigationTap(); break;
                case DashboardNavigationIndex.chat: onChatNavigationTap(); break;
                case DashboardNavigationIndex.more: onMoreNavigationTap(); break;
              }
            }
          ),
        ),
      ),
    );
  }

  Widget _buildBody(){
    return Column(
      children: [
        Expanded(
          child: IndexedStack(
            index: currentDashboardIndex,
            children: [
              Container(),
              Container(),
              const MoreScreen(),
            ],
          ),
        ),
      ],
    );
  }

  List<BottomNavigationBarItem> _getNavigationBarItemList(){
    return [
      BottomNavigationBarItem(
        icon: const Icon(Icons.home),
        label: translationService.text("key_home"),
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.chat_bubble),
        label: translationService.text("key_chats"),
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.more_rounded),
        label: translationService.text("key_more"),
      ),
    ];
  }

  /////////////////////////////
  ///ACTIONS
  ////////////////////////////
  
  void onHomeNavigationTap(){
    // appStorageSingleton.dashboardNavigatorKey.currentState?.popUntil((route) => route.isFirst);
    
  }

  void onChatNavigationTap(){
    // appStorageSingleton.dashboardNavigatorKey.currentState?.popUntil((route) => route.isFirst);
  }
  void onMoreNavigationTap(){
    // appStorageSingleton.dashboardNavigatorKey.currentState?.popUntil((route) => route.isFirst);
  }
}