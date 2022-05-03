import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/shared.dart';

class EditOrganizationInfo extends StatefulWidget {
  static const String routeName = 'edit-organizational-info';

  @override
  _EditOrganizationInfoState createState() => _EditOrganizationInfoState();
}

class _EditOrganizationInfoState extends State<EditOrganizationInfo> {
  Widget _buildHeader(BuildContext context) {
    return Container(
      color: kWhite,
      padding: const EdgeInsets.only(
        left: Spacings.kSpaceLittleBig,
        top: 29,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              side: BorderSide.none,
              backgroundColor: kGreyBackground,
            ),
            icon:
                AppIcons.svgAsset(AppIcons.back_android, height: 24, width: 24),
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
              "Edit Organizational Information",
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.start,
            ),
          ]),
        ],
      ),
    );
  }

  Widget _editOrganisationInfo(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 24,
        ),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // <---
              children: [
                Text(
                  "Organizational Information",
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 64,
                      backgroundImage: AssetImage('assets/john.png'),
                    ),
                    Button(
                      text: "Edit",
                      elevation: 0.0,
                      textColor: Colors.black,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Company Name',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        )),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: 0.52.sw,
                      child: TextFormField(
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration:
                            const InputDecoration(hintText: 'Company Name'),
                        onSaved: (String? value) {},
                        validator: (String? value) {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Address Line 1',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          width: 0.22.sw,
                          child: TextFormField(
                            style: Theme.of(context).textTheme.bodyText1,
                            decoration: const InputDecoration(
                                hintText: 'Address Line 1'),
                            onSaved: (String? value) {},
                            validator: (String? value) {},
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Address Line 2 (Optional)',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            )),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: 0.22.sw,
                          child: TextFormField(
                            style: Theme.of(context).textTheme.bodyText1,
                            decoration: const InputDecoration(
                                hintText: 'Address Line 2'),
                            onSaved: (String? value) {},
                            validator: (String? value) {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Postal Code',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: 0.22.sw,
                          child: TextFormField(
                            style: Theme.of(context).textTheme.bodyText1,
                            decoration:
                                const InputDecoration(hintText: 'Postal Code'),
                            onSaved: (String? value) {},
                            validator: (String? value) {},
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('City',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            )),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: 0.22.sw,
                          child: TextFormField(
                            style: Theme.of(context).textTheme.bodyText1,
                            decoration: const InputDecoration(hintText: 'City'),
                            onSaved: (String? value) {},
                            validator: (String? value) {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'State (optional)',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: 0.22.sw,
                          child: TextFormField(
                            style: Theme.of(context).textTheme.bodyText1,
                            decoration:
                                const InputDecoration(hintText: 'Postal Code'),
                            onSaved: (String? value) {},
                            validator: (String? value) {},
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Country',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            )),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: 0.22.sw,
                          child: TextFormField(
                            style: Theme.of(context).textTheme.bodyText1,
                            decoration:
                                const InputDecoration(hintText: 'Country'),
                            onSaved: (String? value) {},
                            validator: (String? value) {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  height: 49,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Main Contact',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: 0.22.sw,
                          child: TextFormField(
                            style: Theme.of(context).textTheme.bodyText1,
                            decoration:
                                const InputDecoration(hintText: 'Full Name'),
                            onSaved: (String? value) {},
                            validator: (String? value) {},
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            )),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: 0.22.sw,
                          child: TextFormField(
                            style: Theme.of(context).textTheme.bodyText1,
                            decoration: const InputDecoration(
                                hintText: 'Email Address'),
                            onSaved: (String? value) {},
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter valid email address';
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Phone Number (Office)',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: 0.22.sw,
                          child: TextFormField(
                            decoration: const InputDecoration(hintText: '+65'),
                            onSaved: (String? value) {},
                            validator: (String? value) {},
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Phone Number (Personal)',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            )),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: 0.22.sw,
                          child: TextFormField(
                            style: Theme.of(context).textTheme.bodyText1,
                            decoration: const InputDecoration(hintText: '+65'),
                            onSaved: (String? value) {},
                            validator: (String? value) {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('VAT/GST ID',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        )),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: 0.52.sw,
                      child: TextFormField(
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration:
                            const InputDecoration(hintText: 'VAT/GST ID'),
                        onSaved: (String? value) {},
                        validator: (String? value) {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: Theme.of(context).textTheme.button,
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: kPrimaryColor,
                          side: BorderSide(color: kPrimaryColor)),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Done',
                        style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor,
                          onPrimary: Colors.white,
                          side: BorderSide(color: kPrimaryColor)),
                    ),
                  ],
                ),
              ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            Container(
                color: kWhite,
                padding: const EdgeInsets.only(
                  left: Spacings.kSpaceLittleBig,
                  top: 29, // TODO modify by figma
                ),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 0.48.sw,
                        child: _editOrganisationInfo(context),
                        // _buildInfo(
                        //   context,
                        //   "User Information",
                        //   "Add Information",
                        //   () {},
                        // ),
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
                    ])),
          ],
        ),
      ),
    );
  }
}
