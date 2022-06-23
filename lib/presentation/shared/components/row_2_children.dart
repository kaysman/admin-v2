import 'package:flutter/material.dart';

class RowOfTwoChildren extends StatelessWidget {
  const RowOfTwoChildren({
    Key? key,
    required this.child1,
    required this.child2,
    this.flex1 = 1,
    this.flex2 = 1,
  })  : assert(flex1 != null),
        assert(flex2 != null),
        super(key: key);

  final Widget child1;
  final Widget child2;

  final int? flex1;
  final int? flex2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: flex1!,
          child: Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: child1,
          ),
        ),
        Expanded(
          flex: flex2!,
          child: child2,
        ),
      ],
    );
  }
}
