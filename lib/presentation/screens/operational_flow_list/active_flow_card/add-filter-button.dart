import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/presentation/shared/colors.dart';

import 'add_filter_dropdown_item.dart';

class AddFilterButton extends StatefulWidget {
  const AddFilterButton({Key? key}) : super(key: key);

  @override
  _AddFilterButtonState createState() => _AddFilterButtonState();
}

class _AddFilterButtonState extends State<AddFilterButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButton(
        borderRadius: BorderRadius.circular(10),
        underline: Container(),
        hint: Text(
          'Add Filter',
          style: GoogleFonts.inter(fontSize: 14.sp, color: kPrimaryColor),
        ),
        items: <String>['One', 'Two', 'Three', 'Four']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            enabled: false,
            value: value,
            child: AddFilterDropdownItem(
              value: value,
            ),
          );
        }).toList(),
        onChanged: (value) {},
      ),
    );
  }
}
