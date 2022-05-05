import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/data/models/address.model.dart';
import 'package:lng_adminapp/data/models/merchant-details.model.dart';
import 'package:lng_adminapp/data/models/user.model.dart';
import 'package:lng_adminapp/data/models/user/create-user-request.model.dart';
import 'package:lng_adminapp/data/services/user.service.dart';
import 'package:lng_adminapp/presentation/screens/drivers/create-driver/forms/add_personal_details.dart';
import 'package:lng_adminapp/presentation/screens/merchants/create-merchant/forms/company-details.dart';
import 'package:lng_adminapp/presentation/screens/merchants/create-merchant/forms/tracking-details.dart';
import 'package:lng_adminapp/presentation/screens/merchants/merchants.bloc.dart';
import 'package:lng_adminapp/shared.dart';

class CreateMerchant extends StatefulWidget {
  static const String routeName = 'add-merchant';
  const CreateMerchant({Key? key}) : super(key: key);

  @override
  _CreateMerchantState createState() => _CreateMerchantState();
}

class _CreateMerchantState extends State<CreateMerchant> with SingleTickerProviderStateMixin {
  // Personal details
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  GlobalKey<FormState> _personalDetailsFormKey = GlobalKey<FormState>();
  FilePickerResult? _selectedImage;

  // Company details
  final _companyNameController = TextEditingController();
  final _addressLineOneController = TextEditingController();
  final _addressLineTwoController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();
  final _vatController = TextEditingController();
  final _contactNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailAddressController = TextEditingController();
  GlobalKey<FormState> _companyDetailsFormKey = GlobalKey<FormState>();

  // Tracking details
  final _trackingPhoneNumberController = TextEditingController();
  final _trackingEmailAddressController = TextEditingController();
  GlobalKey<FormState> _trackingDetailsFormKey = GlobalKey<FormState>();

  int tabIndex = 0;
  late TabController _tabController;
  late MerchantBloc merchantBloc;
  User? merchant;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    merchantBloc = context.read<MerchantBloc>();
    checkIfUserIsUpdating();
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _tabController.dispose();

    _companyNameController.dispose();
    _addressLineOneController.dispose();
    _addressLineTwoController.dispose();
    _postalCodeController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _vatController.dispose();
    _contactNameController.dispose();
    _phoneNumberController.dispose();
    _emailAddressController.dispose();

    _trackingPhoneNumberController.dispose();
    _trackingEmailAddressController.dispose();
    super.dispose();
  }

  void checkIfUserIsUpdating() {
    if (UserService.selectedMerchant.value != null) {
      merchant = UserService.selectedMerchant.value;

      _firstNameController.text = merchant?.firstName ?? '';
      _lastNameController.text = merchant?.lastName ?? '';
      _emailController.text = merchant?.emailAddress ?? '';
      _phoneController.text = merchant?.phoneNumber ?? '';

      _companyNameController.text = merchant?.merchant?.companyName ?? '';
      _addressLineOneController.text = merchant?.merchant?.address?.addressLineOne ?? '';
      _addressLineTwoController.text = merchant?.merchant?.address?.addressLineTwo ?? '';
      _postalCodeController.text = merchant?.merchant?.address?.postalCode ?? '';
      _cityController.text = merchant?.merchant?.address?.city ?? '';
      _stateController.text = merchant?.merchant?.address?.state ?? '';
      _countryController.text = merchant?.merchant?.address?.country ?? '';
      _vatController.text = merchant?.merchant?.vat ?? '';
      _contactNameController.text = merchant?.merchant?.contactName ?? '';
      _emailAddressController.text = merchant?.merchant?.contactEmail ?? '';
      _phoneNumberController.text = merchant?.merchant?.phoneNumber ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyBackground,
      body: Padding(
        padding: EdgeInsets.all(18.w),
        child: BlocBuilder<MerchantBloc, MerchantState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlatBackButton(),
                SizedBox(height: 32),
                Container(
                  child: Text(
                    merchant == null ? 'Add a New Merchant' : 'Update Merchant',
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: kText1Color,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                AbsorbPointer(
                  absorbing: state.createMerchantStatus == CreateMerchantStatus.loading,
                  child: TabViewedContainer(
                    tabIndex: tabIndex,
                    controller: _tabController,
                    width: 520.w,
                    height: 600.h,
                    tabs: [
                      'Personal Details',
                      'Company Details',
                      'Tracking Details',
                    ],
                    views: [
                      AddPersonalDetails(
                        emailController: _emailController,
                        firstNameController: _firstNameController,
                        lastNameController: _lastNameController,
                        passwordController: _passwordController,
                        phoneController: _phoneController,
                        personalDetailsFormKey: _personalDetailsFormKey,
                        selectedImage: _selectedImage,
                        isUpdating: merchant != null,
                        pickImagePressed: () => pickImage(),
                      ),
                      AddCompanyDetails(
                        companyNameController: _companyNameController,
                        addressLineOneController: _addressLineOneController,
                        addressLineTwoController: _addressLineTwoController,
                        postalCodeController: _postalCodeController,
                        cityController: _cityController,
                        stateController: _stateController,
                        countryController: _countryController,
                        vatController: _vatController,
                        contactNameController: _contactNameController,
                        phoneNumberController: _phoneNumberController,
                        companyDetailsFormKey: _companyDetailsFormKey,
                        emailAddressController: _emailAddressController,
                      ),
                      AddTrackingDetails(
                        trackingEmailAddressController: _trackingEmailAddressController,
                        trackingPhoneNumberController: _trackingPhoneNumberController,
                        trackingDetailsFormKey: _trackingDetailsFormKey,
                      )
                    ],
                    footer: Row(
                      children: [
                        Spacer(),
                        Row(
                          children: [
                            if (tabIndex > 0) ...[
                              Button(
                                text: 'Prev',
                                hasBorder: true,
                                onPressed: () => gotoTab('-', merchant != null),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                            ],
                            Button(
                              text: tabIndex == 2
                                  ? merchant != null
                                      ? 'Update'
                                      : 'Save'
                                  : 'Next',
                              isLoading: state.createMerchantStatus == CreateMerchantStatus.loading,
                              hasBorder: true,
                              textColor: kGrey1Color,
                              onPressed: () => gotoTab('+', merchant != null),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void gotoTab(String? char, bool isUpdating) {
    if (char == '+') {
      if (isCurrentFormValid()) {
        if (tabIndex == 2) {
          submitForm(merchantBloc, _selectedImage, context, isUpdating);
        } else {
          setState(() {
            tabIndex += 1;
            _tabController.animateTo(tabIndex);
          });
        }
      }
    }

    if (char == '-') {
      setState(() {
        tabIndex -= 1;
        _tabController.animateTo(tabIndex);
      });
    }
  }

  bool isCurrentFormValid() {
    bool isValid = false;
    if (tabIndex == 0) {
      isValid = _personalDetailsFormKey.currentState!.validate();
    } else if (tabIndex == 1) {
      isValid = _companyDetailsFormKey.currentState!.validate();
    } else if (tabIndex == 2) {
      isValid = _trackingDetailsFormKey.currentState!.validate();
    }
    return isValid;
  }

  Future<void> pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result == null) return;
      setState(() => _selectedImage = result);
    } on PlatformException catch (e) {
      print('failed to pick image $e');
    }
  }

  submitForm(MerchantBloc merchantBloc, FilePickerResult? selectedImage, BuildContext context,
      bool isUpdating) async {
    Address _address = Address(
      addressLineOne: _addressLineOneController.text,
      addressLineTwo: _addressLineTwoController.text,
      addressLineThree: '',
      postalCode: _postalCodeController.text,
      city: _cityController.text,
      state: _stateController.text,
      country: _countryController.text,
      countryCode: '+65',
    );
    MerchantDetails _merchantDetails = MerchantDetails(
      address: _address,
      companyName: _companyNameController.text,
      contactEmail: _emailAddressController.text,
      contactName: _contactNameController.text,
      phoneNumber: _phoneNumberController.text,
      vat: _vatController.text,
    );
    // print('$_selectedVehicleType >>>> vehicle type');
    // MerchantDetails _merchantDetails = MerchantDetails(
    //   address: _address,
    //   // vehicleType: _selectedVehicleType ?? 'WALKER',
    //   // vehicleDetail: _vehicleDetail,
    // );
    // print(_merchantDetails.toJson());

    String base64String =
        '${base64.encode(_selectedImage!.files[0].bytes as List<int>)}-ext-${_selectedImage!.files[0].extension}';
    ;
    CreateUserRequest _user = CreateUserRequest(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      emailAddress: _emailController.text,
      password: _passwordController.text,
      phoneNumber: _phoneController.text,
      countryCode: '+65',
      photoUrl: base64String,
      roleId: '0066c81f-9900-4f27-971e-ad2d2c72cd4d',
      driverDetails: null,
      merchantDetails: _merchantDetails,
      id: isUpdating ? merchant?.id : null,
    );

    await merchantBloc.saveMerchant(_user, context, isUpdating);
  }
}
