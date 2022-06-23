import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/shared.dart';

class FilterDropdownButton extends StatefulWidget {
  final String title;

  const FilterDropdownButton({Key? key, required this.title}) : super(key: key);

  @override
  _FilterDropdownButtonState createState() => _FilterDropdownButtonState();
}

class _FilterDropdownButtonState extends State<FilterDropdownButton> {
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 0.25.sw,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 45,
                  color: const Color(0xff000000).withOpacity(0.1),
                ),
              ],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              DropdownButton<String>(
                value: dropdownValue,
                borderRadius: BorderRadius.circular(10),
                // icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: Theme.of(context).textTheme.bodyText2,
                underline: Container(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['One', 'Two', 'Three', 'Four']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 16,
        ),
        FlatButton(onPressed: () {}, child: AppIcons.svgAsset(AppIcons.delete)),
      ],
    );
  }
}
