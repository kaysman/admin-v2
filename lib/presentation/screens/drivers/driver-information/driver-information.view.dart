import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/data/models/user.model.dart';
import 'package:lng_adminapp/data/services/user.service.dart';
import 'package:lng_adminapp/presentation/screens/dialog/delete/delete-dialog.view.dart';
import 'package:lng_adminapp/presentation/screens/dialog/enums/dialog.enum.dart';
import 'package:lng_adminapp/presentation/screens/drivers/create-driver/create-driver.view.dart';
import 'package:lng_adminapp/presentation/screens/drivers/driver-information/widgets/address-details.view.dart';
import 'package:lng_adminapp/presentation/screens/drivers/driver-information/widgets/bank-details.view.dart';
import 'package:lng_adminapp/presentation/screens/drivers/driver-information/widgets/personal-details.view.dart';
import 'package:lng_adminapp/presentation/screens/drivers/driver-information/widgets/vehicle-details.view.dart';
import 'package:lng_adminapp/presentation/shared/components/layouts/view-content.layout.dart';
import 'package:lng_adminapp/shared.dart';

import '../../../../data/enums/status.enum.dart';
import '../../../../data/services/app.service.dart';

class DriverInformation extends StatefulWidget {
  static const String routeName = 'driver-details';
  const DriverInformation({Key? key}) : super(key: key);

  @override
  _DriverInformationState createState() => _DriverInformationState();
}

class _DriverInformationState extends State<DriverInformation> {
  deleteFunction(String id) {
    showWhiteDialog(
      context,
      DeleteDialog(
        title: 'Delete Driver',
        message: 'Are you ready to delete',
        type: DialogType.DELETE,
        module: ModuleType.DRIVER,
        id: id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyBackground,
      body: LngPage(
        child: ValueListenableBuilder(
          valueListenable: UserService.selectedDriver,
          builder: (BuildContext context, User? v, Widget? child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlatBackButton(),
                SizedBox(height: 32),
                ViewContentLayout(
                  color: kWhite,
                  title: 'Driver Information',
                  height: 0.84.sh,
                  content: [
                    PersonalDetails(
                      name: '${v?.firstName} ${v?.lastName}',
                      email: '${v?.emailAddress}',
                      phoneNumber: '${v?.phoneNumber}',
                      photoUrl: v?.photoUrl,
                    ),
                    SizedBox(height: 24.h),
                    VehicleDetails(
                      color: v?.driver?.vehicleDetail.color,
                      type: v?.driver?.vehicleType ?? VehicleType.WALKER,
                      licensePlate: v?.driver?.vehicleDetail.licensePlate,
                      model: v?.driver?.vehicleDetail.model,
                      year: v?.driver?.vehicleDetail.year,
                    ),
                    SizedBox(height: 24.h),
                    AddressDetails(
                      address: v?.driver?.address?.addressLineOne,
                      city: v?.driver?.address?.city,
                      country: v?.driver?.address?.country,
                      postalCode: v?.driver?.address?.postalCode,
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    BankDetails(),
                  ],
                  footer: Row(
                    children: [
                      Spacer(),
                      Row(
                        children: [
                          if (AppService.hasPermission(
                                  PermissionType.DELETE_DRIVER) &&
                              v != null)
                            Button(
                              text: 'Delete',
                              borderColor: kFailedColor,
                              hasBorder: true,
                              textColor: kFailedColor,
                              onPressed: () => deleteFunction(v.id!),
                            ),
                          SizedBox(width: 16.w),
                          if (AppService.hasPermission(
                              PermissionType.UPDATE_DRIVER))
                            Button(
                              text: 'Edit',
                              borderColor: kPrimaryColor,
                              hasBorder: true,
                              textColor: kPrimaryColor,
                              onPressed: () => navigateToCreateDriverPage(v),
                            ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  navigateToCreateDriverPage(User? data) {
    Navigator.pushNamed(
      context,
      CreateDriver.routeName,
    );
  }
}
