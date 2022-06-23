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
      body: LayoutBuilder(builder: (context, constraints) {
        return Row(
          children: [
            CollapsibleSideBar(
              minWidth: 62,
              maxWidth: constraints.maxWidth * 0.20,
              items: sideBarItems,
              isCollapsed: constraints.maxWidth < 1000,
            ),
            Expanded(child: body),
          ],
        );
      }),
    );
  }
}
