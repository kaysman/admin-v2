import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/data/data.dart';
import 'package:lng_adminapp/presentation/shared/colors.dart';
import 'package:lng_adminapp/presentation/shared/components/dropdowns.dart';

import '../icons.dart';
import 'date_pickers.dart';

/// -------------------------------------------------------
/// TODO leave a note
/// -------------------------------------------------------
class LabeledInput extends StatelessWidget {
  const LabeledInput({
    Key? key,
    required this.label,
    required this.controller,
    this.hintText,
    this.suffixIcon,
    this.validator,
    this.onTap,
    this.saved,
    this.autovalidateMode,
    this.isEnabled,
    this.maxLine = 1,
  }) : super(key: key);

  final String label;
  final String? hintText;
  final bool? isEnabled;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? saved;
  final AutovalidateMode? autovalidateMode;
  final int maxLine;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.caption),
        SizedBox(
          height: 8.h,
        ),
        SizedBox(
          height: maxLine != 1 ? null : 34.0,
          child: TextFormField(
            controller: controller,
            style: Theme.of(context).textTheme.bodyText1,
            enabled: isEnabled ?? true,
            decoration: InputDecoration(
              counterText: '',
              contentPadding: const EdgeInsets.all(8.0),
              filled: false,
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kGrey3Color),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: kPrimaryColor,
                  width: 1.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: kFailedColor,
                  width: 1.5,
                ),
              ),
              border: OutlineInputBorder(),
              enabled: isEnabled ?? false,
              hintText: hintText,
              suffixIcon: suffixIcon != null
                  ? Padding(
                      padding: EdgeInsets.all(6.w),
                      child: suffixIcon,
                    )
                  : null,
            ),
            minLines: maxLine,
            maxLines: maxLine,
            onTap: onTap,
            onSaved: saved,
            validator: validator,
            autovalidateMode: autovalidateMode,
          ),
        ),
      ],
    );
  }
}

/// -------------------------------------------------------
/// TODO leave a note
/// -------------------------------------------------------
// class LabeledRadioDropdown<T> extends StatelessWidget {
//   const LabeledRadioDropdown({
//     Key? key,
//     required this.label,
//     required this.radioItemBuilder,
//     required this.onSelected,
//     this.value,
//     this.searchable = true,
//   }) : super(key: key);

//   final T? value;
//   final bool searchable;
//   final List<RadioDropdownMenuItem> Function(BuildContext context)
//       radioItemBuilder;
//   final ValueChanged<T> onSelected;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (label != "") ...[
//           Text(label, style: Theme.of(context).textTheme.caption),
//           SizedBox(height: 8.h),
//         ],
//         Row(
//           children: [
//             Expanded(
//               child: SizedBox(
//                 height: 40.h,
//                 child:
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

/// -------------------------------------------------------
/// TODO leave a note
/// -------------------------------------------------------
class LabeledHourSelectInput extends StatelessWidget {
  const LabeledHourSelectInput({
    Key? key,
    required this.label,
    required this.items,
    required this.onSelected,
    this.value,
  }) : super(key: key);

  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.caption),
        SizedBox(height: 8),
        GridTimePicker(
          value: this.value,
          items: this.items,
          onSelected: this.onSelected,
          child: SizedBox(
            height: 34,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: kGrey2Color),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (this.value != null)
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Text(this.value ?? ''),
                    )),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: AppIcons.svgAsset(AppIcons.clock),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
