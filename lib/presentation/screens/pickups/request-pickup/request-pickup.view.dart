import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lng_adminapp/data/data.dart';
import 'package:lng_adminapp/data/models/pickup/create-pickup-request.model.dart';
import 'package:lng_adminapp/presentation/screens/pickups/pickup.bloc.dart';
import 'package:lng_adminapp/presentation/shared/components/layouts/view-content.layout.dart';
import 'package:lng_adminapp/shared.dart';

class RequestPickup extends StatelessWidget {
  static const String routeName = 'request-pickup';
  const RequestPickup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _RequestPickup();
  }
}

class _RequestPickup extends StatefulWidget {
  const _RequestPickup({Key? key}) : super(key: key);

  @override
  __RequestPickupState createState() => __RequestPickupState();
}

class __RequestPickupState extends State<_RequestPickup> {
  final TextEditingController _pickupDateController =
      TextEditingController(text: todayDate());
  final TextEditingController _numberOfItemsController =
      TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  GlobalKey<FormState> _requestPickupFormKey = GlobalKey<FormState>();
  late PickupBloc pickupBloc;
  String? _warehouseId;
  List<String> _warehouses = ['Sample'];
  List<String> _merchants = ['Sample'];

  String? _merchantId;
  String? _pickupTime;
  String? _closeTime;

  @override
  void initState() {
    pickupBloc = context.read<PickupBloc>();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyBackground,
      body: Padding(
        padding: EdgeInsets.all(18.w),
        child: BlocBuilder<PickupBloc, PickupState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlatBackButton(),
                SizedBox(
                  height: 32.h,
                ),
                Container(
                  child: Text(
                    'Request a pickup',
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: kText1Color,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Form(
                  key: _requestPickupFormKey,
                  child: ViewContentLayout(
                    margin: 0,
                    height: 600.h,
                    content: [
                      RowOfTwoChildren(
                        child1: LabeledInput(
                          label: "Number of Items",
                          hintText: "200",
                          controller: _numberOfItemsController,
                          validator: (value) {
                            return emptyField(value);
                          },
                        ),
                        child2: LabeledInput(
                          label: "Estimated Weight(kg)",
                          hintText: "123",
                          controller: _weightController,
                          validator: (value) {
                            return emptyField(value);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      RowOfTwoChildren(
                        child1: LabeledInput(
                          controller: _pickupDateController,
                          label: "Pickup Date",
                          suffixIcon: AppIcons.svgAsset(
                            AppIcons.calendar,
                            color: kPrimaryColor,
                          ),
                          validator: (value) {
                            return emptyField(value);
                          },
                        ),
                        child2: SizedBox(),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      RowOfTwoChildren(
                        child1: LabeledHourSelectInput(
                          label: "Pickup time",
                          value: _pickupTime,
                          onSelected: (v) {
                            setState(() {
                              _pickupTime = v;
                            });
                          },
                          items: hoursIn12HourSystem(),
                        ),
                        child2: LabeledHourSelectInput(
                          label: "Closing time",
                          value: _closeTime,
                          onSelected: (v) {
                            setState(() {
                              _closeTime = v;
                            });
                          },
                          items: hoursIn12HourSystem(),
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      // RowOfTwoChildren(
                      //   child1: LabeledRadioDropdown(
                      //     label: "Select merchant",
                      //     value: _merchantId,
                      //     onSelected: (String v) => setState(() {
                      //       _merchantId = v;
                      //     }),
                      //     items: _merchants,
                      //   ),
                      //   child2: LabeledRadioDropdown(
                      //     label: "Select warehouse",
                      //     value: _warehouseId,
                      //     onSelected: (String v) => setState(() {
                      //       _warehouseId = v;
                      //     }),
                      //     items: _warehouses,
                      //   ),
                      // ),
                    ],
                    footer: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        Button(
                          text: 'Save',
                          hasBorder: true,
                          textColor: kGrey1Color,
                          isLoading: state.createPickupRequestStatus ==
                              CreatePickupRequestStatus.loading,
                          onPressed: () async {
                            if (_requestPickupFormKey.currentState!
                                .validate()) {
                              await submitForm(pickupBloc, context);
                            }
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  submitForm(PickupBloc pickupBloc, BuildContext context) async {
    String pickupDate = _pickupDateController.text;
    var closeTimeBreakdown = convertTo24HrTime(_closeTime!);
    var pickupTimeBreakdown = convertTo24HrTime(_pickupTime!);
    DateTime pickupTimeWindowEnd =
        DateTime.parse('$pickupDate $closeTimeBreakdown');
    DateTime pickupTimeWindowStart =
        DateTime.parse('$pickupDate $pickupTimeBreakdown');
    var formatter = new DateFormat('yyyy-MM-ddTHH:mm:ss');
    String _startDate = formatter.format(pickupTimeWindowStart);
    String _endDate = formatter.format(pickupTimeWindowEnd);
    CreatePickupRequest _createPickupRequest = CreatePickupRequest(
      numberOfItems: int.parse(_numberOfItemsController.text),
      weight: int.parse(_weightController.text),
      pickupTimeWindowEnd: _endDate,
      pickupTimeWindowStart: _startDate,
      type: 'PICKUP',
    );
    await pickupBloc.savePickupRequest(_createPickupRequest, context);
  }
}
