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
import 'package:lng_adminapp/presentation/shared/colors.dart';
import 'package:lng_adminapp/presentation/shared/components/button.dart';
import 'package:lng_adminapp/presentation/shared/components/layouts/view-content.layout.dart';
import 'package:lng_adminapp/presentation/shared/helpers.dart';

import '../../../../data/enums/status.enum.dart';
import '../../../../data/services/app.service.dart';

class DriverInformation extends StatefulWidget {
  static const String routeName = 'driver-details';
  const DriverInformation({Key? key}) : super(key: key);

  @override
  _DriverInformationState createState() => _DriverInformationState();
}

class _DriverInformationState extends State<DriverInformation> {
  User? driver;

  deleteFunction(String? id) {
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
    if (UserService.selectedDriver.value != null) {
      driver = UserService.selectedDriver.value;
    }
    return Scaffold(
      backgroundColor: kGreyBackground,
      body: ValueListenableBuilder(
        valueListenable: UserService.selectedDriver,
        builder: (BuildContext context, User? v, Widget? child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              Padding(
                padding: const EdgeInsets.all(32),
                child: FlatBackButton(),
              ),
              ViewContentLayout(
                color: kWhite,
                title: 'Driver Information',
                height: 700.h,
                content: [
                  PersonalDetails(
                    name: '${v?.firstName} ${v?.lastName}',
                    email: '${v?.emailAddress}',
                    phoneNumber: '${v?.phoneNumber}',
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  VehicleDetails(
                    color: v?.driver?.vehicleDetail?.color,
                    type: v?.driver?.vehicleType,
                    licensePlate: v?.driver?.vehicleDetail?.licensePlate,
                    model: v?.driver?.vehicleDetail?.model,
                    year: v?.driver?.vehicleDetail?.year,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
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
                            PermissionType.DELETE_DRIVER))
                          Button(
                            text: 'Delete',
                            borderColor: kFailedColor,
                            hasBorder: true,
                            textColor: kFailedColor,
                            onPressed: () => deleteFunction(v?.id),
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
              // Container(
              //   width: 0.35.sw,
              //   height: 687.sp,
              //   margin: const EdgeInsets.symmetric(
              //     horizontal: 32,
              //   ),
              //   padding: EdgeInsets.all(24),
              //   decoration: BoxDecoration(
              //       boxShadow: [
              //         BoxShadow(
              //           blurRadius: 45,
              //           color: const Color(0xff000000).withOpacity(0.1),
              //         ),
              //       ],
              //       border: Border.all(color: Colors.white),
              //       borderRadius: BorderRadius.all(Radius.circular(10)),
              //       color: Colors.white),
              //   child: SingleChildScrollView(
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           'Driver Information',
              //           style: Theme.of(context).textTheme.bodyText2,
              //         ),
              //         SizedBox(
              //           height: 24,
              //         ),
              //         SizedBox(
              //           height: 24.h,
              //         ),
              //         DeleteEditButtons(
              //           deleteFunction: () {
              //             deleteFunction(driver?.id);
              //           },
              //           editFunction: () {},
              //         ),
              //       ],
              //     ),
              //   ),
              // )
            ],
          );
        },
      ),
    );
  }

  navigateToCreateDriverPage(data) {
    Navigator.pushNamed(
      context,
      CreateDriver.routeName,
    );
  }
}
