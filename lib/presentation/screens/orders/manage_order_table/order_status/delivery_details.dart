import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/data/models/address.model.dart';
import 'package:lng_adminapp/data/models/orders/order.model.dart';
import 'package:lng_adminapp/data/models/orders/single-order-upload.model.dart';
import 'package:lng_adminapp/data/models/receiver.model.dart';
import 'package:lng_adminapp/data/services/app.service.dart';
import 'package:lng_adminapp/presentation/screens/orders/manage_order_table/widgets/label_of_details.dart';
import 'package:lng_adminapp/presentation/screens/orders/order.bloc.dart';
import 'package:lng_adminapp/shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/info.label.dart';

class DeliveryDetails extends StatefulWidget {
  final Order order;
  const DeliveryDetails({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<DeliveryDetails> createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final IDController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNoController = TextEditingController();
  final emailAddressController = TextEditingController();
  final companyController = TextEditingController();
  final merchantNoteController = TextEditingController();
  final receiverNoteController = TextEditingController();
  final addressLineOneController = TextEditingController();
  final addressLineTwoController = TextEditingController();
  final postalCodeController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final longitudeController = TextEditingController();
  final latitudeController = TextEditingController();

  bool isEditMode = false;
  late OrderBloc orderBloc;

  @override
  void initState() {
    IDController.text = replaceStringWithDash(widget.order.receiverDetail?.id);
    firstNameController.text =
        replaceStringWithDash(widget.order.receiverDetail?.firstName);
    lastNameController.text =
        replaceStringWithDash(widget.order.receiverDetail?.lastName);
    phoneNoController.text =
        replaceStringWithDash(widget.order.receiverDetail?.phoneNumber);
    emailAddressController.text =
        replaceStringWithDash(widget.order.receiverDetail?.emailAddress);
    companyController.text =
        replaceStringWithDash(widget.order.receiverDetail?.company);
    merchantNoteController.text =
        replaceStringWithDash(widget.order.deliveryNotesFromMerchant);
    receiverNoteController.text =
        replaceStringWithDash(widget.order.deliveryNotesFromReceiver);
    addressLineOneController.text = replaceStringWithDash(
        widget.order.receiverDetail?.address?.addressLineOne);
    addressLineTwoController.text = replaceStringWithDash(
        widget.order.receiverDetail?.address?.addressLineTwo);
    postalCodeController.text =
        replaceStringWithDash(widget.order.receiverDetail?.address?.postalCode);
    cityController.text =
        replaceStringWithDash(widget.order.receiverDetail?.address?.city);
    stateController.text =
        replaceStringWithDash(widget.order.receiverDetail?.address?.state);
    countryController.text =
        replaceStringWithDash(widget.order.receiverDetail?.address?.country);
    longitudeController.text =
        replaceStringWithDash(widget.order.receiverDetail?.address?.longitude);
    latitudeController.text =
        replaceStringWithDash(widget.order.receiverDetail?.address?.latitude);

    orderBloc = context.read<OrderBloc>();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
                    label: "Delivery details",
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
                      controller: phoneNoController,
                    ),
                    child2: InfoWithLabel(
                      label: "Email address",
                      editMode: isEditMode,
                      controller: emailAddressController,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  InfoWithLabel(
                    label: "Company",
                    editMode: isEditMode,
                    controller: companyController,
                  ),
                  SizedBox(height: 32.h),
                  InfoWithLabel(
                    label: "Delivery notes (Merchant)",
                    editMode: isEditMode,
                    controller: merchantNoteController,
                  ),
                  SizedBox(height: 32.h),
                  InfoWithLabel(
                    label: "Delivery notes (Receiver)",
                    editMode: isEditMode,
                    controller: receiverNoteController,
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
                            await submitCustomerDetailsForm();
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

  submitCustomerDetailsForm() async {
    Address receiverAddress = Address(
      addressLineOne: checkIfChangedAndReturn(
          widget.order.receiverDetail?.address?.addressLineOne,
          addressLineOneController.text),
      addressLineTwo: checkIfChangedAndReturn(
          widget.order.receiverDetail?.address?.addressLineTwo,
          addressLineTwoController.text),
      city: checkIfChangedAndReturn(
          widget.order.receiverDetail?.address?.city, cityController.text),
      country: checkIfChangedAndReturn(
          widget.order.receiverDetail?.address?.country,
          countryController.text),
      postalCode: checkIfChangedAndReturn(
          widget.order.receiverDetail?.address?.postalCode,
          postalCodeController.text),
      longitude: checkIfChangedAndReturn(
          widget.order.receiverDetail?.address?.longitude,
          longitudeController.text),
      latitude: checkIfChangedAndReturn(
          widget.order.receiverDetail?.address?.latitude,
          latitudeController.text),
    );

    ReceiverDetail receiverDetails = ReceiverDetail(
      id: IDController.text,
      firstName: checkIfChangedAndReturn(
          widget.order.receiverDetail?.firstName, firstNameController.text),
      lastName: checkIfChangedAndReturn(
          widget.order.receiverDetail?.lastName, lastNameController.text),
      phoneNumber: checkIfChangedAndReturn(
          widget.order.receiverDetail?.phoneNumber, phoneNoController.text),
      company: checkIfChangedAndReturn(
          widget.order.receiverDetail?.company, companyController.text),
      emailAddress: checkIfChangedAndReturn(
          widget.order.receiverDetail?.emailAddress,
          emailAddressController.text),
      address: receiverAddress,
    );

    UpdateSingleOrderModel _data = UpdateSingleOrderModel(
      orderId: widget.order.id,
      deliveryNotesFromMerchant: checkIfChangedAndReturn(
          widget.order.deliveryNotesFromMerchant, merchantNoteController.text),
      deliveryNotesFromReceiver: checkIfChangedAndReturn(
          widget.order.deliveryNotesFromReceiver, receiverNoteController.text),
      receiverDetail: receiverDetails,
    );

    // create model/ service and store this order
    orderBloc.updateOrder(_data, context);
    setState(() => isEditMode = false);
  }
}
