import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/data/data.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/data/models/contact-detail.model.dart';
import 'package:lng_adminapp/data/models/location/location.model.dart';
import 'package:lng_adminapp/data/models/orders/order.model.dart';
import 'package:lng_adminapp/data/models/task/create-task.model.dart';
import 'package:lng_adminapp/data/models/user.model.dart';
import 'package:lng_adminapp/data/services/order.service.dart';
import 'package:lng_adminapp/presentation/screens/drivers/drivers.bloc.dart';
import 'package:lng_adminapp/presentation/screens/locations/location.bloc.dart';
import 'package:lng_adminapp/presentation/screens/screens.dart';
import 'package:lng_adminapp/shared.dart';

class DriverAssigningDialog extends StatefulWidget {
  DriverAssigningDialog({
    Key? key,
    required this.selectedOrders,
  }) : super(key: key);

  final List<Order> selectedOrders;

  @override
  State<DriverAssigningDialog> createState() => _DriverAssigningDialogState();
}

class _DriverAssigningDialogState extends State<DriverAssigningDialog> {
  final _pageViewController = PageController();
  late List<String> hours;

  // blocs
  late LocationBloc locationBloc;
  late DriverBloc driverBloc;

  // task type
  TaskRelatedWorkflowSteps? taskType;

  // Pickup details
  String? _pickupTime;
  String? _pickupCloseTime;
  String? _pickupWarehouseId;
  bool isPickupCustomAddress = false;
  final pickupAddress1Controller = TextEditingController();
  final pickupAddress2Controller = TextEditingController();
  final pickupPostalController = TextEditingController();
  final pickupCityController = TextEditingController();
  final pickupCountryController = TextEditingController();

  // Drop-off details
  String? _dropoffTime;
  String? _dropoffCloseTime;
  String? _dropoffLocationId;
  bool isdropoffCustomAddress = false;
  final dropoffAddress1Controller = TextEditingController();
  final dropoffAddress2Controller = TextEditingController();
  final dropoffPostalController = TextEditingController();
  final dropoffCityController = TextEditingController();
  final dropoffCountryController = TextEditingController();

  // Assign drivers
  final searchTextController = TextEditingController();
  String? _selectedDriverId;
  bool assignLoading = false;

  @override
  void initState() {
    _pickupTime = "2022-04-14";
    _pickupCloseTime = "2022-04-14";
    _dropoffTime = "2022-04-14";
    _dropoffCloseTime = "2022-04-14";

    hours = hoursIn12HourSystem();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    driverBloc = BlocProvider.of<DriverBloc>(context);

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
        width: 0.279.sw,
        color: kWhite,
        padding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 32,
        ),
        child: ExpandablePageView(
          controller: _pageViewController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _TaskType(
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
                loadingLocations: showLoading,
                locations: state.locations?.items ?? [],
                locationId: _pickupWarehouseId,
                onLocationValueChanged: (v) {
                  _setState(() => _pickupWarehouseId = v);
                },
                pageController: _pageViewController,
                hours: hours,
                pickupTime: _pickupTime,
                closeTime: _pickupCloseTime,
                isCustomAddress: isPickupCustomAddress,
                pickupAddress1Controller: pickupAddress1Controller,
                pickupAddress2Controller: pickupAddress2Controller,
                pickupCityController: pickupCityController,
                pickupCountryController: pickupCountryController,
                pickupPostalController: pickupPostalController,
                onPickupTimeChanged: (v) {
                  _setState(() => _pickupTime = v);
                },
                onCloseTimeChanged: (v) {
                  _setState(() => _pickupCloseTime = v);
                },
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
                  loadingLocations: showLoading,
                  locations: state.locations?.items ?? [],
                  locationId: _dropoffLocationId,
                  onLocationValueChanged: (v) {
                    _setState(() => _dropoffLocationId = v);
                  },
                  pageController: _pageViewController,
                  hours: hours,
                  dropoffTime: _dropoffTime,
                  closeTime: _dropoffCloseTime,
                  isCustomAddress: isdropoffCustomAddress,
                  dropoffAddress1Controller: dropoffAddress1Controller,
                  dropoffAddress2Controller: dropoffAddress2Controller,
                  dropoffCityController: dropoffCityController,
                  dropoffCountryController: dropoffCountryController,
                  dropoffPostalController: dropoffPostalController,
                  onCloseTimeChanged: (v) {
                    _setState(() => _dropoffCloseTime = v);
                  },
                  onDropoffTimeChanged: (v) {
                    _setState(() => _dropoffTime = v);
                  },
                  onCustomAddressChanged: (v) {
                    _setState(() => isdropoffCustomAddress = v ?? false);
                  },
                );
              }),
            BlocBuilder<DriverBloc, DriverState>(builder: (context, state) {
              return _AssignDriver(
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
    var buttonDisabled = taskType == null ||
        _pickupTime == null ||
        _pickupCloseTime == null ||
        _selectedDriverId == null;

    if (buttonDisabled)
      return null;
    else {
      stateChanger(() => assignLoading = true);

      ContactDetail senderContactDetail = ContactDetail();
      ContactDetail receiverContactDetail = ContactDetail();

      AddressWithOtherContactDetails? senderCustomAddress =
          isPickupCustomAddress
              ? AddressWithOtherContactDetails(
                  typeOfContactForAddress: TypeOfContactForAddress.SENDER,
                  addressLineOne: pickupAddress1Controller.text,
                  addressLineTwo: notNullOrEmpty(pickupAddress2Controller.text),
                  postalCode: notNullOrEmpty(pickupPostalController.text),
                  city: notNullOrEmpty(pickupCityController.text),
                  country: notNullOrEmpty(pickupCountryController.text),
                  specificTypeOfLocation: SpecificTypeOfLocation.SENDER_ADDRESS,
                  otherContactDetail: senderContactDetail,
                )
              : null;

      AddressWithOtherContactDetails? receiverCustomAddress =
          isdropoffCustomAddress
              ? AddressWithOtherContactDetails(
                  typeOfContactForAddress: TypeOfContactForAddress.RECEIVER,
                  addressLineOne: dropoffAddress1Controller.text,
                  addressLineTwo:
                      notNullOrEmpty(dropoffAddress2Controller.text),
                  postalCode: notNullOrEmpty(dropoffPostalController.text),
                  city: notNullOrEmpty(dropoffCityController.text),
                  country: notNullOrEmpty(dropoffCountryController.text),
                  specificTypeOfLocation:
                      SpecificTypeOfLocation.RECEIVER_ADDRESS,
                  otherContactDetail: receiverContactDetail,
                )
              : null;

      CreateTaskEntity taskEntity = () {
        switch (taskType) {
          case TaskRelatedWorkflowSteps.ON_VEHICLE_FOR_DELIVERY:
            return CreateTaskEntity(
              relationToWhichSpecificTaskRelatedStatus: taskType!,
              startTimeForPickUp: _pickupTime!,
              endTimeForPickUp: _pickupCloseTime!,
              genericTypeOfAddressForPickUp:
                  GenericTypeOfLocation.TENANT_WAREHOUSE,
              addressIdIfExistingForPickUp: _pickupWarehouseId,
              addressAndContactIfNewForPickUp: senderCustomAddress,
              orderIds: widget.selectedOrders.map((e) => e.id).toList(),
              driverId: _selectedDriverId!,
            );

          case TaskRelatedWorkflowSteps
              .ON_VEHICLE_TO_DISPATCH_POINT_FOR_DELIVERY_DISPATCH:
          case TaskRelatedWorkflowSteps.ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING:
          default:
            return CreateTaskEntity(
              relationToWhichSpecificTaskRelatedStatus: taskType!,
              startTimeForPickUp: _pickupTime!,
              endTimeForPickUp: _pickupCloseTime!,
              addressIdIfExistingForPickUp: _pickupWarehouseId,
              genericTypeOfAddressForPickUp:
                  GenericTypeOfLocation.TENANT_WAREHOUSE,
              addressAndContactIfNewForPickUp: senderCustomAddress,
              startTimeForDropOff: _dropoffTime,
              endTimeForDropOff: _dropoffCloseTime,
              genericTypeOfAddressForDropOff:
                  GenericTypeOfLocation.RECEIVER_ADDRESS,
              addressIdIfExistingForDropOff: _dropoffLocationId,
              addressAndContactIfNewForDropOff: receiverCustomAddress,
              orderIds: widget.selectedOrders.map((e) => e.id).toList(),
              driverId: _selectedDriverId!,
            );
        }
      }();

      try {
        var res = await OrderService.assignDriver(taskEntity);
        if (res) {
          showSnackBar(
              context, Text("Task created and assigned successfully."));
          Navigator.pushNamedAndRemoveUntil(
              context, IndexScreen.routeName, (route) => false);
        }
      } catch (_) {
      } finally {
        stateChanger(() => assignLoading = false);
      }
    }
  }

  String? notNullOrEmpty(String? value) {
    return (value != null && value.isNotEmpty) ? value : null;
  }
}

class _TaskType extends StatelessWidget {
  const _TaskType({
    Key? key,
    required this.pageController,
    required this.onTaskTypeChanged,
    this.taskTypeValue,
  }) : super(key: key);

  final PageController pageController;

  final TaskRelatedWorkflowSteps? taskTypeValue;
  final ValueChanged<TaskRelatedWorkflowSteps?> onTaskTypeChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Align(alignment: Alignment.centerLeft, child: Text("Task type")),
        SizedBox(height: 8),
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField<TaskRelatedWorkflowSteps>(
            items: TaskRelatedWorkflowSteps.values
                .map((e) => DropdownMenuItem<TaskRelatedWorkflowSteps>(
                      value: e,
                      child: Text(e.name),
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
            pageController.nextPage(
                duration: const Duration(milliseconds: 250),
                curve: Curves.decelerate);
          },
        ),
      ],
    );
  }
}

class _PickupDetails extends StatelessWidget {
  const _PickupDetails({
    Key? key,
    required this.pageController,
    required this.pickupAddress1Controller,
    required this.pickupAddress2Controller,
    required this.pickupPostalController,
    required this.pickupCityController,
    required this.pickupCountryController,
    required this.isCustomAddress,
    required this.hours,
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

  final PageController pageController;
  final List<String> hours;

  final bool loadingLocations;
  final String? locationId;
  final ValueChanged<String?> onLocationValueChanged;
  final List<Location> locations;

  final String? pickupTime;
  final ValueChanged<String?> onPickupTimeChanged;

  final String? closeTime;
  final ValueChanged<String?> onCloseTimeChanged;

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
      return Column(
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
          SizedBox(height: 16.sp),
          RowOfTwoChildren(
            child1: LabeledHourSelectInput(
              label: "Pickup time",
              value: pickupTime,
              onSelected: onPickupTimeChanged,
              items: hours,
            ),
            child2: LabeledHourSelectInput(
              label: "Close time",
              value: closeTime,
              onSelected: onCloseTimeChanged,
              items: hours,
            ),
          ),
          SizedBox(height: 16.sp),
          if (!isCustomAddress) ...[
            if (loadingLocations) Text("Fetching warehouses, please wait..."),
            if (!loadingLocations)
              DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<String>(
                value: locationId,
                onChanged: onLocationValueChanged,
                isExpanded: true,
                items: locations
                    .map((e) => DropdownMenuItem<String>(
                          value: e.address?.id ?? e.id,
                          child: Text(e.name ?? e.address?.fullAddress ?? ""),
                        ))
                    .toList(),
              )),
          ],
          if (!isCustomAddress) SizedBox(height: 16.sp),
          if (isCustomAddress) ...[
            LabeledInput(
              label: "Address line 1",
              hintText: "Address line 1",
              controller: pickupAddress1Controller,
            ),
            SizedBox(height: 16.sp),
            LabeledInput(
              label: "Address line 2 (optional)",
              hintText: "Address line 2",
              controller: pickupAddress2Controller,
            ),
            SizedBox(height: 16.sp),
            LabeledInput(
              label: "Postal code",
              hintText: "Postal code",
              controller: pickupPostalController,
            ),
            SizedBox(height: 16.sp),
            LabeledInput(
              label: "City",
              hintText: "City",
              controller: pickupCityController,
            ),
            SizedBox(height: 16.sp),
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
              SizedBox(width: 6.sp),
              Text(
                "Custom address",
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
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
                text: "Next",
                onPressed: () {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.decelerate,
                  );
                },
              ),
            ],
          ),
        ],
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
    required this.hours,
    required this.onCloseTimeChanged,
    required this.onCustomAddressChanged,
    required this.onDropoffTimeChanged,
    required this.loadingLocations,
    this.closeTime,
    this.dropoffTime,
    this.locations = const [],
    this.locationId,
    required this.onLocationValueChanged,
  }) : super(key: key);

  final PageController pageController;
  final bool loadingLocations;
  final String? locationId;
  final ValueChanged<String?> onLocationValueChanged;
  final List<Location> locations;

  final String? dropoffTime;
  final ValueChanged<String?> onDropoffTimeChanged;

  final String? closeTime;
  final ValueChanged<String?> onCloseTimeChanged;

  final List<String> hours;

  final bool isCustomAddress;
  final ValueChanged<bool?> onCustomAddressChanged;

  final TextEditingController dropoffAddress1Controller;
  final TextEditingController dropoffAddress2Controller;
  final TextEditingController dropoffPostalController;
  final TextEditingController dropoffCityController;
  final TextEditingController dropoffCountryController;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        SizedBox(height: 16.sp),
        RowOfTwoChildren(
          child1: LabeledHourSelectInput(
            label: "Drop-off time",
            value: dropoffTime,
            onSelected: onDropoffTimeChanged,
            items: hours,
          ),
          child2: LabeledHourSelectInput(
            label: "Close time",
            value: closeTime,
            onSelected: onCloseTimeChanged,
            items: hours,
          ),
        ),
        SizedBox(height: 16.sp),
        if (!isCustomAddress) ...[
          if (loadingLocations) Text("Fetching locations, please wait..."),
          if (!loadingLocations)
            DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
              value: locationId,
              onChanged: onLocationValueChanged,
              isExpanded: true,
              items: locations
                  .map((e) => DropdownMenuItem<String>(
                        value: e.address?.id ?? e.id,
                        child: Text(e.name ?? e.address?.fullAddress ?? ""),
                      ))
                  .toList(),
            )),
        ],
        if (!isCustomAddress) SizedBox(height: 16.sp),
        if (isCustomAddress) ...[
          LabeledInput(
            label: "Address line 1",
            hintText: "Address line 1",
            controller: dropoffAddress1Controller,
          ),
          SizedBox(height: 16.sp),
          LabeledInput(
            label: "Address line 2 (optional)",
            hintText: "Address line 2",
            controller: dropoffAddress2Controller,
          ),
          SizedBox(height: 16.sp),
          LabeledInput(
            label: "Postal code",
            hintText: "Postal code",
            controller: dropoffPostalController,
          ),
          SizedBox(height: 16.sp),
          LabeledInput(
            label: "City",
            hintText: "City",
            controller: dropoffCityController,
          ),
          SizedBox(height: 16.sp),
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
            SizedBox(width: 6.sp),
            Text(
              "Custom address",
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
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
              text: "Next",
              onPressed: () {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.decelerate,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _AssignDriver extends StatelessWidget {
  const _AssignDriver({
    Key? key,
    required this.pageController,
    required this.searchTextController,
    required this.onAssignPressed,
    this.driverId,
    this.drivers = const [],
    required this.onDriverValueChanged,
    required this.isDriversBeingFetched,
    required this.isAssignLoading,
  }) : super(key: key);

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
    return Column(
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
        if (!isDriversBeingFetched)
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              value: driverId,
              onChanged: onDriverValueChanged,
              isExpanded: true,
              items: drivers
                  .map((e) => DropdownMenuItem<String>(
                        value: e.driver?.id ?? e.id,
                        child: Text(e.fullname),
                      ))
                  .toList(),
            ),
          ),
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
