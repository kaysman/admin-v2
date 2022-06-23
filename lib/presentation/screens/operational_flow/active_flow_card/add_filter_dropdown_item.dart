import 'package:flutter/material.dart';
import 'package:lng_adminapp/presentation/shared/colors.dart';

class AddFilterDropdownItem extends StatefulWidget {
  final String value;
  const AddFilterDropdownItem({Key? key, required this.value})
      : super(key: key);

  @override
  _AddFilterDropdownItemState createState() => _AddFilterDropdownItemState();
}

class _AddFilterDropdownItemState extends State<AddFilterDropdownItem> {
  bool? _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          side: BorderSide(color: kPrimaryColor),
          value: _isChecked,
          onChanged: (value) {
            setState(() {
              _isChecked = value;
            });
          },
        ),
        Text(widget.value, style: Theme.of(context).textTheme.bodyText1),
      ],
    );
  }
}
