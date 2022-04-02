import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/presentation/screens/operational_flow_list/inactive_flow_card/view-flow-button.dart';
import 'package:lng_adminapp/presentation/shared/colors.dart';

import '../../../../data/models/workflow/workflow.model.dart';
import 'add-filter-button.dart';
import 'edit-flow-button.dart';
import 'filter-dropdown-button.dart';

class ActiveFlowCard extends StatefulWidget {
  const ActiveFlowCard({Key? key, required this.flowData}) : super(key: key);

  final WorkflowEntity flowData;

  @override
  _ActiveFlowCardState createState() => _ActiveFlowCardState();
}

class _ActiveFlowCardState extends State<ActiveFlowCard> {
  bool _isExpanded = false;
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    var workflow = widget.flowData;
    var address =
        "${workflow.tenant?.address?.city}, ${workflow.tenant?.address?.country}";
    var time = workflow.serviceLevel;
    var description = "${workflow.description}";

    return Card(
      elevation: 0,
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 32),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.hardEdge,
      child: ExpansionTile(
        textColor: Colors.black,
        backgroundColor: kSecondaryColor,
        collapsedBackgroundColor: kSecondaryColor,
        expandedAlignment: Alignment.topLeft,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        initiallyExpanded: false,
        onExpansionChanged: (value) {
          setState(() {
            _isExpanded = value;
            //Collapsing cancels editing
            if (!value) {
              _isEditing = value;
            }
          });
        },
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  workflow.name ?? '',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            _isEditing
                ? Text('Last edited on ${workflow.updatedAt}',
                    style: GoogleFonts.inter(
                        color: kGrey1Color,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400))
                : _isExpanded
                    ? Text('Created on ${workflow.createdAt}',
                        style: GoogleFonts.inter(
                            color: kGrey1Color,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400))
                    : (workflow.tenant?.address?.city == null ||
                            workflow.tenant?.address?.country == null)
                        ? SizedBox()
                        : Row(
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xffA2B5EC),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      )),
                                  onPressed: () {},
                                  child: Text(address,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1)),
                              SizedBox(
                                width: 16,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xffA2B5EC),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    )),
                                onPressed: () {},
                                child: Text(
                                  "$time",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              )
                            ],
                          ),
          ],
        ),
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Filler Description',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              description,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          const SizedBox(height: 16),
          ViewFlowButton(),
          const SizedBox(height: 24),

          // if (_isEditing)
          //   Container(
          //     margin: EdgeInsets.symmetric(horizontal: 16),
          //     child: Text(
          //       'Orders Handled',
          //       style: Theme.of(context).textTheme.bodyText2,
          //     ),
          //   ),
          // if (_isEditing)
          //   Container(
          //     margin: EdgeInsets.symmetric(horizontal: 16),
          //     child: Text(
          //       '123 Orders',
          //       style: Theme.of(context).textTheme.bodyText1,
          //     ),
          //   ),
          // if (_isEditing) SizedBox(height: 16),
          // Container(
          //   margin: EdgeInsets.symmetric(horizontal: 16),
          //   child: Text(
          //     'Filters',
          //     style: Theme.of(context).textTheme.bodyText2,
          //   ),
          // ),
          // const SizedBox(width: 8),
          // Container(
          //   margin: EdgeInsets.symmetric(horizontal: 16),
          //   child: Row(
          //     children: [
          //       ElevatedButton(
          //           style: ElevatedButton.styleFrom(
          //               primary: Color(0xffA2B5EC),
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(15),
          //               )),
          //           onPressed: () {},
          //           child: Text('Location',
          //               style: Theme.of(context).textTheme.bodyText1)),
          //       const SizedBox(width: 16),
          //       ElevatedButton(
          //         style: ElevatedButton.styleFrom(
          //             primary: Color(0xffA2B5EC),
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(15),
          //             )),
          //         onPressed: () {},
          //         child: Text(
          //           'Time',
          //           style: Theme.of(context).textTheme.bodyText1,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // if (_isEditing) AddFilterButton(),
          // SizedBox(height: 16),
          // _isEditing ? EditFlowButton() :
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     FlatButton(
          //       onPressed: () {},
          //       child: Text(
          //         'Save Changes',
          //         style: GoogleFonts.inter(
          //             color: kPrimaryColor,
          //             fontSize: 16.sp,
          //             fontWeight: FontWeight.w700),
          //       ),
          //     ),
          //     SizedBox(
          //       width: 16,
          //     ),
          //     FlatButton(
          //       onPressed: () {
          //         setState(() {
          //           _isEditing = false;
          //         });
          //       },
          //       child: Text(
          //         'Cancel',
          //         style: GoogleFonts.inter(
          //             color: kFailedColor,
          //             fontSize: 16.sp,
          //             fontWeight: FontWeight.w700),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
