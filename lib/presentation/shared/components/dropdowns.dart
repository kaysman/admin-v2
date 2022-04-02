import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/data/models/user.model.dart';
import 'package:lng_adminapp/shared.dart';

class RadioDropdown<T> extends StatefulWidget {
  const RadioDropdown({
    Key? key,
    this.value,
    this.child,
    this.label,
    this.searchable = true,
    required this.radioItemBuilder,
    required this.onSelected,
    this.height = 34.0,
    this.width = double.infinity,
  }) : super(key: key);

  final String? label;
  final T? value;
  final Widget? child;
  final bool searchable;
  final List<RadioDropdownMenuItem<T>> Function(BuildContext context)
      radioItemBuilder;
  final ValueChanged<T> onSelected;

  final double width;
  final double height;

  @override
  State<RadioDropdown<T>> createState() => _RadioDropdownState<T>();
}

class _RadioDropdownState<T> extends State<RadioDropdown<T>> {
  String _query = "";

  @override
  Widget build(BuildContext context) {
    List<RadioDropdownMenuItem> items = widget.radioItemBuilder.call(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) Text(widget.label!),
        if (widget.label != null) SizedBox(height: 12.0),
        Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            border: Border.all(color: kGrey2Color),
          ),
          child: PopupMenuButton<T>(
            color: kWhite,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.child != null) widget.child!,
                  if (widget.value == null) Text("-"),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
            itemBuilder: (context) {
              return <PopupMenuItem<T>>[
                PopupMenuItem<T>(
                  onTap: () {},
                  enabled: false,
                  padding: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.searchable)
                        TextFieldNoBorder(
                          onChanged: (v) {
                            setState(() {
                              _query = v;
                            });
                          },
                        ),
                      if (_query.isEmpty) ...items,
                      // if (_query.isNotEmpty) ...buildResult(_query),
                    ],
                  ),
                ),
              ];
            },
          ),
        ),
      ],
    );
  }

  buildResult(String query) {
    // return widget.items
    //     .where((el) => el.startsWith(query))
    //     .map((e) => RadioDropdownMenuItem(
    // ));
  }
}

class RadioDropdownMenuItem<T> extends StatelessWidget {
  const RadioDropdownMenuItem({
    Key? key,
    this.child,
    this.selected,
    this.value,
    this.onTap,
  }) : super(key: key);

  final T? value;
  final Widget? child;
  final bool? selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return child != null
        ? PopupMenuItem<T>(
            padding: EdgeInsets.zero,
            value: this.value,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Radio(
                    value: selected ?? false,
                    groupValue: true,
                    onChanged: (bool? v) {},
                  ),
                  SizedBox(width: 8),
                  if (child != null) child!,
                ],
              ),
            ),
          )
        : Text("-");
  }
}

class OpenRadioDropdown extends StatefulWidget {
  const OpenRadioDropdown({
    Key? key,
    this.value,
    this.items,
    this.onSelected,
  }) : super(key: key);

  final String? value;
  final List<dynamic>? items;
  final ValueChanged<dynamic>? onSelected;
  @override
  _OpenRadioDropdownState createState() => _OpenRadioDropdownState();
}

class _OpenRadioDropdownState extends State<OpenRadioDropdown> {
  String _query = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(width: .5.w, color: kGrey1Color),
      ),
      child: StatefulBuilder(builder: (context, _setState) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 12.w),
                  AppIcons.svgAsset(AppIcons.search),
                  SizedBox(
                    width: 257.w,
                    child: TextFormField(
                      scrollPadding: EdgeInsets.zero,
                      style: Theme.of(context).textTheme.bodyText1,
                      onChanged: (v) {
                        _setState(() {
                          _query = v;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Search...",
                        hintStyle: Theme.of(context).textTheme.subtitle2,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 8.h,
                          horizontal: 12.w,
                        ),
                        filled: false,
                        isDense: true,
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: kGrey1Color,
              thickness: .5.w,
              height: 0,
            ),
            SizedBox(
              height: 250.h,
              width: double.infinity,
              child: Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 8.w,
                      top: 8.w,
                      bottom: 8.w,
                      right: 5.w,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Drivers (${widget.items!.length})',
                          style: TextStyle(
                            color: kGrey1Color,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        if (_query.isEmpty) ...[
                          ...widget.items!.map((item) {
                            return buildItem(item);
                          })
                        ],
                        if (_query.isNotEmpty) ...[...buildResult(_query)]
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  buildItem(User user) {
    return Row(
      children: [
        Radio(
          value: user.driver?.id == widget.value,
          groupValue: true,
          onChanged: (v) {
            widget.onSelected!.call(user.driver?.id);
          },
        ),
        SizedBox(width: 8.w),
        Text(
          '${user.firstName ?? '-'} ${user.lastName ?? '-'}',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }

  buildResult(String query) {
    return widget.items!
        .where((el) =>
            el.firstName!.startsWith(query) || el.lastName!.startsWith(query))
        .map((e) => buildItem(e));
  }
}

class CheckBoxDropdown extends StatelessWidget {
  const CheckBoxDropdown({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 289.sp,
      child: PopupMenuButton(
        color: kWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: child,
        itemBuilder: (context) {
          return <PopupMenuItem>[
            // PopupMenuItem(
            //   enabled: false,
            //   onTap: () {},
            //   child: TextFieldNoBorder(),
            // ),
            ...List.generate(
              6,
              (index) => PopupMenuItem(
                onTap: () {},
                child: Row(
                  children: [
                    Checkbox(value: false, onChanged: (v) {}),
                    SizedBox(width: 8),
                    Text("Nextday delivery flow")
                  ],
                ),
              ),
            ),
          ];
        },
      ),
    );
  }
}
