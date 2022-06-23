import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/data/models/address.model.dart';
import 'package:lng_adminapp/data/models/contact-detail.model.dart';
import 'package:lng_adminapp/data/models/orders/order_package.model.dart';
import 'package:lng_adminapp/data/models/orders/order_reference.model.dart';
import 'package:lng_adminapp/data/models/orders/single-order-upload.model.dart';
import 'package:lng_adminapp/data/models/role/role.model.dart';
import 'package:lng_adminapp/data/models/user.model.dart';
import 'package:lng_adminapp/data/services/app.service.dart';
import 'package:lng_adminapp/data/services/user.service.dart';
import 'package:lng_adminapp/presentation/screens/merchants/merchants.bloc.dart';
import 'package:lng_adminapp/presentation/screens/orders/order.bloc.dart';
import 'package:lng_adminapp/shared.dart';

class UploadSingleDialog extends StatefulWidget {
  const UploadSingleDialog({Key? key}) : super(key: key);

  @override
  _UploadSingleDialogState createState() => _UploadSingleDialogState();
}

class _UploadSingleDialogState extends State<UploadSingleDialog>
    with WidgetsBindingObserver {
  PageController _pageController = PageController(initialPage: 0);
  var _currentPage = ValueNotifier(0);
  GlobalKey<FormState> _orderDetailsSectionKey = GlobalKey<FormState>();

  final TextEditingController _orderNameController = TextEditingController();
  final TextEditingController _orderNumberController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  GlobalKey<FormState> _pickupDetailsSectionKey = GlobalKey<FormState>();
  final TextEditingController _pickupDateController = TextEditingController();
  final TextEditingController _pAddressLineOneController =
      TextEditingController();
  final TextEditingController _pAddressLineTwoController =
      TextEditingController();
  final TextEditingController _pPostalCodeController = TextEditingController();
  final TextEditingController _pickupNoteController = TextEditingController();

  GlobalKey<FormState> _deliveryDetailsSectionKey = GlobalKey<FormState>();
  final TextEditingController _deliveryDateController = TextEditingController();
  final TextEditingController _dAddressLineOneController =
      TextEditingController();
  final TextEditingController _dAddressLineTwoController =
      TextEditingController();
  final TextEditingController _dPostalCodeController = TextEditingController();
  final TextEditingController _deliveryNoteController = TextEditingController();
  final TextEditingController _customerFirstNameController =
      TextEditingController();
  final TextEditingController _customerLastNameController =
      TextEditingController();
  final TextEditingController _customerPhoneNumberController =
      TextEditingController();
  final TextEditingController _customerCompanyController =
      TextEditingController();
  final TextEditingController _customerEmailController =
      TextEditingController();

  late OrderBloc orderBloc;
  User? merchant;

  @override
  void initState() {
    orderBloc = context.read<OrderBloc>();
    _orderNameController.text = "Order name";
    _orderNumberController.text = "#0101133";
    _descriptionController.text = "This is order description";
    _priceController.text = "50";
    _weightController.text = "34";
    _quantityController.text = "12";
    _pickupDateController.text = "2020-12-21";
    _pAddressLineOneController.text = "Pickup address line 1";
    _pAddressLineTwoController.text = "Pickup address line 2";
    _pPostalCodeController.text = "877888";
    _pickupNoteController.text = "This is pickup note";
    _deliveryDateController.text = "2020-21-21";
    _dAddressLineOneController.text = "Delivery address line 1";
    _dAddressLineTwoController.text = "Delivery address line 2";
    _dPostalCodeController.text = "744000";
    _deliveryNoteController.text = "This is delivery note";
    _customerFirstNameController.text = "Atabek";
    _customerLastNameController.text = "Kadirov";
    _customerPhoneNumberController.text = "863494748";
    _customerCompanyController.text = 'LnG';
    _customerEmailController.text = 'atabek@mail.com';
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool get isTenant =>
      AppService.currentUser.value != null &&
      AppService.currentUser.value!.role?.name == RoleType.TENANT.name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 402.w,
      padding: EdgeInsets.symmetric(
        vertical: 24.h,
      ),
      child: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          return ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 32.w,
            ),
            shrinkWrap: true,
            children: [
              Row(
                children: [
                  SizedBox(),
                  Expanded(
                    child: Text(
                      "Single order upload",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: _currentPage,
                    builder: (BuildContext context, int? v, Widget? child) {
                      return Text(
                        "${v! + 1}/3",
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    },
                  )
                ],
              ),
              ExpandablePageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (value) {
                  _currentPage.value = value;
                },
                children: [
                  _OrderDetailsSection(
                    formKey: _orderDetailsSectionKey,
                    orderNameController: _orderNameController,
                    orderNumberController: _orderNumberController,
                    descriptionController: _descriptionController,
                    quantityController: _quantityController,
                    weightController: _weightController,
                    priceController: _priceController,
                  ),
                  BlocBuilder<MerchantBloc, MerchantState>(
                      builder: (context, state) {
                    return _PickupDetailsScreen(
                      formKey: _pickupDetailsSectionKey,
                      addressLineOneController: _pAddressLineOneController,
                      addressLineTwoController: _pAddressLineTwoController,
                      pickupDateController: _pickupDateController,
                      pickupNoteController: _pickupNoteController,
                      postalCodeController: _pPostalCodeController,
                      isTenant: isTenant,
                      merchant: merchant,
                      onMerchantChanged: (v) {
                        setState(() {
                          merchant = v;
                        });
                      },
                      merchants: state.merchants?.items,
                      isFetchingMerchants: isTenant
                          ? state.listMerchantStatus ==
                              ListMerchantStatus.loading
                          : false,
                    );
                  }),
                  _DeliveryDetailsScreen(
                    formKey: _deliveryDetailsSectionKey,
                    addressLineOneController: _dAddressLineOneController,
                    addressLineTwoController: _dAddressLineTwoController,
                    deliveryDateController: _deliveryDateController,
                    deliveryNoteController: _deliveryNoteController,
                    postalCodeController: _dPostalCodeController,
                    customerCompanyController: _customerCompanyController,
                    customerFirstNameController: _customerFirstNameController,
                    customerLastNameController: _customerLastNameController,
                    customerPhoneNumberController:
                        _customerPhoneNumberController,
                    customerEmailController: _customerEmailController,
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              RowOfTwoChildren(
                child1: ValueListenableBuilder(
                  valueListenable: _currentPage,
                  builder: (BuildContext context, int? v, Widget? child) {
                    return Button(
                      text: v == 0 ? 'Close' : 'Previous',
                      primary: kWhite,
                      hasBorder: true,
                      textColor: kText1Color,
                      elevation: 0,
                      onPressed: onWillPop,
                    );
                  },
                ),
                child2: ValueListenableBuilder(
                  valueListenable: _currentPage,
                  builder: (BuildContext context, int? v, Widget? child) {
                    return Button(
                      text: v == 2 ? "Submit" : "Next",
                      primary: kPrimaryColor,
                      hasBorder: false,
                      textColor: kWhite,
                      elevation: 0,
                      isLoading: v == 2
                          ? (state.createSingleOrderStatus ==
                                  CreateSingleOrderStatus.loading
                              ? true
                              : false)
                          : false,
                      onPressed: () async {
                        if (v == 0) {
                          final isOrderDetailsFormValid =
                              _orderDetailsSectionKey.currentState!.validate();

                          if (isOrderDetailsFormValid) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.decelerate,
                            );
                          }
                        } else if (v == 1) {
                          final isPickupDetailsFormValid =
                              _pickupDetailsSectionKey.currentState!.validate();
                          if (isPickupDetailsFormValid) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.decelerate,
                            );
                          }
                        } else if (v == 2) {
                          final isDeliveryDetailsFormValid =
                              _deliveryDetailsSectionKey.currentState!
                                  .validate();
                          if (isDeliveryDetailsFormValid) {
                            await submitSingleUploadForm(orderBloc, context);
                          }
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void onWillPop() {
    if (!hasPrevious) {
      Navigator.of(context).pop();
    } else {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    }
  }

  // logic
  bool get hasPrevious {
    return _pageController.page!.round() > _pageController.initialPage;
  }

  submitSingleUploadForm(OrderBloc orderBloc, BuildContext context) async {
    Address _pickupAddress = Address(
      addressLineOne: _pAddressLineOneController.text,
      addressLineTwo: _pAddressLineTwoController.text,
      postalCode: _pPostalCodeController.text,
      specificTypeOfLocation: SpecificTypeOfLocation.SENDER_ADDRESS,
      typeOfContactForAddress: TypeOfContactForAddress.SENDER,
    );

    Address _deliveryAddress = Address(
      addressLineOne: _dAddressLineOneController.text,
      addressLineTwo: _dAddressLineTwoController.text,
      postalCode: _dPostalCodeController.text,
      specificTypeOfLocation: SpecificTypeOfLocation.RECEIVER_ADDRESS,
      typeOfContactForAddress: TypeOfContactForAddress.RECEIVER,
    );

    ContactDetail receiver = ContactDetail(
      firstName: _customerFirstNameController.text,
      lastName: _customerLastNameController.text,
      phoneNumber: _customerPhoneNumberController.text,
      company: _customerCompanyController.text,
      address: _deliveryAddress,
    );

    ContactDetail sender = ContactDetail(
      firstName: _customerFirstNameController.text,
      lastName: _customerLastNameController.text,
      phoneNumber: _customerPhoneNumberController.text,
      company: _customerCompanyController.text,
      address: _pickupAddress,
    );

    OrderPackage _orderPackage = OrderPackage(
      name: _orderNameController.text,
      description: _descriptionController.text,
      quantity: int.tryParse(_quantityController.text) ?? 0,
      price: int.tryParse(_priceController.text) ?? 0,
      currency: "USD",
      height: 0,
      width: 0,
      length: 0,
      dimensionUnit: DimensionUnitConversion.CENTIMETER,
      weight: 0,
      weightUnit: WeightUnitConversion.KILOGRAM,
      isDangerousGood: false,
      type: TypeOfPackage.PARCEL,
      otherNotes: "",
      orderId: "121212",
    );

    OrderReference orderReference = OrderReference(
      merchantOrderNumber: _orderNumberController.text,
    );

    SingleOrderUploadModel _data = SingleOrderUploadModel(
      merchantId: isTenant
          ? merchant!.merchant?.id
          : AppService.currentUser.value?.merchant?.id,
      receiverDetail: receiver,
      senderDetail: sender,
      orderPackages: {
        "orderPackage": [_orderPackage]
      },
      orderReference: orderReference,
      serviceLevel: 'NEXT_DAY',
      serviceType: 'LOCAL_PARCEL_LESSER_THAN_30KG',
      allowWeekendDelivery: false,
      requestedDeliveryTimeSlotType: DeliveryTimeSlotType.STANDARD,
      requestedDeliveryTimeSlotStart: DateTime(2022, 03, 02).toIso8601String(),
      requestedDeliveryTimeSlotEnd: DateTime(2022, 03, 02).toIso8601String(),
      cashOnDeliveryRequested: false,
      cashOnDeliveryAmount: null,
      cashOnDeliveryCurrency: "string",
      insuredAmount: null,
      insuredAmountCurrency: "string",
    );

    // create model/ service and store this order
    await orderBloc.createSingleOrder(_data, context);
  }
}

class _OrderDetailsSection extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController orderNameController;
  final TextEditingController orderNumberController;
  final TextEditingController descriptionController;
  final TextEditingController weightController;
  final TextEditingController quantityController;
  final TextEditingController priceController;

  const _OrderDetailsSection(
      {Key? key,
      required this.formKey,
      required this.orderNameController,
      required this.orderNumberController,
      required this.descriptionController,
      required this.weightController,
      required this.quantityController,
      required this.priceController})
      : super(key: key);

  @override
  State<_OrderDetailsSection> createState() => __OrderDetailsSectionState();
}

class __OrderDetailsSectionState extends State<_OrderDetailsSection> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16.h),
          Text(
            "Order details",
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 16.h),
          LabeledInput(
            label: "Order name*",
            controller: widget.orderNameController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              return emptyField(value);
            },
          ),
          SizedBox(height: 16.h),
          LabeledInput(
            label: "Order number*",
            controller: widget.orderNumberController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              return emptyField(value);
            },
          ),
          SizedBox(height: 16.h),
          LabeledInput(
            label: "Description*",
            controller: widget.descriptionController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              return emptyField(value);
            },
          ),
          SizedBox(height: 16.h),
          LabeledInput(
            label: "Price*",
            controller: widget.priceController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              return emptyField(value);
            },
          ),
          SizedBox(height: 16.h),
          RowOfTwoChildren(
            child1: LabeledInput(
              label: "Weight*",
              controller: widget.weightController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                return emptyField(value);
              },
            ),
            child2: LabeledInput(
              label: "Quantity*",
              controller: widget.quantityController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                return emptyField(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PickupDetailsScreen extends StatelessWidget {
  final GlobalKey<FormState>? formKey;

  final TextEditingController pickupDateController;
  final TextEditingController addressLineOneController;
  final TextEditingController addressLineTwoController;
  final TextEditingController postalCodeController;
  final TextEditingController pickupNoteController;

  final bool isTenant;
  final User? merchant;
  final ValueChanged<User?>? onMerchantChanged;
  final List<User>? merchants;
  final bool isFetchingMerchants;

  const _PickupDetailsScreen({
    Key? key,
    required this.formKey,
    required this.pickupDateController,
    required this.addressLineOneController,
    required this.addressLineTwoController,
    required this.postalCodeController,
    required this.pickupNoteController,
    this.merchant,
    this.onMerchantChanged,
    this.merchants,
    this.isFetchingMerchants = false,
    this.isTenant = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16.h),
          Text(
            "Pickup details",
            style: GoogleFonts.inter(
              fontSize: 14.h,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 16.h),
          LabeledInput(
            label: "Pickup date*",
            controller: pickupDateController,
            hintText: '2022-10-10',
            suffixIcon: AppIcons.svgAsset(
              AppIcons.calendar,
              color: kPrimaryColor,
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              return emptyField(value);
            },
          ),
          SizedBox(height: 16.h),
          LabeledInput(
            label: "Address line 1*",
            controller: addressLineOneController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              return emptyField(value);
            },
          ),
          SizedBox(height: 16.h),
          LabeledInput(
            label: "Address line 2",
            controller: addressLineTwoController,
          ),
          if (isTenant) ...[
            if (isFetchingMerchants)
              const Center(child: CircularProgressIndicator()),
            if (isFetchingMerchants == false && merchants != null) ...[
              SizedBox(height: 16.h),
              Text("Merchant*", style: Theme.of(context).textTheme.caption),
              SizedBox(height: 8.h),
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField<User>(
                  items: merchants!
                      .map((e) => DropdownMenuItem<User>(
                            value: e,
                            child: Text(e.fullname,
                                style: Theme.of(context).textTheme.bodyText1),
                          ))
                      .toList(),
                  value: merchant,
                  validator: (v) => v == null ? "This field is required" : null,
                  onChanged: this.onMerchantChanged,
                ),
              ),
            ],
          ],
          SizedBox(height: 16.h),
          RowOfTwoChildren(
            child1: LabeledInput(
              label: "Postal code*",
              controller: postalCodeController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                return emptyField(value);
              },
            ),
            child2: SizedBox(),
          ),
          SizedBox(height: 16.h),
          LabeledInput(
            label: "Pickup note",
            controller: pickupNoteController,
          ),
        ],
      ),
    );
  }
}

class _DeliveryDetailsScreen extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController deliveryDateController;
  final TextEditingController addressLineOneController;
  final TextEditingController addressLineTwoController;
  final TextEditingController postalCodeController;
  final TextEditingController deliveryNoteController;
  final TextEditingController customerFirstNameController;
  final TextEditingController customerLastNameController;
  final TextEditingController customerPhoneNumberController;
  final TextEditingController customerCompanyController;
  final TextEditingController customerEmailController;

  const _DeliveryDetailsScreen({
    Key? key,
    required this.formKey,
    required this.deliveryDateController,
    required this.addressLineOneController,
    required this.addressLineTwoController,
    required this.postalCodeController,
    required this.deliveryNoteController,
    required this.customerFirstNameController,
    required this.customerLastNameController,
    required this.customerPhoneNumberController,
    required this.customerCompanyController,
    required this.customerEmailController,
  }) : super(key: key);

  @override
  State<_DeliveryDetailsScreen> createState() => __DeliveryDetailsScreenState();
}

class __DeliveryDetailsScreenState extends State<_DeliveryDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16.h),
          Text(
            "Delivery details",
            style: GoogleFonts.inter(
              fontSize: 14.h,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 16.h),
          LabeledInput(
            label: "Delivery date*",
            controller: widget.deliveryDateController,
            hintText: '2022-10-10',
            suffixIcon: AppIcons.svgAsset(
              AppIcons.calendar,
              color: kPrimaryColor,
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              return emptyField(value);
            },
          ),
          SizedBox(height: 16.h),
          LabeledInput(
            label: "Address line 1*",
            controller: widget.addressLineOneController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              return emptyField(value);
            },
          ),
          SizedBox(height: 16.h),
          LabeledInput(
            label: "Address line 2",
            controller: widget.addressLineTwoController,
          ),
          SizedBox(height: 16.h),
          RowOfTwoChildren(
              child1: LabeledInput(
                label: "Postal code*",
                controller: widget.postalCodeController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  return emptyField(value);
                },
              ),
              child2: const SizedBox()),
          SizedBox(height: 16.h),
          LabeledInput(
            label: "Delivery note",
            controller: widget.deliveryNoteController,
          ),
          SizedBox(
            height: 16.h,
          ),
          Divider(),
          SizedBox(height: 16.h),
          RowOfTwoChildren(
            child1: LabeledInput(
              label: "Customer first name",
              controller: widget.customerFirstNameController,
            ),
            child2: LabeledInput(
              label: "Customer last name",
              controller: widget.customerLastNameController,
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          RowOfTwoChildren(
            child1: LabeledInput(
              label: "Customer phone number",
              controller: widget.customerPhoneNumberController,
            ),
            child2: LabeledInput(
              label: "Customer company",
              controller: widget.customerCompanyController,
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          LabeledInput(
            label: "Customer email",
            controller: widget.customerEmailController,
          ),
        ],
      ),
    );
  }
}
