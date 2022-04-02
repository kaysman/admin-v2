import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/data/models/user.model.dart';
import 'package:lng_adminapp/data/services/app.service.dart';
import 'package:lng_adminapp/presentation/blocs/auth/auth.bloc.dart';
import 'package:lng_adminapp/shared.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import '../../blocs/auth/auth.state.dart';
import 'edit_org.dart';
import 'edit_user.dart';

class OrganizationalSettingsPage extends StatelessWidget {
  Widget _editInfo(
    BuildContext context,
    String label,
    String buttonText,
    Function() onButtonPressed,
    User? userIdentity,
  ) {
    return Container(
      width: 0.5.sw,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 24,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.start,
                ),
                Text(
                  "Last edited 12/02/2021",
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.end,
                )
              ],
            ),
            SizedBox(height: 24),
            CircleAvatar(
              radius: 38,
              backgroundImage: userIdentity?.photoUrl != null
                  ? NetworkImage(userIdentity!.photoUrl!)
                  : null,
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Name",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Text("${userIdentity?.firstName} ${userIdentity?.lastName}",
                    style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Email",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Text("${userIdentity?.emailAddress}",
                    style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Phone Number",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Text("${userIdentity?.phoneNumber}",
                    style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: onButtonPressed,
                child: Text(
                  buttonText,
                  style: Theme.of(context).textTheme.button,
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: kPrimaryColor,
                    side: BorderSide(color: kPrimaryColor)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _editUserInfo(BuildContext context, String label, String buttonText,
      Function()? onButtonPressed, User? userIdentity) {
    return Container(
      width: 0.5.sw,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    "Last edited ${userIdentity?.tenant?.updatedAt}",
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              CircleAvatar(radius: 38),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Company Name",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text("${userIdentity?.tenant?.name}",
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Address",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text("${userIdentity?.tenant?.address?.addressLineOne}",
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Postal Code",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text("${userIdentity?.tenant?.address?.postalCode}",
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "City",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text("${userIdentity?.tenant?.address?.city}",
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Country",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text("${userIdentity?.tenant?.address?.country}",
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
              Divider(height: 33),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Main Contact",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text("${userIdentity?.tenant?.contactName}",
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Email",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text("${userIdentity?.tenant?.contactEmail}",
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Phone Number (Office)",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text("${userIdentity?.tenant?.phoneNumber}",
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Phone Number (Personal)",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text("${userIdentity?.phoneNumber}",
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "VAT/GST ID",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text("${userIdentity?.tenant?.vat}",
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
              const SizedBox(height: 24),
              if (onButtonPressed != null)
                Center(
                  child: ElevatedButton(
                    onPressed: onButtonPressed,
                    child: Text(
                      buttonText,
                      style: Theme.of(context).textTheme.button,
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: kPrimaryColor,
                        side: BorderSide(color: kPrimaryColor)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        var userIdentity = state.identity;

        return Container(
          padding: const EdgeInsets.only(
            left: Spacings.kSpaceLittleBig,
            top: 29,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 0.38.sw,
                child: _editInfo(
                  context,
                  "${state.identity?.role?.name?.text} Information",
                  "Edit",
                  () => Navigator.pushNamed(context, EditUserInfo.routeName,
                      arguments: userIdentity),
                  userIdentity,
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
              const SizedBox(width: 32),
              Container(
                width: 0.38.sw,
                child: _editUserInfo(
                  context,
                  "Organizational Information",
                  "Edit",
                  AppService.hasPermission(PermissionType.UPDATE_TENANT)
                      ? () => Navigator.pushNamed(
                          context, EditOrganizationInfo.routeName)
                      : null,
                  userIdentity,
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 45,
                      color: const Color(0xff000000).withOpacity(0.1),
                    ),
                  ],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
