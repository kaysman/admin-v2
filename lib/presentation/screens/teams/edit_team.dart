import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/shared.dart';
import 'add_driver_button.dart';
import 'add_subadmin_button.dart';
import 'hover_button.dart';

class EditTeamInfoPage extends StatefulWidget {
  static const String routeName = 'edit-team-info-page';

  @override
  _EditTeamInfoPageState createState() => _EditTeamInfoPageState();
}

class _EditTeamInfoPageState extends State<EditTeamInfoPage> {
  bool showBorder = false;

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            side: BorderSide.none,
            backgroundColor: kGreyBackground,
          ),
          icon: AppIcons.svgAsset(AppIcons.back_android, height: 24, width: 24),
          label: Text(
            "Back",
            style: Theme.of(context).textTheme.subtitle2,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        SizedBox(height: 32),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Edit Team Information",
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.start,
          ),
        ]),
      ],
    );
  }

  Widget _buildSubadminList(BuildContext context) {
    var list = [
      [
        'assets/john.png',
        'Robert Kimich',
        'West Singapore Team',
        'Quick Delivery Team'
      ],
      [
        'assets/john.png',
        'Min Kim',
        'West Singapore Team',
        'Quick Delivery Team'
      ],
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sub-admin (${list.length} Sub-admins)',
            style: Theme.of(context).textTheme.bodyText1),
        SizedBox(height: 8),
        ...List.generate(list.length, (index) {
          return Tooltip(
            margin: EdgeInsets.zero,
            child: HoverButton(list: list, index: index),
            message: "Assigned to: \n ${list[index][2]} \n ${list[index][3]}",
            verticalOffset: 0,
            textStyle: TextStyle(color: kBlack),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.all(Radius.circular(4)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 45,
                  color: const Color(0xff000000).withOpacity(0.1),
                ),
              ],
            ),
          );
        }),
        // OutlinedButton.icon(
        //   style: OutlinedButton.styleFrom(
        //     side: BorderSide.none,
        //   ),
        //   icon: AppIcons.svgAsset(
        //     AppIcons.add,
        //     height: 16.sp,
        //     width: 16.sp,
        //   ),
        //   label: Text(
        //     "Add Sub-admin",
        //     style: GoogleFonts.inter(
        //       color: kPrimaryColor,
        //       fontSize: 12.sp,
        //       fontWeight: FontWeight.w400,
        //     ),
        //   ),
        //   onPressed: () {},
        // ),
        AddSubAdminButton(list: list),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget _buildDriverList(BuildContext context) {
    var list = [
      [
        'assets/john.png',
        'Robert Kimich',
        'West Singapore Team',
        'Quick Delivery Team'
      ],
      [
        'assets/john.png',
        'Min Kim',
        'West Singapore Team',
        'Quick Delivery Team'
      ],
      [
        'assets/john.png',
        'Robert Kimich',
        'West Singapore Team',
        'Quick Delivery Team'
      ],
      [
        'assets/john.png',
        'Min Kim',
        'West Singapore Team',
        'Quick Delivery Team'
      ],
      [
        'assets/john.png',
        'Robert Kimich',
        'West Singapore Team',
        'Quick Delivery Team'
      ],
      [
        'assets/john.png',
        'Min Kim',
        'West Singapore Team',
        'Quick Delivery Team'
      ],
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Drivers (${list.length} Drivers)',
            style: Theme.of(context).textTheme.bodyText1),
        SizedBox(height: 8),
        ...List.generate(list.length, (index) {
          return Tooltip(
            child: HoverButton(list: list, index: index),
            message: "Assigned to: \n ${list[index][2]} \n ${list[index][3]}",
            verticalOffset: 24,
            textStyle: TextStyle(color: kBlack),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.all(Radius.circular(4)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 45,
                  color: const Color(0xff000000).withOpacity(0.1),
                ),
              ],
            ),
          );
        }),
        // OutlinedButton.icon(
        //   style: OutlinedButton.styleFrom(
        //     side: BorderSide.none,
        //   ),
        //   icon: AppIcons.svgAsset(
        //     AppIcons.add,
        //     height: 16.sp,
        //     width: 16.sp,
        //   ),
        //   label: Text(
        //     "Add Driver",
        //     style: GoogleFonts.inter(
        //       color: kPrimaryColor,
        //       fontSize: 12.sp,
        //       fontWeight: FontWeight.w400,
        //     ),
        //   ),
        //   onPressed: () {},
        // ),
        AddDriverButton(list: list)
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Expanded(
      child: ScrollConfiguration(
        behavior: NoThumbScrollBehavior(),
        child: SingleChildScrollView(
          child: Container(
            width: 0.38.sw,
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Team Name',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  width: 0.34.sw,
                  child: TextFormField(
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: const InputDecoration(hintText: 'Team Name'),
                    onSaved: (String? value) {},
                    validator: (String? value) {},
                  ),
                ),
                SizedBox(height: 32),
                Text('Description',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    )),
                SizedBox(
                  height: 8,
                ),
                Container(
                  width: 0.34.sw,
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    minLines: 4,
                    maxLines: 6,
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: const InputDecoration(
                        hintText: 'Description',
                        contentPadding:
                            EdgeInsets.only(bottom: 36.0, left: 10)),
                    onSaved: (String? value) {},
                    validator: (String? value) {},
                  ),
                ),
                SizedBox(height: 24),
                Text('Select Operational Flow',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    )),
                SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: kGreyBackground,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(10),
                    underline: Container(
                      decoration: BoxDecoration(color: kGreyBackground),
                    ),
                    hint: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Select Flow',
                        style: GoogleFonts.inter(
                            fontSize: 14.sp, color: kGrey1Color),
                      ),
                    ),
                    items: <String>[
                      'Next-Day Delivery Flow',
                      'Same-Day Delivery Flow',
                      'Outside City Delivery Flow',
                      'Sub-urban Delivery Flow',
                      "Inside City Delivery Flow"
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          children: [
                            Checkbox(
                              shape: CircleBorder(side: BorderSide(width: 2)),
                              value: false,
                              onChanged: (value) {},
                            ),
                            Text(value,
                                style: Theme.of(context).textTheme.bodyText1),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSubadminList(context),
                      SizedBox(height: 8),
                      _buildDriverList(context),
                    ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Save',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: kBlack,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: kWhite, side: BorderSide(color: kBlack)),
                    ),
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 45,
                  color: const Color(0xff000000).withOpacity(0.1),
                ),
              ],
              border: Border.all(color: kWhite),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: kWhite,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 32),
      child: Column(
        children: [
          _buildHeader(context),
          SizedBox(
            height: 24,
          ),
          _buildBody(context),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
