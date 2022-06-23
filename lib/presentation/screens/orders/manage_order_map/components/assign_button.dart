import 'package:flutter/material.dart';
import 'package:lng_adminapp/shared.dart';

class AssignButton extends StatelessWidget {
  const AssignButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 7,
          horizontal: 12,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: Theme.of(context).textTheme.bodyText2?.copyWith(color: kWhite),
      ),
    );
  }
}
