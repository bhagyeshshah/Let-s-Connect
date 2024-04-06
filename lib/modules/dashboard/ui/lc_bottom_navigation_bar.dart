

import 'package:flutter/material.dart';


class LcBottomNavigationBar extends StatefulWidget {

  int currentIndex;
  void Function(int)? onTap; 
  List<BottomNavigationBarItem> navigationItemList;
  
  LcBottomNavigationBar({super.key, required this.currentIndex, required this.navigationItemList, this.onTap});

  @override
  State<LcBottomNavigationBar> createState() => _LcBottomNavigationBarState();
}

class _LcBottomNavigationBarState extends State<LcBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20))
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          selectedItemColor: Theme.of(context).cardColor,
          unselectedItemColor: Theme.of(context).cardColor.withOpacity(0.5),
          iconSize: 40,
          backgroundColor: Theme.of(context).primaryColor,
          currentIndex: widget.currentIndex,
          onTap: (value) {
            widget.currentIndex = value;
            widget.onTap?.call(value);
          },
          items: widget.navigationItemList
        ),
      ),
    );
  }

  


}