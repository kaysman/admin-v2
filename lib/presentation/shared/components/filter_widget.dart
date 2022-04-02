import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lng_adminapp/shared.dart';

import '../../screens/orders/manage_order_map/options.dart';

class MapFilterWidget extends StatelessWidget {
  const MapFilterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
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
              AppIcons.svgAsset(AppIcons.filter),
              SizedBox(width: 8),
              Text("Filter", style: Theme.of(context).textTheme.bodyText1),
              Spacer(),
              Text.rich(TextSpan(
                text: "${DateFormat('dd/MM/yyyy').format(DateTime.now())}",
                style: Theme.of(context).textTheme.subtitle1,
                children: [
                  TextSpan(text: ", Unassigned"),
                ],
              )),
            ],
          ),
        ),
      ),
      color: kWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      itemBuilder: (context) {
        return <PopupMenuItem>[
          PopupMenuItem(
            enabled: false,
            padding: EdgeInsets.zero,
            child: SizedBox(
              width: optionsWidth + 16,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ExpandableCard(
                    title: "Date",
                    subtitle: "Past 2 days",
                    onExpansionChanged: (v) {},
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //     horizontal: 16.0,
                      //   ),
                      //   child: DateFilter(
                      //     onFilterBySelected: (v) {},
                      //     filterByItems: [
                      //       "Order created date",
                      //       "Requested delivery date",
                      //       "Order completion date",
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  Divider(indent: 0, endIndent: 0, height: 0.5),
                  // ExpandableCard(
                  //   title: "Status of order",
                  //   subtitle: _showStatusOfOrderSubtitle ? "5 selected" : null,
                  //   children: [],
                  //   onExpansionChanged: (v) {
                  //     setState(() {
                  //       _showStatusOfOrderSubtitle = v;
                  //     });
                  //   },
                  // ),
                  Divider(indent: 0, endIndent: 0, height: 0.5),
                  ExpandableCard(
                    title: "Tasks",
                    subtitle: "Assigned, Not assigned",
                    onExpansionChanged: (v) {},
                    children: [
                      RadioListTile(
                        value: true,
                        groupValue: false,
                        onChanged: (v) {},
                        title: Text(
                          'Assigned tasks',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      RadioListTile(
                        value: false,
                        groupValue: false,
                        onChanged: (v) {},
                        title: Text(
                          'Unassigned tasks',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.sp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button(
                        elevation: 0,
                        primary: kWhite,
                        textColor: kPrimaryColor,
                        hasBorder: false,
                        text: 'Clear all',
                        onPressed: () {},
                      ),
                      SizedBox(width: 16),
                      Button(
                        primary: kPrimaryColor,
                        textColor: kWhite,
                        hasBorder: false,
                        text: 'Apply filter',
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 12.sp),
                ],
              ),
            ),
          ),
        ];
      },
    );
  }
}
