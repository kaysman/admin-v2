import 'package:flutter/material.dart';
import 'package:lng_adminapp/shared.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({
    Key? key,
    required this.body,
    required this.sideBarItems,
  }) : super(key: key);

  final Widget body;
  final List<SideBarItem> sideBarItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyBackground,
      body: Row(
        children: [
          CollapsibleSideBar(items: sideBarItems),
          Expanded(child: body),
        ],
      ),
    );
  }
}
