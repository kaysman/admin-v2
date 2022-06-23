import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/data/models/address.model.dart';
import 'package:lng_adminapp/data/models/user.model.dart';
import 'package:lng_adminapp/data/models/user/update-tenant.model.dart';
import 'package:lng_adminapp/presentation/screens/screens.dart';
import 'package:lng_adminapp/presentation/screens/settings/settings.bloc.dart';
import 'package:lng_adminapp/shared.dart';

class EditOrganizationInfo extends StatefulWidget {
  static const String routeName = 'edit-organizational-info';

  const EditOrganizationInfo({
    Key? key,
    required this.userIdentity,
  }) : super(key: key);

  final User userIdentity;

  @override
  _EditOrganizationInfoState createState() => _EditOrganizationInfoState();
}

class _EditOrganizationInfoState extends State<EditOrganizationInfo> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late SettingsBloc settingsBloc;
  late User user;
  FilePickerResult? _selectedImage;

  final tenantName = TextEditingController();
  final contactName = TextEditingController();
  final contactEmail = TextEditingController();
  final phoneNumber = TextEditingController();
  final vat = TextEditingController();
  final addressLine1 = TextEditingController();
  final addressLine2 = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final _state = TextEditingController();
  final country = TextEditingController();
  String? addressType;
  final longitude = TextEditingController();
  final latitude = TextEditingController();
  String? specificTypeOfLocation;

  @override
  void initState() {
    user = widget.userIdentity;
    settingsBloc = BlocProvider.of<SettingsBloc>(context);

    tenantName.text = replaceStringWithDash(widget.userIdentity.tenant?.name);
    contactName.text =
        replaceStringWithDash(widget.userIdentity.tenant?.contactName);
    contactEmail.text =
        replaceStringWithDash(widget.userIdentity.tenant?.contactEmail);
    phoneNumber.text =
        replaceStringWithDash(widget.userIdentity.tenant?.phoneNumber);
    vat.text = replaceStringWithDash(widget.userIdentity.tenant?.vat);
    addressLine1.text = replaceStringWithDash(
        widget.userIdentity.tenant?.address?.addressLineOne);
    addressLine2.text = replaceStringWithDash(
        widget.userIdentity.tenant?.address?.addressLineTwo);
    postalCode.text =
        replaceStringWithDash(widget.userIdentity.tenant?.address?.postalCode);
    city.text =
        replaceStringWithDash(widget.userIdentity.tenant?.address?.city);
    _state.text =
        replaceStringWithDash(widget.userIdentity.tenant?.address?.state);
    country.text =
        replaceStringWithDash(widget.userIdentity.tenant?.address?.country);
    longitude.text =
        replaceStringWithDash(widget.userIdentity.tenant?.address?.longitude);
    latitude.text =
        replaceStringWithDash(widget.userIdentity.tenant?.address?.latitude);
    addressType = replaceStringWithDash(
        widget.userIdentity.tenant?.address?.addressType?.name);
    specificTypeOfLocation = replaceStringWithDash(
        widget.userIdentity.tenant?.address?.specificTypeOfLocation?.name);

    super.initState();
  }

  String? get oldAdressLineOne =>
      widget.userIdentity.tenant?.address?.addressLineOne;
  String? get oldAdressLineTwo =>
      widget.userIdentity.tenant?.address?.addressLineTwo;
  String? get oldAdressLineThree =>
      widget.userIdentity.tenant?.address?.addressLineThree;
  String? get oldCity => widget.userIdentity.tenant?.address?.city;
  String? get oldCountry => widget.userIdentity.tenant?.address?.country;
  String? get oldPostalCode => widget.userIdentity.tenant?.address?.postalCode;
  String? get oldState => widget.userIdentity.tenant?.address?.state;

  Future<void> pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result == null) return;
      setState(() => _selectedImage = result);
    } on PlatformException catch (e) {
      print('failed to pick image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // print("ad2" + "${widget.userIdentity.tenant?.address?.addressLineTwo}");
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(context),
              Container(
                color: kWhite,
                padding: const EdgeInsets.only(
                  left: Spacings.kSpaceLittleBig,
                  top: 29,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 0.48.sw,
                      child: _editOrganisationInfo(context),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
            // SizedBox(height: 24),
            // imageSelection(),
            SizedBox(height: 24),
            LabeledInput(label: "Company Name", controller: tenantName),
            SizedBox(height: 24),
            RowOfTwoChildren(
              child1: LabeledInput(
                  label: "Address line 1", controller: addressLine1),
              child2: LabeledInput(
                label: "Address line 2",
                controller: addressLine2,
              ),
            ),
            SizedBox(height: 24),
            RowOfTwoChildren(
              child1:
                  LabeledInput(label: "Postal code", controller: postalCode),
              child2: LabeledInput(
                label: "City",
                controller: city,
              ),
            ),
            SizedBox(height: 24),
            RowOfTwoChildren(
              child1: LabeledInput(label: "State", controller: _state),
              child2: LabeledInput(
                label: "Country",
                controller: country,
              ),
            ),
            Divider(height: 49),
            Text(
              'Main Contact',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 24),
            RowOfTwoChildren(
              child1: LabeledInput(
                label: "Contact name",
                controller: contactName,
              ),
              child2: LabeledInput(
                label: "Contact email",
                controller: contactEmail,
              ),
            ),
            SizedBox(height: 24),
            RowOfTwoChildren(
              child1: LabeledInput(
                label: "Phone number",
                controller: phoneNumber,
              ),
              child2: LabeledInput(
                label: "VAT",
                controller: vat,
              ),
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
                BlocConsumer<SettingsBloc, SettingsState>(
                    listener: (context, state) {
                  if (state.status == SettingsStatus.success) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, IndexScreen.routeName, (route) => false);
                  }
                }, builder: (context, state) {
                  return Button(
                    text: "Save",
                    textColor: kWhite,
                    primary: kPrimaryColor,
                    isLoading: state.status == SettingsStatus.loading,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var data = user.toJson();
                        var address = Address(
                          id: widget.userIdentity.tenant?.address?.id,
                          addressLineOne: checkIfChangedAndReturn(
                              oldAdressLineOne, addressLine1.text),
                          addressLineTwo: checkIfChangedAndReturn(
                              oldAdressLineTwo, addressLine2.text),
                          postalCode: checkIfChangedAndReturn(
                              oldPostalCode, postalCode.text),
                          city: checkIfChangedAndReturn(oldCity, city.text),
                          country:
                              checkIfChangedAndReturn(oldCountry, country.text),
                          state: checkIfChangedAndReturn(oldState, _state.text),
                          specificTypeOfLocation:
                              SpecificTypeOfLocation.TENANT_PROFILE_DEFAULT,
                        );
                        var tenant = UpdateTenantRequest(
                          id: user.tenant?.id,
                          name: checkIfChangedAndReturn(
                              widget.userIdentity.tenant?.name,
                              tenantName.text),
                          contactName: checkIfChangedAndReturn(
                              widget.userIdentity.tenant?.contactName,
                              contactName.text),
                          contactEmail: checkIfChangedAndReturn(
                              widget.userIdentity.tenant?.contactEmail,
                              contactEmail.text),
                          phoneNumber: checkIfChangedAndReturn(
                              widget.userIdentity.tenant?.phoneNumber,
                              phoneNumber.text),
                          vat: checkIfChangedAndReturn(
                              widget.userIdentity.tenant?.vat, vat.text),
                          address: checkIfChangedAndReturn(
                              widget.userIdentity.tenant?.address, address),
                        );
                        data['id'] = widget.userIdentity.id;
                        data['tenantDetails'] = tenant.toJson();
                        print(tenant.address?.addressLineOne);
                        await settingsBloc.updateUser(data);
                      }
                    },
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  imageSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 60.w,
          height: 60.w,
          clipBehavior: Clip.none,
          decoration: BoxDecoration(
            color: kGrey3Color,
            borderRadius: BorderRadius.circular(100.r),
          ),
          padding: EdgeInsets.all(2.w),
          child: _selectedImage != null
              ? ClipOval(
                  child: Image.memory(
                    _selectedImage!.files.first.bytes!,
                    fit: BoxFit.cover,
                  ),
                )
              : user.photoUrl != null
                  ? Image.network(
                      user.photoUrl!,
                      fit: BoxFit.cover,
                    )
                  : Icon(
                      Icons.person,
                      size: 30.w,
                      color: kPrimaryColor,
                    ),
        ),
        const SizedBox(width: 12),
        Spacings.SMALL_HORIZONTAL,
        InkWell(
          onTap: this.pickImage,
          child: Text(
            user.photoUrl == null ? 'Add photo' : 'Edit photo',
            style: TextStyle(
              color: kPrimaryColor,
            ),
          ),
        )
      ],
    );
  }
}
