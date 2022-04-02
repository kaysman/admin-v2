import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/data/models/address.model.dart';
import 'package:lng_adminapp/data/models/driver-details.model.dart';
import 'package:lng_adminapp/data/models/user.model.dart';
import 'package:lng_adminapp/data/models/user/create-user-request.model.dart';
import 'package:lng_adminapp/data/models/vehicle-details.model.dart';
import 'package:lng_adminapp/data/services/user.service.dart';
import 'package:lng_adminapp/presentation/screens/drivers/create-driver/forms/add_bank_details.dart';
import 'package:lng_adminapp/presentation/screens/drivers/create-driver/forms/add_personal_details.dart';
import 'package:lng_adminapp/presentation/screens/drivers/create-driver/forms/add_vehicle_details.dart';
import 'package:lng_adminapp/presentation/screens/drivers/drivers.bloc.dart';
import 'package:lng_adminapp/shared.dart';

class CreateDriver extends StatefulWidget {
  static const String routeName = 'add-driver';
  const CreateDriver({Key? key}) : super(key: key);

  @override
  _CreateDriverState createState() => _CreateDriverState();
}

class _CreateDriverState extends State<CreateDriver>
    with SingleTickerProviderStateMixin {
  // Personal details
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  GlobalKey<FormState> _personalDetailsFormKey = GlobalKey<FormState>();
  FilePickerResult? _selectedImage;

  // Vehicle details
  final _modelController = TextEditingController();
  final _modelYearController = TextEditingController();
  final _licenseController = TextEditingController();
  final _colorController = TextEditingController();
  GlobalKey<FormState> _vehicleDetailsFormKey = GlobalKey<FormState>();
  String? _selectedVehicleType = 'WALKER';

  // Bank details
  final _address1Controller = TextEditingController();
  final _address2Controller = TextEditingController();
  final _postalController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();
  final _bankAccountController = TextEditingController();
  final _noteController = TextEditingController();
  GlobalKey<FormState> _bankDetailsFormKey = GlobalKey<FormState>();

  int tabIndex = 0;
  late TabController _tabController;
  late DriverBloc driverBloc;
  User? driver;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    driverBloc = context.read<DriverBloc>();
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
    _modelController.dispose();
    _modelYearController.dispose();
    _licenseController.dispose();
    _colorController.dispose();
    _address1Controller.dispose();
    _address2Controller.dispose();
    _postalController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _bankAccountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void checkIfUserIsUpdating() {
    if (UserService.selectedDriver.value != null) {
      driver = UserService.selectedDriver.value;

      _firstNameController.text = driver?.firstName ?? '';
      _lastNameController.text = driver?.lastName ?? '';
      _emailController.text = driver?.emailAddress ?? '';
      _phoneController.text = driver?.phoneNumber ?? '';
      _modelController.text = driver?.driver?.vehicleDetail?.model ?? '';
      _modelYearController.text = driver?.driver?.vehicleDetail?.year ?? '';
      _licenseController.text =
          driver?.driver?.vehicleDetail?.licensePlate ?? '';
      _colorController.text = driver?.driver?.vehicleDetail?.color ?? '';
      _selectedVehicleType = driver?.driver?.vehicleType ?? '';
      _address1Controller.text = driver?.driver?.address?.addressLineOne ?? '';
      _address2Controller.text = driver?.driver?.address?.addressLineTwo ?? '';
      _postalController.text = driver?.driver?.address?.postalCode ?? '';
      _cityController.text = driver?.driver?.address?.city ?? '';
      _stateController.text = driver?.driver?.address?.state ?? '';
      _countryController.text = driver?.driver?.address?.country ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyBackground,
      body: Padding(
        padding: EdgeInsets.all(18.w),
        child: BlocBuilder<DriverBloc, DriverState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlatBackButton(),
                SizedBox(height: 32.h),
                Container(
                  child: Text(
                    driver == null ? 'Add a New Driver' : 'Update Driver',
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: kText1Color,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                AbsorbPointer(
                  absorbing:
                      state.createDriverStatus == CreateDriverStatus.loading,
                  child: TabViewedContainer(
                    tabIndex: tabIndex,
                    controller: _tabController,
                    width: 520.w,
                    height: 600.h,
                    tabs: [
                      'Personal Details',
                      'Vehicle Details',
                      'Bank & Address Details',
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
                        isUpdating: driver != null,
                        pickImagePressed: () => pickImage(),
                      ),
                      AddVehicleDetails(
                        colorController: _colorController,
                        licenseController: _licenseController,
                        modelController: _modelController,
                        modelYearController: _modelYearController,
                        vehicleDetailsFormKey: _vehicleDetailsFormKey,
                        selectedVehicleType: _selectedVehicleType,
                      ),
                      AddBankDetails(
                        address1Controller: _address1Controller,
                        address2Controller: _address2Controller,
                        postalController: _postalController,
                        cityController: _cityController,
                        stateController: _stateController,
                        countryController: _countryController,
                        bankAccountController: _bankAccountController,
                        noteController: _noteController,
                        bankDetailsFormKey: _bankDetailsFormKey,
                      ),
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
                                onPressed: () => gotoTab('-', driver != null),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                            ],
                            Button(
                              text: tabIndex == 2
                                  ? driver != null
                                      ? 'Update'
                                      : 'Save'
                                  : 'Next',
                              isLoading: state.createDriverStatus ==
                                  CreateDriverStatus.loading,
                              hasBorder: true,
                              textColor: kGrey1Color,
                              onPressed: () => gotoTab('+', driver != null),
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
          submitForm(driverBloc, _selectedImage, context, isUpdating);
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
      isValid = _vehicleDetailsFormKey.currentState!.validate();
    } else if (tabIndex == 2) {
      isValid = _bankDetailsFormKey.currentState!.validate();
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

  submitForm(DriverBloc driverBloc, FilePickerResult? selectedImage,
      BuildContext context, bool isUpdating) async {
    Address _address = Address(
      addressLineOne: _address1Controller.text,
      addressLineTwo: _address2Controller.text,
      addressLineThree: '',
      postalCode: _postalController.text,
      city: _cityController.text,
      state: _stateController.text,
      country: _countryController.text,
    );

    VehicleDetail _vehicleDetail = VehicleDetail(
      color: _colorController.text,
      licensePlate: _licenseController.text,
      model: _modelController.text,
      year: _modelYearController.text,
    );

    DriverDetails _driverDetails = DriverDetails(
      address: _address,
      vehicleType: _selectedVehicleType ?? 'WALKER',
      vehicleDetail: _vehicleDetail,
    );

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
      roleId: '06e56cbb-c883-4da8-8cb3-06661d829ef6',
      driverDetails: _driverDetails,
      merchantDetails: null,
      id: isUpdating ? driver?.id : null,
    );

    await driverBloc.saveDriver(_user, context, isUpdating);
  }
}
