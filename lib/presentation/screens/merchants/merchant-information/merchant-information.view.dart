import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/data/models/user.model.dart';
import 'package:lng_adminapp/data/services/user.service.dart';
import 'package:lng_adminapp/presentation/screens/dialog/delete/delete-dialog.view.dart';
import 'package:lng_adminapp/presentation/screens/dialog/enums/dialog.enum.dart';
import 'package:lng_adminapp/presentation/screens/merchants/create-merchant/create-merchant.view.dart';
import 'package:lng_adminapp/presentation/screens/merchants/merchant-information/widgets/address-details.view.dart';
import 'package:lng_adminapp/presentation/screens/merchants/merchant-information/widgets/personal-details.view.dart';
import 'package:lng_adminapp/presentation/screens/merchants/merchant-information/widgets/tracking-details.dart';
import 'package:lng_adminapp/presentation/shared/components/layouts/view-content.layout.dart';
import 'package:lng_adminapp/shared.dart';

import '../../../../data/enums/status.enum.dart';
import '../../../../data/services/app.service.dart';

class MerchantInformation extends StatefulWidget {
  static const String routeName = 'merchant-details';
  const MerchantInformation({Key? key}) : super(key: key);

  @override
  _MerchantInformationState createState() => _MerchantInformationState();
}

class _MerchantInformationState extends State<MerchantInformation> {
  User? merchant;

  deleteFunction(String id) {
    showWhiteDialog(
      context,
      DeleteDialog(
        title: 'Delete Merchant',
        message: 'Are you ready to delete',
        type: DialogType.DELETE,
        module: ModuleType.MERCHANT,
        id: id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (UserService.selectedMerchant.value != null) {
      merchant = UserService.selectedMerchant.value;
    }
    return Scaffold(
      backgroundColor: kGreyBackground,
      body: LngPage(
        child: ValueListenableBuilder(
          valueListenable: UserService.selectedMerchant,
          builder: (BuildContext context, User? v, Widget? child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlatBackButton(),
                SizedBox(height: 32),
                ViewContentLayout(
                  color: kWhite,
                  title: 'Merchant Information',
                  height: 0.82.sh,
                  content: [
                    PersonalDetails(
                      name: '${v?.firstName} ${v?.lastName}',
                      email: '${v?.emailAddress}',
                      phoneNumber: '${v?.phoneNumber}',
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    CompanyDetails(
                      address: v?.merchant?.address?.addressLineOne,
                      city: v?.merchant?.address?.city,
                      companyName: v?.merchant?.companyName,
                      country: v?.merchant?.address?.country,
                      phone: v?.merchant?.phoneNumber,
                      postalCode: v?.merchant?.address?.postalCode,
                      vat: v?.merchant?.vat,
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    TrackingDetails(
                      phone: v?.merchant?.trackingPhoneNumber,
                      email: v?.merchant?.trackingEmail,
                    ),
                  ],
                  footer: Row(
                    children: [
                      Spacer(),
                      Row(
                        children: [
                          if (AppService.hasPermission(
                                  PermissionType.DELETE_MERCHANT) &&
                              v != null)
                            Button(
                              text: 'Delete',
                              borderColor: kFailedColor,
                              hasBorder: true,
                              permissions: [PermissionType.DELETE_MERCHANT],
                              textColor: kFailedColor,
                              onPressed: () => deleteFunction(v.id!),
                            ),
                          if (AppService.hasPermission(
                              PermissionType.UPDATE_MERCHANT))
                            SizedBox(width: 16.w),
                          if (AppService.hasPermission(
                              PermissionType.UPDATE_MERCHANT))
                            Button(
                              text: 'Edit',
                              borderColor: kPrimaryColor,
                              permissions: [PermissionType.UPDATE_MERCHANT],
                              hasBorder: true,
                              textColor: kPrimaryColor,
                              onPressed: () => navigateToCreateMerchantPage(v),
                            ),
                        ],
                      ),
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

  navigateToCreateMerchantPage(data) {
    Navigator.pushNamed(
      context,
      CreateMerchant.routeName,
    );
  }
}
