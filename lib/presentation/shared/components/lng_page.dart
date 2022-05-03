import 'package:flutter/material.dart';

class LngPage extends StatelessWidget {
  const LngPage({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 24,
      ),
      child: this.child,
    );
  }
}
