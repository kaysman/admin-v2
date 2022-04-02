import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/shared.dart';

class CreateTeamPage extends StatefulWidget {
  static const String routeName = 'create-team-page';

  @override
  _CreateTeamPageState createState() => _CreateTeamPageState();
}

class _CreateTeamPageState extends State<CreateTeamPage> {
  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FlatBackButton(),
        SizedBox(height: 32),
        Text(
          "Create a new team",
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 24),
      ],
    );
  }

  Widget _buildSubadminList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sub-admin (0 Sub-admins)',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(height: 8),
        CheckBoxDropdown(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, color: kPrimaryColor),
              Text(
                "Add sub-admin",
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: kPrimaryColor,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDriverList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Drivers (0 Drivers)',
            style: Theme.of(context).textTheme.bodyText1),
        SizedBox(height: 8),
        CheckBoxDropdown(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, color: kPrimaryColor),
              Text(
                "Add driver",
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: kPrimaryColor,
                    ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
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
                TextFormField(
                  style: Theme.of(context).textTheme.bodyText1,
                  decoration: const InputDecoration(
                    hintText: 'Team Name',
                  ),
                  onSaved: (String? value) {},
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a team name.';
                    }
                  },
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
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: 4,
                  maxLines: 6,
                  style: Theme.of(context).textTheme.bodyText1,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                    contentPadding: EdgeInsets.only(
                      bottom: 36.0,
                      left: 10,
                    ),
                  ),
                  onSaved: (String? value) {},
                  validator: (String? value) {},
                ),
                SizedBox(height: 24),
                Text(
                  'Select Operational Flow',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8),
                // RadioDropdown(
                //   items: [],
                //   onSelected: (v) {},
                // ),
                SizedBox(
                  height: 24,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSubadminList(context),
                    SizedBox(height: 24.sp),
                    _buildDriverList(context),
                  ],
                ),
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
                        primary: kWhite,
                        side: BorderSide(color: kBlack),
                      ),
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
      padding: EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          _buildBody(context),
        ],
      ),
    );
  }
}
