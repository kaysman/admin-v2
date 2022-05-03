import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:lng_adminapp/presentation/shared/components/filter_widget.dart';
import 'package:lng_adminapp/shared.dart';
import 'sheets/assign1driver.sheet.dart';
import 'sheets/assignMultipleDriver.sheet.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final double optionsWidth = 0.23.sw;
final List<String> dateFilter = ["dd", "mm", "yy"];

class SelectableOptions extends StatefulWidget {
  const SelectableOptions({Key? key}) : super(key: key);

  @override
  State<SelectableOptions> createState() => _SelectableOptionsState();
}

class _SelectableOptionsState extends State<SelectableOptions> {
  bool isTaskView = true;
  bool _showStatusOfOrderSubtitle = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kWhite,
      width: optionsWidth,
      padding: EdgeInsets.symmetric(
        vertical: 32,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    if (!isTaskView)
                      setState(() {
                        isTaskView = true;
                      });
                  },
                  child: Text(
                    "Task View",
                    style: isTaskView
                        ? Theme.of(context).textTheme.headline4?.copyWith(
                              decoration: TextDecoration.underline,
                            )
                        : Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                const SizedBox(width: 16),
                InkWell(
                  onTap: () {
                    if (isTaskView)
                      setState(() {
                        isTaskView = false;
                      });
                  },
                  child: Text(
                    "Team View",
                    style: !isTaskView
                        ? Theme.of(context).textTheme.headline4?.copyWith(
                              decoration: TextDecoration.underline,
                            )
                        : Theme.of(context).textTheme.subtitle2,
                  ),
                ),
              ],
            ),
          ),
          if (isTaskView)
            Expanded(
              child: SingleChildScrollView(
                child: _taskView(context),
              ),
            ),
          if (!isTaskView)
            Expanded(
              child: SingleChildScrollView(
                child: _teamView(context),
              ),
            ),
        ],
      ),
    );
  }

  _teamView(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16),
        InkWell(
          onTap: () {},
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            elevation: 0,
            color: kGrey5Color,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  AppIcons.svgAsset(AppIcons.calendar),
                  SizedBox(width: 8),
                  Text("Date", style: Theme.of(context).textTheme.bodyText1),
                  Spacer(),
                  Text.rich(TextSpan(
                    text: "${DateFormat('dd/MM/yyyy').format(DateTime.now())}",
                    style: Theme.of(context).textTheme.caption,
                  )),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        Card(
          borderOnForeground: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: BorderSide(color: kGrey2Color, width: 1),
          ),
          elevation: 0,
          margin: EdgeInsets.only(left: 16, right: 16),
          clipBehavior: Clip.hardEdge,
          child: ExpansionTile(
            title: Text(
              "Fast delivery",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            subtitle: Text(
              "30 drivers",
              style: Theme.of(context).textTheme.caption,
            ),
            maintainState: true,
            children: shipments.map<Widget>((shipment) {
              return ExpansionTile(
                leading: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: shipment.type.getColor,
                  ),
                ),
                title: Text(
                  shipment.type.getName,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                subtitle: Text(
                  "${shipment.noTasks} tasks",
                  style: Theme.of(context).textTheme.caption,
                ),
                childrenPadding: const EdgeInsets.fromLTRB(10, 0, 16, 0),
                children: [
                  SizedBox(
                    height: 0.4.sh,
                    child: ListView(
                      children: [
                        SizedBox(height: 8),
                        buildSelectableTile(false, (v) {}, 'Select All',
                            context: context),
                        ...List.generate(
                          8,
                          (index) => buildSelectableTile(
                            false,
                            (v) {},
                            '75 Broadway ave, Queens, NYC, 11207',
                            subtitle: 'No recipient',
                            context: context,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
        Spacings.SMALL_VERTICAL,
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(left: 16, right: 16),
          child: Button(
            textColor: kWhite,
            hasBorder: false,
            primary: kPrimaryColor,
            text: "Assign driver",
            onPressed: () => _buildBottomSheetModal(context, true),
          ),
        ),
      ],
    );
  }

  _taskView(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16),
        MapFilterWidget(),
        SizedBox(height: 16),
        Card(
          borderOnForeground: false,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: BorderSide(color: kGrey2Color, width: 1)),
          elevation: 0,
          margin: EdgeInsets.only(left: 16, right: 16),
          clipBehavior: Clip.hardEdge,
          child: ExpansionTile(
            title: Text(
              "Pickup, dispatch point, and delivery",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            subtitle: Text(
              "120 tasks",
              style: Theme.of(context).textTheme.caption,
            ),
            maintainState: true,
            children: shipments.map<Widget>((shipment) {
              return ExpansionTile(
                leading: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: shipment.type.getColor,
                  ),
                ),
                title: Text(
                  shipment.type.getName,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                subtitle: Text(
                  "${shipment.noTasks} tasks",
                  style: Theme.of(context).textTheme.caption,
                ),
                childrenPadding: const EdgeInsets.fromLTRB(10, 0, 16, 0),
                children: [
                  SizedBox(
                    height: 0.4.sh,
                    child: ListView(
                      children: [
                        SizedBox(height: 8),
                        buildSelectableTile(false, (v) {}, 'Select All',
                            context: context),
                        ...List.generate(
                          8,
                          (index) => buildSelectableTile(
                            false,
                            (v) {},
                            '75 Broadway ave, Queens, NYC, 11207',
                            subtitle: 'No recipient',
                            context: context,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
        Spacings.SMALL_VERTICAL,
        Card(
          borderOnForeground: false,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: BorderSide(color: kGrey2Color, width: 1)),
          elevation: 0,
          margin: EdgeInsets.only(left: 16, right: 16),
          clipBehavior: Clip.hardEdge,
          child: ExpansionTile(
            title: Text(
              "Pickup and delivery",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            subtitle: Text(
              "120 tasks",
              style: Theme.of(context).textTheme.caption,
            ),
            children: [],
          ),
        ),
        Spacings.SMALL_VERTICAL,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button(
              textColor: kWhite,
              hasBorder: false,
              primary: kPrimaryColor,
              text: "Assign 1 driver",
              onPressed: () => _buildBottomSheetModal(context, false),
            ),
            SizedBox(width: 8.w),
            Button(
              textColor: kWhite,
              hasBorder: false,
              primary: kPrimaryColor,
              text: "Assign multiple driver",
              onPressed: () => _buildBottomSheetModal(context, true),
            ),
          ],
        )
      ],
    );
  }

  buildSelectableTile(
      bool isSelected, Function(bool? v) onChanged, String title,
      {String? subtitle, required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(children: [
        Checkbox(value: isSelected, onChanged: onChanged),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.caption,
              ),
              const SizedBox(height: 2),
              if (subtitle != null)
                Text(
                  subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(fontSize: 10),
                ),
            ],
          ),
        )
      ]),
    );
  }

  void _buildBottomSheetModal(
      BuildContext context, bool showMultipleDriverSheet) {
    showLngBottomSheet(
      context: context,
      barrierColor: Colors.white.withOpacity(0.1),
      constraints: BoxConstraints(minWidth: 0, maxHeight: double.infinity),
      builder: (context) => showMultipleDriverSheet
          ? AssignMultipleDrivers()
          : Assign1DriverSheet(),
    );
  }
}

class ExpandableCard extends StatelessWidget {
  const ExpandableCard({
    Key? key,
    required this.title,
    required this.onExpansionChanged,
    this.subtitle,
    this.children = const [],
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final List<Widget> children;
  final ValueChanged<bool> onExpansionChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      elevation: 0,
      clipBehavior: Clip.hardEdge,
      child: ExpansionTile(
        title: Text(
          this.title,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        subtitle: this.subtitle != null
            ? Text(
                this.subtitle!,
                style: Theme.of(context).textTheme.caption,
              )
            : null,
        children: this.children,
        onExpansionChanged: this.onExpansionChanged,
      ),
    );
  }
}

/// create these classes and types in more accurate way
/// when integrating with api.
enum ShipmentType { pickup, transit, delivery }

extension AddOn on ShipmentType {
  String get getName {
    switch (this) {
      case ShipmentType.pickup:
        return "Pickup";
      case ShipmentType.transit:
        return "Transit";
      case ShipmentType.delivery:
        return "Delivery";
    }
  }

  Color get getColor {
    switch (this) {
      case ShipmentType.pickup:
        return kAccentBlue;
      case ShipmentType.transit:
        return kAccentTeal;
      case ShipmentType.delivery:
        return kAccentPurple;
    }
  }
}

/// class naming is so bad
class ShipmentTypeClass {
  final ShipmentType type;
  final String noTasks;
  ShipmentTypeClass({
    required this.noTasks,
    required this.type,
  });
}

List<ShipmentTypeClass> shipments = [
  ShipmentTypeClass(type: ShipmentType.pickup, noTasks: "25"),
  ShipmentTypeClass(type: ShipmentType.transit, noTasks: "30"),
  ShipmentTypeClass(type: ShipmentType.delivery, noTasks: "18"),
];
