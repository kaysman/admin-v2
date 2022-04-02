import 'package:flutter/material.dart';
import 'package:lng_adminapp/shared.dart';

class InfoWithLabel extends StatelessWidget {
  const InfoWithLabel({
    Key? key,
    required this.label,
    required this.editMode,
    this.controller,
    this.isEditable = true,
  }) : super(key: key);

  final String label;
  final bool editMode;
  final bool isEditable;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(height: 6),
        SizedBox(
          height: 34.0,
          child: controller != null
              ? TextFormField(
                  controller: controller,
                  style: Theme.of(context).textTheme.bodyText1,
                  readOnly: !isEditable || !editMode,
                  decoration: InputDecoration(
                    counterText: '',
                    contentPadding: const EdgeInsets.only(
                      left: 12,
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
                  // minLines: maxLine,
                  // maxLines: maxLine,
                  // onTap: onTap,
                  // onSaved: saved,
                  // validator: validator,
                  // autovalidateMode: autovalidateMode,
                )
              : Container(
                  padding: const EdgeInsets.only(
                    left: 12,
                    right: 8,
                    bottom: 12,
                  ),
                  child: Text("-"),
                ),
        ),
      ],
    );
  }
}
