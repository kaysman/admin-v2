import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/data/models/address.model.dart';
import 'package:lng_adminapp/data/models/location/location-request.model.dart';
import 'package:lng_adminapp/data/models/location/location.model.dart';
import 'package:lng_adminapp/data/services/location.service.dart';
import 'package:lng_adminapp/presentation/screens/locations/create-location/forms/add-contact-details.form.dart';
import 'package:lng_adminapp/presentation/screens/locations/create-location/forms/add-location-details.form.dart';
import 'package:lng_adminapp/presentation/screens/locations/location.bloc.dart';
import 'package:lng_adminapp/shared.dart';

class CreateLocation extends StatefulWidget {
  static const String routeName = 'add-location';
  const CreateLocation({Key? key}) : super(key: key);

  @override
  _CreateLocationState createState() => _CreateLocationState();
}

class _CreateLocationState extends State<CreateLocation>
    with SingleTickerProviderStateMixin {
  // Location details
  final _locationNameController = TextEditingController();
  final _locationTypeController = TextEditingController();
  final _sizeController = TextEditingController();
  final _address1Controller = TextEditingController();
  final _address2Controller = TextEditingController();
  final _postalController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();
  GlobalKey<FormState> _locationDetailsFormKey = GlobalKey<FormState>();

  // Contact details
  final _contactNameController = TextEditingController();
  final _contactEmailController = TextEditingController();
  final _contactPhoneController = TextEditingController();
  GlobalKey<FormState> _contactDetailsFormKey = GlobalKey<FormState>();

  int tabIndex = 0;
  late TabController _tabController;
  late LocationBloc locationBloc;
  Location? location;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    locationBloc = context.read<LocationBloc>();
    checkIfLocationIsUpdating();
    super.initState();
  }

  @override
  void dispose() {
    _locationNameController.dispose();
    _locationTypeController.dispose();
    _sizeController.dispose();
    _tabController.dispose();
    _contactNameController.dispose();
    _contactEmailController.dispose();
    _contactPhoneController.dispose();
    _address1Controller.dispose();
    _address2Controller.dispose();
    _postalController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  void checkIfLocationIsUpdating() {
    if (LocationService.selectedLocation.value != null) {
      location = LocationService.selectedLocation.value;

      _locationNameController.text = location?.name ?? '';
      _locationTypeController.text = location?.type ?? '';
      _sizeController.text = location?.size ?? '';
      _contactNameController.text = '';
      _contactEmailController.text = '';
      _contactPhoneController.text = '';
      _address1Controller.text = location?.address?.addressLineOne ?? '';
      _address2Controller.text = location?.address?.addressLineTwo ?? '';
      _postalController.text = location?.address?.postalCode ?? '';
      _cityController.text = location?.address?.city ?? '';
      _stateController.text = location?.address?.state ?? '';
      _countryController.text = location?.address?.country ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyBackground,
      body: Padding(
        padding: EdgeInsets.all(18.w),
        child: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlatBackButton(),
                SizedBox(height: 32.h),
                Container(
                  child: Text(
                    location == null ? 'Add a new location' : 'Update location',
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: kText1Color,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                AbsorbPointer(
                  absorbing: state.createLocationStatus ==
                      CreateLocationStatus.loading,
                  child: TabViewedContainer(
                    tabIndex: tabIndex,
                    controller: _tabController,
                    width: 520.w,
                    height: 700.h,
                    tabs: ['Location details', 'Contact details'],
                    views: [
                      AddLocationDetails(
                        locationDetailsFormKey: _locationDetailsFormKey,
                        nameController: _locationNameController,
                        typeController: _locationTypeController,
                        sizeController: _sizeController,
                        address1Controller: _address1Controller,
                        address2Controller: _address2Controller,
                        postalController: _postalController,
                        cityController: _cityController,
                        stateController: _stateController,
                        countryController: _countryController,
                      ),
                      AddContactDetails(
                        nameController: _contactNameController,
                        emailController: _contactEmailController,
                        phoneController: _contactPhoneController,
                        contactDetailsFormKey: _contactDetailsFormKey,
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
                                onPressed: () => gotoTab('-', location != null),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                            ],
                            Button(
                              text: tabIndex == 1
                                  ? location != null
                                      ? 'Update'
                                      : 'Save'
                                  : 'Next',
                              isLoading: state.createLocationStatus ==
                                  CreateLocationStatus.loading,
                              hasBorder: true,
                              textColor: kGrey1Color,
                              onPressed: () => gotoTab('+', location != null),
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
        if (tabIndex == 1) {
          submitForm(locationBloc, context, isUpdating);
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
      isValid = _locationDetailsFormKey.currentState!.validate();
    } else if (tabIndex == 1) {
      isValid = _contactDetailsFormKey.currentState!.validate();
    }
    return isValid;
  }

  submitForm(
      LocationBloc locationBloc, BuildContext context, bool isUpdating) async {
    Address _address = Address(
      addressLineOne: _address1Controller.text,
      addressLineTwo: _address2Controller.text,
      addressLineThree: '',
      postalCode: _postalController.text,
      city: _cityController.text,
      state: _stateController.text,
      country: _countryController.text,
    );

    LocationRequest _user = LocationRequest(
      name: _locationNameController.text,
      type: 'FIXED',
      size: _sizeController.text,
      address: _address,
      id: isUpdating ? location?.id : null,
    );

    await locationBloc.saveLocation(_user, context, isUpdating);
  }
}
