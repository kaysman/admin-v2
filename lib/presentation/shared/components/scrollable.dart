import 'package:flutter/material.dart';

class ScrollableWidget extends StatelessWidget {
  final Widget? child;
  const ScrollableWidget({Key? key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: child,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
