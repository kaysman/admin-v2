import 'package:flutter/material.dart';

class PermissionToggle extends StatefulWidget {
  final String title;
  const PermissionToggle({Key? key, required this.title}) : super(key: key);

  @override
  _PermissionToggleState createState() => _PermissionToggleState();
}

class _PermissionToggleState extends State<PermissionToggle> {
  bool _isToggled = false;
  bool get isToggled => _isToggled;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.bodyText1,
            )),
        Switch(
          value: _isToggled,
          onChanged: (value) {
            setState(() {
              _isToggled = value;
            });
          },
        )
      ],
    );
  }
}
