import 'package:flutter/material.dart';
import 'package:lng_adminapp/shared.dart';

enum InfoType { text, date, dropdown }

class InfoWithLabel<T> extends StatelessWidget {
  final String label;
  final bool editMode;
  final bool isEditable;

  final InfoType? infoType;
  final bool? isLoading;

  // use this controller if infoType is text
  final TextEditingController? controller;

  // use this data if infoType is dropdown
  final T? value;
  final ValueChanged<T?>? onValueChanged;
  final List<DropdownMenuItem<T>>? items;

  final DateTime? dateValue;
  final ValueChanged<DateTime?>? onDateChanged;
  // use this datetime if infoType is date

  const InfoWithLabel({
    Key? key,
    this.isLoading = false,
    required this.label,
    required this.editMode,
    this.controller,
    this.isEditable = true,
    this.infoType = InfoType.text,
    this.value,
    this.items,
    this.onValueChanged,
    this.onDateChanged,
    this.dateValue,
  })  : assert(infoType != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (infoType == InfoType.dropdown) {
      assert(onValueChanged != null || items != null);
    } else if (infoType == InfoType.date) {
      assert(onDateChanged != null);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            if (isLoading == true) ...[
              SizedBox(
                width: 5,
              ),
              SizedBox(
                width: 15,
                height: 15,
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                  strokeWidth: 1,
                ),
              )
            ],
          ],
        ),
        if (isLoading == false) ...[
          SizedBox(height: 6),
          () {
            switch (infoType) {
              case InfoType.text:
                return textInput(context);
              case InfoType.dropdown:
                return dropdownInput(context);
              case InfoType.date:
                return dateInput(context);
              default:
                return placeholder();
            }
          }(),
        ],
      ],
    );
  }

  placeholder() {
    return Container(
      padding: const EdgeInsets.only(
        left: 0, //12,
        right: 8,
        bottom: 12,
      ),
      child: Text("-"),
    );
  }

  textInput(BuildContext context) {
    if (controller == null) return placeholder();
    return SizedBox(
        height: 34.0,
        child: TextFormField(
          controller: controller,
          style: Theme.of(context).textTheme.bodyText1,
          readOnly: !isEditable || !editMode,
          decoration: InputDecoration(
            counterText: '',
            contentPadding: EdgeInsets.only(
              left: this.editMode ? 12 : 0,
              right: 8,
              bottom: 12,
            ),
            focusedBorder: editMode
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                      width: 0.6,
                    ),
                  )
                : InputBorder.none,
            errorBorder: editMode
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kFailedColor,
                      width: 0.6,
                    ),
                  )
                : InputBorder.none,
            border: editMode
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kGrey1Color,
                      width: 0.6,
                    ),
                  )
                : InputBorder.none,
            enabledBorder: editMode
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kGrey1Color,
                      width: 0.6,
                    ),
                  )
                : InputBorder.none,
          ),
          // onChanged: (v) => onValueChanged,
          // onChanged: ,
          // minLines: maxLine,
          // maxLines: maxLine,
          // onTap: onTap,
          // onSaved: saved,
          // validator: validator,
          // autovalidateMode: autovalidateMode,
        ));
  }

  dropdownInput(BuildContext context) {
    if (onValueChanged == null || items == null) return placeholder();
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField<T>(
        isExpanded: true,
        isDense: true,
        value: this.value,
        onChanged: this.editMode ? this.onValueChanged : null,
        style: Theme.of(context).textTheme.bodyText1,
        items: this.items!,
        decoration: InputDecoration(
          suffixIcon: InkWell(
            onTap: () => this.onValueChanged!.call(null),
            child: Icon(Icons.clear, size: 18),
          ),
        ),
      ),
    );
  }

  dateInput(BuildContext context) {
    if (onDateChanged == null) return placeholder();
    return InkWell(
      onTap: isEditable && editMode
          ? () async =>
              this.onDateChanged!(await onTimeChanged(context, dateValue))
          : null,
      child: Container(
        width: double.infinity,
        height: 34,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: kGrey5Color,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (dateValue != null)
              Expanded(child: Text(DateHelper.yyyyMMdd(dateValue!))),
            AppIcons.svgAsset(AppIcons.calendar),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> onTimeChanged(
    BuildContext context,
    DateTime? value, {
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    var dateResult = await showDatePicker(
      context: context,
      initialDate: value ?? DateTime.now(),
      firstDate: DateTime(2020, 1, 1),
      lastDate:
          lastDate ?? DateTime(DateTime.now().year, DateTime.now().month + 1),
    );
    TimeOfDay? time;
    if (dateResult != null) {
      time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: value?.hour ?? TimeOfDay.now().hour,
          minute: value?.minute ?? TimeOfDay.now().minute,
        ),
      );
    }
    if (dateResult != null && time != null) {
      var result = DateTime(
        dateResult.year,
        dateResult.month,
        dateResult.day,
        time.hour,
        time.minute,
      );
      return result;
    } else {
      return null;
    }
  }
}
