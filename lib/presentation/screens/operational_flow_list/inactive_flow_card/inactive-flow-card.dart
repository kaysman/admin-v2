import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/shared.dart';

import 'view-flow-button.dart';

class InactiveFlowCard extends StatefulWidget {
  const InactiveFlowCard({Key? key}) : super(key: key);

  @override
  _InactiveFlowCardState createState() => _InactiveFlowCardState();
}

class _InactiveFlowCardState extends State<InactiveFlowCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 32),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.hardEdge,
      child: ExpansionTile(
        textColor: Colors.black,
        backgroundColor: kGrey4Color,
        collapsedBackgroundColor: kGrey4Color,
        expandedAlignment: Alignment.topLeft,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        initiallyExpanded: false,
        onExpansionChanged: (value) {
          setState(() {
            _isExpanded = value;
          });
        },
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Inactive Flow Name',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            _isExpanded
                ? Text('Created on hh:mm dd/MM/yyyy',
                    style: GoogleFonts.inter(
                        color: kGrey1Color,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400))
                : Row(
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: kGrey2Color,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                          onPressed: () {},
                          child: Text('Location',
                              style: Theme.of(context).textTheme.bodyText1)),
                      SizedBox(
                        width: 16,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: kGrey2Color,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                          onPressed: () {},
                          child: Text(
                            'Time',
                            style: Theme.of(context).textTheme.bodyText1,
                          ))
                    ],
                  )
          ],
        ),
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Description',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Filler Description',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Orders Handled',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '123 Orders',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Filters',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: kGrey2Color,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    onPressed: () {},
                    child: Text('Location',
                        style: Theme.of(context).textTheme.bodyText1)),
                SizedBox(
                  width: 16,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: kGrey2Color,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    onPressed: () {},
                    child: Text(
                      'Time',
                      style: Theme.of(context).textTheme.bodyText1,
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          ViewFlowButton(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Delete',
                      style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: kFailedColor,
                          fontWeight: FontWeight.w500)),
                  style: ElevatedButton.styleFrom(
                    primary: kGrey4Color,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: kFailedColor),
                        borderRadius: BorderRadius.circular(6)),
                    padding: EdgeInsets.symmetric(
                      vertical: 7,
                      horizontal: 12,
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Activate',
                      style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 24,
          )
        ],
      ),
    );
  }
}
