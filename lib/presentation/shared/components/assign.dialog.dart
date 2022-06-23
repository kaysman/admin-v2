import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/data/models/contact-detail.model.dart';
import 'package:lng_adminapp/data/models/location/location.model.dart';
import 'package:lng_adminapp/data/models/task/create-task.model.dart';
import 'package:lng_adminapp/data/models/user.model.dart';
import 'package:lng_adminapp/data/services/order.service.dart';
import 'package:lng_adminapp/presentation/screens/drivers/drivers.bloc.dart';
import 'package:lng_adminapp/presentation/screens/locations/location.bloc.dart';
import 'package:lng_adminapp/presentation/screens/screens.dart';
import 'package:lng_adminapp/shared.dart';

final firstDate = DateTime(2020, 1, 1);
final lastDate = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);

enum _TimeType {
  OPEN_PICKUP,
  CLOSE_PICKUP,
  OPEN_DROPOFF,
  CLOSE_DROPOFF,
}

class DriverAssigningDialog extends StatefulWidget {
  DriverAssigningDialog({
    Key? key,
    required this.selectedOrders,
    required this.isAssignDelivery,
  }) : super(key: key);

  final List<Map<String, dynamic>> selectedOrders;
  final bool isAssignDelivery; // or Assign Transfer

  @override
  State<DriverAssigningDialog> createState() => _DriverAssigningDialogState();
}

class _DriverAssigningDialogState extends State<DriverAssigningDialog> {
  final _pageViewController = PageController();

  // blocs
  late LocationBloc locationBloc;
  late DriverBloc driverBloc;

  // task type
  TaskRelatedWorkflowSteps? taskType;
  GlobalKey<FormState> _taskPageFormKey = GlobalKey<FormState>();

  // Pickup details
  GlobalKey<FormState> _pickupPageFormKey = GlobalKey<FormState>();
  DateTime? _pickupTime;
  DateTime? _pickupCloseTime;
  String? _pickupWarehouseId;
  bool isPickupCustomAddress = false;
  final pickupAddress1Controller = TextEditingController();
  final pickupAddress2Controller = TextEditingController();
  final pickupPostalController = TextEditingController();
  final pickupCityController = TextEditingController();
  final pickupCountryController = TextEditingController();

  // Drop-off details
  GlobalKey<FormState> _dropOffPageFormKey = GlobalKey<FormState>();
  DateTime? _dropoffTime;
  DateTime? _dropoffCloseTime;
  String? _dropoffLocationId;
  bool isdropoffCustomAddress = false;
  final dropoffAddress1Controller = TextEditingController();
  final dropoffAddress2Controller = TextEditingController();
  final dropoffPostalController = TextEditingController();
  final dropoffCityController = TextEditingController();
  final dropoffCountryController = TextEditingController();

  // Assign drivers
  GlobalKey<FormState> _assignDriverPageFormKey = GlobalKey<FormState>();
  final searchTextController = TextEditingController();
  String? _selectedDriverId;
  bool assignLoading = false;

  @override
  void initState() {
    locationBloc = BlocProvider.of<LocationBloc>(context);
    if (locationBloc.state.locations == null) {
      locationBloc.loadLocations();
    }
    driverBloc = BlocProvider.of<DriverBloc>(context);
    driverBloc.loadDrivers();

    if (widget.isAssignDelivery) {
      taskType = TaskRelatedWorkflowSteps.ON_VEHICLE_FOR_DELIVERY;
    }

    super.initState();
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, _setState) {
      return Container(
        width: 500,
        color: kWhite,
        child: ExpandablePageView(
          controller: _pageViewController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            if (!widget.isAssignDelivery)
              _TaskType(
                formKey: _taskPageFormKey,
                pageController: _pageViewController,
                onTaskTypeChanged: (v) {
                  _setState(() => taskType = v);
                },
                taskTypeValue: taskType,
              ),
            BlocBuilder<LocationBloc, LocationState>(builder: (context, state) {
              var showLoading =
                  state.listLocationStatus == ListLocationStatus.loading;

              return _PickupDetails(
                formKey: _pickupPageFormKey,
                loadingLocations: showLoading,
                locations: state.locations?.items ?? [],
                locationId: _pickupWarehouseId,
                onLocationValueChanged: (v) {
                  _setState(() => _pickupWarehouseId = v);
                },
                pageController: _pageViewController,
                pickupTime: _pickupTime,
                closeTime: _pickupCloseTime,
                isCustomAddress: isPickupCustomAddress,
                pickupAddress1Controller: pickupAddress1Controller,
                pickupAddress2Controller: pickupAddress2Controller,
                pickupCityController: pickupCityController,
                pickupCountryController: pickupCountryController,
                pickupPostalController: pickupPostalController,
                onPickupTimeChanged: () => onTimeChanged(
                  context,
                  _setState,
                  _pickupTime,
                  _TimeType.OPEN_PICKUP,
                ),
                onCloseTimeChanged: () => onTimeChanged(
                  context,
                  _setState,
                  _pickupCloseTime,
                  _TimeType.CLOSE_PICKUP,
                ),
                onCustomAddressChanged: (v) {
                  _setState(() => isPickupCustomAddress = v ?? false);
                },
              );
            }),
            if (taskType != TaskRelatedWorkflowSteps.ON_VEHICLE_FOR_DELIVERY)
              BlocBuilder<LocationBloc, LocationState>(
                  builder: (context, state) {
                var showLoading =
                    state.listLocationStatus == ListLocationStatus.loading;

                return _DropoffDetails(
                  formKey: _dropOffPageFormKey,
                  loadingLocations: showLoading,
                  locations: state.locations?.items ?? [],
                  locationId: _dropoffLocationId,
                  onLocationValueChanged: (v) {
                    _setState(() => _dropoffLocationId = v);
                  },
                  pageController: _pageViewController,
                  dropoffTime: _dropoffTime,
                  closeTime: _dropoffCloseTime,
                  isCustomAddress: isdropoffCustomAddress,
                  dropoffAddress1Controller: dropoffAddress1Controller,
                  dropoffAddress2Controller: dropoffAddress2Controller,
                  dropoffCityController: dropoffCityController,
                  dropoffCountryController: dropoffCountryController,
                  dropoffPostalController: dropoffPostalController,
                  onCloseTimeChanged: () => onTimeChanged(
                    context,
                    _setState,
                    _dropoffCloseTime,
                    _TimeType.CLOSE_DROPOFF,
                  ),
                  onDropoffTimeChanged: () => onTimeChanged(
                    context,
                    _setState,
                    _dropoffTime,
                    _TimeType.OPEN_DROPOFF,
                  ),
                  onCustomAddressChanged: (v) {
                    _setState(() => isdropoffCustomAddress = v ?? false);
                  },
                );
              }),
            BlocBuilder<DriverBloc, DriverState>(builder: (context, state) {
              return _AssignDriver(
                formKey: _assignDriverPageFormKey,
                pageController: _pageViewController,
                searchTextController: searchTextController,
                onAssignPressed: () => onAssignTapped(_setState),
                driverId: _selectedDriverId,
                onDriverValueChanged: (v) {
                  _setState(() => _selectedDriverId = v);
                },
                isDriversBeingFetched:
                    state.listDriverStatus == ListDriverStatus.loading,
                drivers: state.drivers?.items ?? [],
                isAssignLoading: assignLoading,
              );
            }),
          ],
        ),
      );
    });
  }

  onAssignTapped(Function(VoidCallback) stateChanger) async {
    if (_assignDriverPageFormKey.currentState!.validate() != true) return;

    stateChanger(() => assignLoading = true);

    AddressWithOtherContactDetails? senderCustomAddress = isPickupCustomAddress
        ? AddressWithOtherContactDetails(
            typeOfContactForAddress: TypeOfContactForAddress.SENDER,
            addressLineOne: pickupAddress1Controller.text,
            addressLineTwo: notNullOrEmpty(pickupAddress2Controller.text),
            postalCode: notNullOrEmpty(pickupPostalController.text),
            city: notNullOrEmpty(pickupCityController.text),
            country: notNullOrEmpty(pickupCountryController.text),
            specificTypeOfLocation: SpecificTypeOfLocation.SENDER_ADDRESS,
            otherContactDetail: ContactDetail(),
          )
        : null;

    AddressWithOtherContactDetails? receiverCustomAddress =
        isdropoffCustomAddress
            ? AddressWithOtherContactDetails(
                typeOfContactForAddress: TypeOfContactForAddress.RECEIVER,
                addressLineOne: dropoffAddress1Controller.text,
                addressLineTwo: notNullOrEmpty(dropoffAddress2Controller.text),
                postalCode: notNullOrEmpty(dropoffPostalController.text),
                city: notNullOrEmpty(dropoffCityController.text),
                country: notNullOrEmpty(dropoffCountryController.text),
                specificTypeOfLocation: SpecificTypeOfLocation.RECEIVER_ADDRESS,
                otherContactDetail: ContactDetail(),
              )
            : null;

    CreateTaskEntity taskEntity = () {
      if (widget.isAssignDelivery)
        taskType = TaskRelatedWorkflowSteps.ON_VEHICLE_FOR_DELIVERY;
      switch (taskType) {
        case TaskRelatedWorkflowSteps.ON_VEHICLE_FOR_DELIVERY:
          return CreateTaskEntity(
            relationToWhichSpecificTaskRelatedStatus: taskType!,
            startTimeForPickUp: "$_pickupTime",
            endTimeForPickUp: "$_pickupCloseTime",
            genericTypeOfAddressForPickUp:
                GenericTypeOfLocation.TENANT_WAREHOUSE,
            addressIdIfExistingForPickUp: _pickupWarehouseId,
            addressAndContactIfNewForPickUp: senderCustomAddress,
            orderIds: widget.selectedOrders.map((e) => e['id'] as String).toList(),
            driverId: _selectedDriverId!,
          );

        case TaskRelatedWorkflowSteps
            .ON_VEHICLE_TO_DISPATCH_POINT_FOR_DELIVERY_DISPATCH:
        case TaskRelatedWorkflowSteps.ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING:
        default:
          return CreateTaskEntity(
            relationToWhichSpecificTaskRelatedStatus: taskType!,
            startTimeForPickUp: "$_pickupTime",
            endTimeForPickUp: "$_pickupCloseTime",
            addressIdIfExistingForPickUp: _pickupWarehouseId,
            genericTypeOfAddressForPickUp:
                GenericTypeOfLocation.TENANT_WAREHOUSE,
            addressAndContactIfNewForPickUp: senderCustomAddress,
            startTimeForDropOff: "$_dropoffTime",
            endTimeForDropOff: "$_dropoffCloseTime",
            genericTypeOfAddressForDropOff:
                GenericTypeOfLocation.RECEIVER_ADDRESS,
            addressIdIfExistingForDropOff: _dropoffLocationId,
            addressAndContactIfNewForDropOff: receiverCustomAddress,
            orderIds:
                widget.selectedOrders.map((e) => e['id'] as String).toList(),
            driverId: _selectedDriverId!,
          );
      }
    }();

    try {
      var res = await OrderService.assignDriver(taskEntity);
      if (res) {
        showSnackBar(context, Text("Task created and assigned successfully."));
        Navigator.pushNamedAndRemoveUntil(
            context, IndexScreen.routeName, (route) => false);
      }
    } catch (_) {
    } finally {
      stateChanger(() => assignLoading = false);
    }
  }

  void onTimeChanged(
    BuildContext context,
    void Function(void Function()) setState,
    DateTime? value,
    _TimeType type,
  ) async {
    var res = await showDatePicker(
      context: context,
      initialDate: value ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
    );
    TimeOfDay? time;
    if (res != null) {
      time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: value?.hour ?? TimeOfDay.now().hour,
          minute: value?.minute ?? TimeOfDay.now().minute,
        ),
      );
    }
    if (res != null && time != null) {
      var result = DateTime(
        value?.year ?? DateTime.now().year,
        value?.month ?? DateTime.now().month,
        value?.day ?? DateTime.now().day,
        time.hour,
        time.minute,
      );
      setState(() {
        switch (type) {
          case _TimeType.OPEN_PICKUP:
            _pickupTime = result;
            break;
          case _TimeType.CLOSE_PICKUP:
            _pickupCloseTime = result;
            break;
          case _TimeType.OPEN_DROPOFF:
            _dropoffTime = result;
            break;
          case _TimeType.CLOSE_DROPOFF:
            _dropoffCloseTime = result;
        }
      });
    }
  }

  String? notNullOrEmpty(String? value) {
    return (value != null && value.isNotEmpty) ? value : null;
  }
}

class _TaskType extends StatelessWidget {
  const _TaskType({
    Key? key,
    required this.formKey,
    required this.pageController,
    required this.onTaskTypeChanged,
    this.taskTypeValue,
  }) : super(key: key);

  final PageController pageController;
  final GlobalKey<FormState> formKey;
  final TaskRelatedWorkflowSteps? taskTypeValue;
  final ValueChanged<TaskRelatedWorkflowSteps?> onTaskTypeChanged;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 32,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.close, color: kBlack),
                ),
                Text(
                  "Pickup details",
                  style: Theme.of(context).textTheme.headline2,
                ),
                Text(
                  "1/4",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: kText2Color),
                ),
              ],
            ),
            SizedBox(height: 16.sp),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Task type",
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            SizedBox(height: 8),
            DropdownButtonHideUnderline(
              child: DropdownButtonFormField<TaskRelatedWorkflowSteps>(
                isExpanded: true,
                validator: (v) => v == null ? "This field is required" : null,
                decoration: InputDecoration(hintText: "Select task type"),
                items: TaskRelatedWorkflowSteps.values
                    .map((e) => DropdownMenuItem<TaskRelatedWorkflowSteps>(
                          value: e,
                          child: Text(
                            e.name,
                            style: Theme.of(context).textTheme.bodyText1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                onChanged: onTaskTypeChanged,
                value: taskTypeValue,
              ),
            ),
            SizedBox(height: 24.sp),
            Button(
              primary: kPrimaryColor,
              textColor: kWhite,
              text: "Next",
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  pageController.nextPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.decelerate);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _PickupDetails extends StatelessWidget {
  const _PickupDetails({
    Key? key,
    required this.formKey,
    required this.pageController,
    required this.pickupAddress1Controller,
    required this.pickupAddress2Controller,
    required this.pickupPostalController,
    required this.pickupCityController,
    required this.pickupCountryController,
    required this.isCustomAddress,
    required this.onCloseTimeChanged,
    required this.onCustomAddressChanged,
    required this.onPickupTimeChanged,
    required this.loadingLocations,
    this.closeTime,
    this.pickupTime,
    this.locations = const [],
    this.locationId,
    required this.onLocationValueChanged,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  final PageController pageController;

  final bool loadingLocations;
  final String? locationId;
  final ValueChanged<String?> onLocationValueChanged;
  final List<Location> locations;

  final DateTime? pickupTime;
  final VoidCallback onPickupTimeChanged;

  final DateTime? closeTime;
  final VoidCallback onCloseTimeChanged;

  final bool isCustomAddress;
  final ValueChanged<bool?> onCustomAddressChanged;

  final TextEditingController pickupAddress1Controller;
  final TextEditingController pickupAddress2Controller;
  final TextEditingController pickupPostalController;
  final TextEditingController pickupCityController;
  final TextEditingController pickupCountryController;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, _setState) {
      return Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 32,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.close, color: kBlack),
                  ),
                  Text(
                    "Pickup details",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    "2/4",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(color: kText2Color),
                  ),
                ],
              ),
              SizedBox(height: 16),
              RowOfTwoChildren(
                child1: buildTimeSelecterWidget(
                  context,
                  "Pick up earliest time",
                  pickupTime,
                  onPickupTimeChanged,
                ),
                child2: buildTimeSelecterWidget(
                  context,
                  "Pick up latest time",
                  closeTime,
                  onCloseTimeChanged,
                ),
              ),
              SizedBox(height: 16),
              if (!isCustomAddress) ...[
                if (loadingLocations)
                  Text("Fetching warehouses, please wait..."),
                if (!loadingLocations) ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Warehouse",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  SizedBox(height: 8),
                  DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(hintText: "Select address"),
                      value: locationId,
                      validator: (v) =>
                          v == null ? "This field is required" : null,
                      onChanged: onLocationValueChanged,
                      isExpanded: true,
                      isDense: false,
                      items: locations
                          .map((e) => DropdownMenuItem<String>(
                                value: e.address?.id ?? e.id,
                                child: Text(
                                  e.name ?? e.address?.fullAddress ?? "",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ],
              if (isCustomAddress) ...[
                LabeledInput(
                  label: "Address line 1",
                  hintText: "Address line 1",
                  controller: pickupAddress1Controller,
                ),
                LabeledInput(
                  label: "Address line 2 (optional)",
                  hintText: "Address line 2",
                  controller: pickupAddress2Controller,
                ),
                LabeledInput(
                  label: "Postal code",
                  hintText: "Postal code",
                  controller: pickupPostalController,
                ),
                LabeledInput(
                  label: "City",
                  hintText: "City",
                  controller: pickupCityController,
                ),
                LabeledInput(
                  label: "Country",
                  hintText: "Country",
                  controller: pickupCountryController,
                ),
              ],
              Row(
                children: [
                  Checkbox(
                    value: isCustomAddress,
                    onChanged: onCustomAddressChanged,
                  ),
                  SizedBox(width: 6),
                  Text(
                    "Custom address",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Button(
                    primary: kPrimaryColor,
                    textColor: kWhite,
                    text: "Back",
                    onPressed: () {
                      pageController.previousPage(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.decelerate,
                      );
                    },
                  ),
                  SizedBox(width: 16),
                  Button(
                    primary: kPrimaryColor,
                    textColor: kWhite,
                    text: "Next",
                    onPressed: () {
                      if (formKey.currentState!.validate() &&
                          pickupTime != null &&
                          closeTime != null) {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.decelerate,
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _DropoffDetails extends StatelessWidget {
  const _DropoffDetails({
    Key? key,
    required this.pageController,
    required this.dropoffAddress1Controller,
    required this.dropoffAddress2Controller,
    required this.dropoffPostalController,
    required this.dropoffCityController,
    required this.dropoffCountryController,
    required this.isCustomAddress,
    required this.onCloseTimeChanged,
    required this.onCustomAddressChanged,
    required this.onDropoffTimeChanged,
    required this.loadingLocations,
    this.closeTime,
    this.dropoffTime,
    this.locations = const [],
    this.locationId,
    required this.onLocationValueChanged,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  final PageController pageController;
  final bool loadingLocations;
  final String? locationId;
  final ValueChanged<String?> onLocationValueChanged;
  final List<Location> locations;

  final DateTime? dropoffTime;
  final VoidCallback onDropoffTimeChanged;

  final DateTime? closeTime;
  final VoidCallback onCloseTimeChanged;

  final bool isCustomAddress;
  final ValueChanged<bool?> onCustomAddressChanged;

  final TextEditingController dropoffAddress1Controller;
  final TextEditingController dropoffAddress2Controller;
  final TextEditingController dropoffPostalController;
  final TextEditingController dropoffCityController;
  final TextEditingController dropoffCountryController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 32,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(Icons.close, color: kBlack),
                ),
                Text(
                  "Drop-off details",
                  style: Theme.of(context).textTheme.headline2,
                ),
                Text(
                  "3/4",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: kText2Color),
                ),
              ],
            ),
            SizedBox(height: 16),
            RowOfTwoChildren(
              child1: buildTimeSelecterWidget(
                context,
                "Drop off earliest time",
                dropoffTime,
                onDropoffTimeChanged,
              ),
              child2: buildTimeSelecterWidget(
                context,
                "Drop off latest time",
                closeTime,
                onCloseTimeChanged,
              ),
            ),
            SizedBox(height: 16),
            if (!isCustomAddress) ...[
              if (loadingLocations) Text("Fetching locations, please wait..."),
              if (!loadingLocations) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Location",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                SizedBox(height: 8),
                DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                  value: locationId,
                  onChanged: onLocationValueChanged,
                  isExpanded: true,
                  decoration: InputDecoration(hintText: "Select location"),
                  validator: (v) => v == null ? "This field is required" : null,
                  items: locations
                      .map((e) => DropdownMenuItem<String>(
                            value: e.address?.id ?? e.id,
                            child: Text(
                              e.name ?? e.address?.fullAddress ?? "",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ))
                      .toList(),
                )),
                SizedBox(height: 8),
              ],
            ],
            if (isCustomAddress) ...[
              LabeledInput(
                label: "Address line 1",
                hintText: "Address line 1",
                controller: dropoffAddress1Controller,
              ),
              LabeledInput(
                label: "Address line 2 (optional)",
                hintText: "Address line 2",
                controller: dropoffAddress2Controller,
              ),
              LabeledInput(
                label: "Postal code",
                hintText: "Postal code",
                controller: dropoffPostalController,
              ),
              LabeledInput(
                label: "City",
                hintText: "City",
                controller: dropoffCityController,
              ),
              LabeledInput(
                label: "Country",
                hintText: "Country",
                controller: dropoffCountryController,
              ),
            ],
            Row(
              children: [
                Checkbox(
                  value: isCustomAddress,
                  onChanged: onCustomAddressChanged,
                ),
                SizedBox(width: 6),
                Text(
                  "Custom address",
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button(
                  primary: kPrimaryColor,
                  textColor: kWhite,
                  text: "Back",
                  onPressed: () {
                    pageController.previousPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.decelerate,
                    );
                  },
                ),
                SizedBox(width: 16.sp),
                Button(
                  primary: kPrimaryColor,
                  textColor: kWhite,
                  text: "Next",
                  onPressed: () {
                    if (formKey.currentState!.validate() &&
                        dropoffTime != null &&
                        closeTime != null) {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.decelerate,
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AssignDriver extends StatelessWidget {
  const _AssignDriver({
    Key? key,
    required this.formKey,
    required this.pageController,
    required this.searchTextController,
    required this.onAssignPressed,
    this.driverId,
    this.drivers = const [],
    required this.onDriverValueChanged,
    required this.isDriversBeingFetched,
    required this.isAssignLoading,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  final bool isAssignLoading;

  final PageController pageController;
  final TextEditingController searchTextController;
  final VoidCallback onAssignPressed;

  final bool isDriversBeingFetched;
  final String? driverId;
  final ValueChanged<String?> onDriverValueChanged;
  final List<User> drivers;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 32,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.close, color: kBlack),
                ),
                Text(
                  "Assign driver",
                  style: Theme.of(context).textTheme.headline2,
                ),
                Text(
                  "4/4",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: kText2Color),
                ),
              ],
            ),
            SizedBox(height: 16.sp),
            if (isDriversBeingFetched)
              const Center(child: CircularProgressIndicator()),
            if (!isDriversBeingFetched) ...[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Driver",
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              SizedBox(height: 8),
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  value: driverId,
                  onChanged: onDriverValueChanged,
                  decoration: InputDecoration(hintText: "Select driver"),
                  validator: (v) => v == null ? "This field is required" : null,
                  isExpanded: true,
                  items: drivers
                      .map((e) => DropdownMenuItem<String>(
                            value: e.driver?.id ?? e.id,
                            child: Text(
                              e.fullname,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],

            // Container(
            //   height: 300,
            //   decoration: BoxDecoration(
            //     border: Border.all(color: kGrey3Color, width: 1),
            //     borderRadius: BorderRadius.circular(6),
            //   ),
            //   child: Column(
            //     children: [
            //       // search input
            //       // _buildSearchInput(context),
            //       // drivers checkboxes
            //       // Expanded(
            //       //   child:
            //       // ),
            //     ],
            //   ),
            // ),
            SizedBox(height: 16.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button(
                  primary: kPrimaryColor,
                  textColor: kWhite,
                  text: "Back",
                  onPressed: () {
                    pageController.previousPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.decelerate,
                    );
                  },
                ),
                SizedBox(width: 16.sp),
                Button(
                  primary: kPrimaryColor,
                  textColor: kWhite,
                  text: "Assign",
                  isLoading: isAssignLoading,
                  onPressed: onAssignPressed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildSearchInput(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 38,
      child: TextField(
        controller: searchTextController,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
          hoverColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
          hintText: 'Search drivers',
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: kGrey1Color),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: const BorderSide(
              color: kGrey3Color,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: const BorderSide(
              color: kGrey3Color,
              width: 1,
            ),
          ),
          errorBorder: InputBorder.none,
          prefixIcon: Padding(
            padding: EdgeInsets.all(10.sp),
            child: AppIcons.svgAsset(
              AppIcons.search,
              color: kGrey1Color,
              height: 24.sp,
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildTimeSelecterWidget(
  BuildContext context,
  String label,
  DateTime? value,
  void Function() onTap,
) {
  if (value != null) {}
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: Theme.of(context).textTheme.caption),
      SizedBox(height: 8),
      InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 34,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: kGrey2Color),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (value != null)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                        left: 16,
                      ),
                      child: Text(
                        DateHelper.yyyyMMdd(value),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: AppIcons.svgAsset(AppIcons.clock),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
