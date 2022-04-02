import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/data/models/address.model.dart';
import 'package:lng_adminapp/data/models/orders/order.model.dart';
import 'package:lng_adminapp/data/models/orders/single-order-upload.model.dart';
import 'package:lng_adminapp/data/models/receiver.model.dart';
import 'package:lng_adminapp/data/models/sender.model.dart';
import 'package:lng_adminapp/data/services/app.service.dart';
import 'package:lng_adminapp/presentation/screens/orders/manage_order_table/widgets/info.label.dart';
import 'package:lng_adminapp/presentation/screens/orders/manage_order_table/widgets/label_of_details.dart';
import 'package:lng_adminapp/presentation/screens/orders/order.bloc.dart';
import 'package:lng_adminapp/shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../data/enums/status.enum.dart';

class PickupDetails extends StatefulWidget {
  final Order order;

  const PickupDetails({Key? key, required this.order}) : super(key: key);

  @override
  State<PickupDetails> createState() => _PickupDetailsState();
}

class _PickupDetailsState extends State<PickupDetails> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final IDController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final companyController = TextEditingController();
  final pickupNoteController = TextEditingController();
  final addressLineOneController = TextEditingController();
  final addressLineTwoController = TextEditingController();
  final postalCodeController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final longitudeController = TextEditingController();
  final latitudeController = TextEditingController();
  AddressType? addressType;
  DateTime? createdAt;
  DateTime? updatedAt;

  bool isEditMode = false;
  late OrderBloc orderBloc;

  @override
  void initState() {
    IDController.text = replaceStringWithDash(widget.order.senderDetail?.id);
    firstNameController.text =
        replaceStringWithDash(widget.order.senderDetail?.firstName);
    lastNameController.text =
        replaceStringWithDash(widget.order.senderDetail?.lastName);
    phoneController.text =
        replaceStringWithDash(widget.order.senderDetail?.phoneNumber);
    emailController.text =
        replaceStringWithDash(widget.order.senderDetail?.emailAddress);
    companyController.text =
        replaceStringWithDash(widget.order.senderDetail?.company);
    pickupNoteController.text = replaceStringWithDash(widget.order.pickUpNotes);
    addressLineOneController.text = replaceStringWithDash(
        widget.order.senderDetail?.address?.addressLineOne);
    addressLineTwoController.text = replaceStringWithDash(
        widget.order.senderDetail?.address?.addressLineTwo);
    postalCodeController.text =
        replaceStringWithDash(widget.order.senderDetail?.address?.postalCode);
    cityController.text =
        replaceStringWithDash(widget.order.senderDetail?.address?.city);
    stateController.text =
        replaceStringWithDash(widget.order.senderDetail?.address?.state);
    countryController.text =
        replaceStringWithDash(widget.order.senderDetail?.address?.country);
    longitudeController.text =
        replaceStringWithDash(widget.order.senderDetail?.address?.longitude);
    latitudeController.text =
        replaceStringWithDash(widget.order.senderDetail?.address?.latitude);
    addressType = widget.order.senderDetail?.address?.addressType;

    orderBloc = context.read<OrderBloc>();

    super.initState();
  }

  Widget get horizontalLine => Divider(color: kGrey3Color, thickness: 2.h);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: SingleChildScrollView(
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            return Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  LabelOfDetails(
                    label: "Pickup details",
                    onTap: () {
                      setState(() {
                        isEditMode = true;
                      });
                    },
                    isDisabled: isEditMode,
                  ),
                  SizedBox(height: 24.h),
                  RowOfTwoChildren(
                    child1: InfoWithLabel(
                      label: "ID",
                      editMode: isEditMode,
                      controller: IDController,
                    ),
                    child2: SizedBox.shrink(),
                  ),
                  SizedBox(height: 32.h),
                  RowOfTwoChildren(
                    child1: InfoWithLabel(
                      label: "First name",
                      editMode: isEditMode,
                      controller: firstNameController,
                    ),
                    child2: InfoWithLabel(
                      label: "Last name",
                      editMode: isEditMode,
                      controller: lastNameController,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  RowOfTwoChildren(
                    child1: InfoWithLabel(
                      label: "Phone no",
                      editMode: isEditMode,
                      controller: phoneController,
                    ),
                    child2: InfoWithLabel(
                      label: "Email address",
                      editMode: isEditMode,
                      controller: emailController,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  RowOfTwoChildren(
                    child1: InfoWithLabel(
                      label: "Company",
                      editMode: isEditMode,
                      controller: companyController,
                    ),
                    child2: SizedBox.shrink(),
                  ),
                  SizedBox(height: 32.h),
                  InfoWithLabel(
                    label: "Pickup notes",
                    editMode: isEditMode,
                    controller: pickupNoteController,
                  ),
                  SizedBox(height: 16.h),
                  this.horizontalLine,
                  SizedBox(height: 16.h),
                  LabelOfDetails(label: "Address"),
                  SizedBox(height: 32.h),
                  InfoWithLabel(
                    label: "Address line 1",
                    editMode: isEditMode,
                    controller: addressLineOneController,
                  ),
                  SizedBox(height: 32.h),
                  InfoWithLabel(
                    label: "Address line 2",
                    editMode: isEditMode,
                    controller: addressLineTwoController,
                  ),
                  SizedBox(height: 32.h),
                  RowOfTwoChildren(
                    child1: InfoWithLabel(
                      label: "Postal code",
                      editMode: isEditMode,
                      controller: postalCodeController,
                    ),
                    child2: InfoWithLabel(
                      label: "City",
                      editMode: isEditMode,
                      controller: cityController,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  RowOfTwoChildren(
                    child1: InfoWithLabel(
                      label: "State",
                      editMode: isEditMode,
                      controller: stateController,
                    ),
                    child2: InfoWithLabel(
                      label: "Country",
                      editMode: isEditMode,
                      controller: countryController,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  RowOfTwoChildren(
                    child1: InfoWithLabel(
                      label: "Longitude",
                      editMode: isEditMode,
                      controller: longitudeController,
                    ),
                    child2: InfoWithLabel(
                      label: "Latitude",
                      editMode: isEditMode,
                      controller: latitudeController,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  InfoWithLabel(
                    label: "Address type",
                    editMode: isEditMode,
                  ),
                  SizedBox(height: 32.h),
                  RowOfTwoChildren(
                    child1: InfoWithLabel(
                      label: "Created at",
                      editMode: isEditMode,
                    ),
                    child2: InfoWithLabel(
                      label: "Updated at",
                      editMode: isEditMode,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  if (AppService.hasPermission(PermissionType.UPDATE_ORDER))
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Button(
                          text: 'Cancel',
                          textColor: kBlack,
                          hasBorder: true,
                          borderColor: kGrey2Color,
                          primary: kWhite,
                          isLoading: false,
                          onPressed: () {
                            setState(() {
                              isEditMode = false;
                            });
                          },
                        ),
                        const SizedBox(width: 16.0),
                        Button(
                          text: 'Done',
                          textColor: kWhite,
                          hasBorder: false,
                          primary: kPrimaryColor,
                          isLoading: state.updateSingleOrderStatus ==
                              UpdateSingleOrderStatus.loading,
                          onPressed: () async {
                            await submitPickupDetailsForm();
                          },
                        ),
                      ],
                    ),
                  if (AppService.hasPermission(PermissionType.UPDATE_ORDER))
                    SizedBox(height: 32.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  submitPickupDetailsForm() async {
    Address senderAddress = Address(
      addressLineOne: checkIfChangedAndReturn(
          widget.order.senderDetail?.address?.addressLineOne,
          addressLineOneController.text),
      addressLineTwo: checkIfChangedAndReturn(
          widget.order.senderDetail?.address?.addressLineTwo,
          addressLineTwoController.text),
      addressType: checkIfChangedAndReturn(
          widget.order.senderDetail?.address?.addressType, addressType),
      city: checkIfChangedAndReturn(
          widget.order.senderDetail?.address?.city, cityController.text),
      country: checkIfChangedAndReturn(
          widget.order.senderDetail?.address?.country, countryController.text),
      postalCode: checkIfChangedAndReturn(
          widget.order.senderDetail?.address?.postalCode,
          postalCodeController.text),
      longitude: checkIfChangedAndReturn(
          widget.order.senderDetail?.address?.longitude,
          longitudeController.text),
      latitude: checkIfChangedAndReturn(
          widget.order.senderDetail?.address?.latitude,
          latitudeController.text),
    );

    SenderDetail senderDetails = SenderDetail(
      id: IDController.text,
      firstName: checkIfChangedAndReturn(
          widget.order.senderDetail?.firstName, firstNameController.text),
      lastName: checkIfChangedAndReturn(
          widget.order.senderDetail?.lastName, lastNameController.text),
      phoneNumber: checkIfChangedAndReturn(
          widget.order.senderDetail?.phoneNumber, phoneController.text),
      company: checkIfChangedAndReturn(
          widget.order.senderDetail?.company, companyController.text),
      emailAddress: checkIfChangedAndReturn(
          widget.order.senderDetail?.emailAddress, emailController.text),
      address: senderAddress,
    );

    UpdateSingleOrderModel _data = UpdateSingleOrderModel(
      orderId: widget.order.id,
      pickUpNotes: checkIfChangedAndReturn(
          widget.order.pickUpNotes, pickupNoteController.text),
      pickUpId:
          checkIfChangedAndReturn(widget.order.pickUpId, IDController.text),
      senderDetail: senderDetails,
    );

    // create model/ service and store this order
    orderBloc.updateOrder(_data, context);
    setState(() => isEditMode = false);
  }
}
