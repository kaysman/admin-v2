import 'package:flutter/material.dart';

import '../colors.dart';

class ProgressIndicatorSmall extends StatelessWidget {
  final Color color;

  const ProgressIndicatorSmall({
    Key? key,
    this.color = kWhite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 15,
        width: 15,
        child: CircularProgressIndicator(
          color: color,
          strokeWidth: 2,
        ),
      ),
    );
  }
}
