import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/shared.dart';
import 'package:search_choices/search_choices.dart';

class AddDriverButton extends StatefulWidget {
  const AddDriverButton({required this.list});

  final List<List<String>> list;

  @override
  _AddDriverButtonState createState() => _AddDriverButtonState();
}

class _AddDriverButtonState extends State<AddDriverButton> {
  List<int> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    var items = widget.list.map((List<String> value) {
      return DropdownMenuItem<String>(
        value: value[1],
        child: Row(
          children: [
            Text(value[1], style: Theme.of(context).textTheme.bodyText1),
          ],
        ),
      );
    }).toList();
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 16),
      child: SearchChoices.multiple(
        items: items,
        icon: null,
        selectedItems: selectedItems,
        hint: Row(
          children: [
            AppIcons.svgAsset(
              AppIcons.add,
              height: 16.sp,
              width: 16.sp,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'Add Driver',
              style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        searchHint: "Select any",
        onChanged: (value) {
          setState(() {
            selectedItems = value;
          });
        },
        closeButton: (selectedItems) {
          return (selectedItems.isNotEmpty
              ? "Save ${selectedItems.length == 1 ? '"' + items[selectedItems.first].value.toString() + '"' : '(' + selectedItems.length.toString() + ')'}"
              : "Save without selection");
        },
        //isExpanded: true,
      ),
    );
  }
}
