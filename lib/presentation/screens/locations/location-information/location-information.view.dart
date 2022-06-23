import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/data/models/location/location.model.dart';
import 'package:lng_adminapp/data/services/app.service.dart';
import 'package:lng_adminapp/data/services/location.service.dart';
import 'package:lng_adminapp/presentation/screens/dialog/delete/delete-dialog.view.dart';
import 'package:lng_adminapp/presentation/screens/dialog/enums/dialog.enum.dart';
import 'package:lng_adminapp/presentation/screens/locations/create-location/create-location.view.dart';
import 'package:lng_adminapp/presentation/screens/locations/location-information/widgets/contact-details.widget.dart';
import 'package:lng_adminapp/presentation/screens/locations/location-information/widgets/location-details.widget.dart';
import 'package:lng_adminapp/presentation/shared/components/layouts/view-content.layout.dart';
import 'package:lng_adminapp/shared.dart';

class LocationInformation extends StatefulWidget {
  static const String routeName = 'location-details';
  const LocationInformation({Key? key}) : super(key: key);

  @override
  _LocationInformationState createState() => _LocationInformationState();
}

class _LocationInformationState extends State<LocationInformation> {
  Location? location;

  deleteFunction(String id) {
    showWhiteDialog(
      context,
      DeleteDialog(
        title: 'Delete Location',
        message: 'Are you ready to delete',
        type: DialogType.DELETE,
        module: ModuleType.LOCATION,
        id: id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (LocationService.selectedLocation.value != null) {
      location = LocationService.selectedLocation.value;
    }
    return Scaffold(
      backgroundColor: kGreyBackground,
      body: ValueListenableBuilder(
        valueListenable: LocationService.selectedLocation,
        builder: (BuildContext context, Location? v, Widget? child) {
          return LngPage(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                FlatBackButton(),
                SizedBox(height: 32.h),
                ViewContentLayout(
                  color: kWhite,
                  title: 'Location Information',
                  height: 700.h,
                  content: [
                    LocationDetails(
                      name: v?.name,
                      address: v?.address?.addressLineOne,
                      type: v?.type?.name,
                      city: v?.address?.city,
                      country: v?.address?.country,
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    ContactDetails(
                      name: null,
                      emailAddress: null,
                      phoneNumber: null,
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                  ],
                  footer:
                      AppService.hasPermission(PermissionType.UPDATE_ADDRESS) ||
                              AppService.hasPermission(
                                  PermissionType.DELETE_ADDRESS)
                          ? Row(
                              children: [
                                Spacer(),
                                Row(
                                  children: [
                                    if (AppService.hasPermission(
                                            PermissionType.DELETE_ADDRESS) &&
                                        v != null)
                                      Button(
                                        text: 'Delete',
                                        borderColor: kFailedColor,
                                        hasBorder: true,
                                        textColor: kFailedColor,
                                        onPressed: () => deleteFunction(v.id!),
                                      ),
                                    if (AppService.hasPermission(
                                        PermissionType.UPDATE_ADDRESS))
                                      SizedBox(width: 16.w),
                                    if (AppService.hasPermission(
                                        PermissionType.UPDATE_ADDRESS))
                                      Button(
                                        text: 'Edit',
                                        borderColor: kPrimaryColor,
                                        hasBorder: true,
                                        textColor: kPrimaryColor,
                                        onPressed: () =>
                                            navigateToCreateLocationPage(v),
                                      ),
                                  ],
                                )
                              ],
                            )
                          : null,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  navigateToCreateLocationPage(data) {
    Navigator.pushNamed(
      context,
      CreateLocation.routeName,
    );
  }
}
