import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/data/models/orders/dropped-file.model.dart';
import 'package:lng_adminapp/data/models/orders/get-mapping.model.dart';
import 'package:lng_adminapp/data/models/orders/mapping-response.model.dart';
import 'package:lng_adminapp/data/services/app.service.dart';
import 'package:lng_adminapp/presentation/screens/dialog/enums/dialog.enum.dart';
import 'package:lng_adminapp/presentation/screens/dialog/response/response-dialog.view.dart';
import 'package:lng_adminapp/presentation/screens/orders/order.bloc.dart';
import 'package:lng_adminapp/presentation/screens/orders/widgets/dropzone.widget.dart';
import 'package:lng_adminapp/shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadExcelDialog extends StatefulWidget {
  const UploadExcelDialog({Key? key}) : super(key: key);

  @override
  _UploadExcelDialogState createState() => _UploadExcelDialogState();
}

class _UploadExcelDialogState extends State<UploadExcelDialog>
    with WidgetsBindingObserver {
  late PageController _pageController;
  DroppedFile? _droppedFile;
  late OrderBloc orderBloc;
  int currentPage = 0;

  // order information
  String? _selectedOrderNumber;
  String? _selectedDescription;
  String? _selectedQuantity;
  String? _selectedWeight;
  String? _selectedCurrency;
  String? _selectedDimensionUnit;
  String? _selectedHeight;
  String? _selectedLength;
  String? _selectedName;
  String? _selectedPrice;
  String? _selectedType;
  String? _selectedWeightUnit;
  String? _selectedWidth;

  // service information
  String? _selectedServiceType;
  String? _selectedServiceLevel;

  // sender information
  String? _selectedSenderFirstName;
  String? _selectedSenderLastName;
  String? _selectedSenderEmailAddress;
  String? _selectedSenderPhoneNumber;
  String? _selectedSenderCompany;
  String? _selectedSenderAddressLineOne;
  String? _selectedSenderAddressLineTwo;
  String? _selectedSenderAddressLineThree;
  String? _selectedSenderPostalCode;
  String? _selectedSenderCity;
  String? _selectedSenderCountry;
  String? _selectedSenderLongitude;
  String? _selectedSenderLatitude;
  String? _selectedSenderAddressType;

  // receiver information
  String? _selectedReceiverFirstName;
  String? _selectedReceiverLastName;
  String? _selectedReceiverEmailAddress;
  String? _selectedReceiverPhoneNumber;
  String? _selectedReceiverCompany;
  String? _selectedReceiverAddressLineOne;
  String? _selectedReceiverAddressLineTwo;
  String? _selectedReceiverAddressLineThree;
  String? _selectedReceiverPostalCode;
  String? _selectedReceiverCity;
  String? _selectedReceiverCountry;
  String? _selectedReceiverLongitude;
  String? _selectedReceiverLatitude;
  String? _selectedReceiverAddressType;

  // notes information
  String? _selectedPickupNote;
  String? _selectedDeliveryNoteMerchant;
  String? _selectedDeliveryNoteReceiver;
  String? _selectedProductNote;
  String? _selectedOtherNotes;

  // other information
  String? _selectedisDangerousGoods;
  String? _selectedallowWeekendDelivery;
  String? _selectedrequestedDeliveryTimeSlotType;
  String? _selectedrequestedDeliveryTimeSlotStartTime;
  String? _selectedrequestedDeliveryTimeSlotEndTime;
  String? _selectedcashOnDeliveryRequested;
  String? _selectedcashOnDeliveryAmount;
  String? _selectedcashOnDeliveryCurrency;
  String? _selectedinsuredAmount;
  String? _selectedinsuredCurrency;

  @override
  void initState() {
    _pageController = PageController(initialPage: currentPage);
    orderBloc = context.read<OrderBloc>();

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 402.w,
      child: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          return ExpandablePageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (value) {
              setState(() {
                currentPage = value;
              });
            },
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 32.w,
                  vertical: 24.h,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Excel sheet upload",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    DropzoneWidget(
                      onDroppedFile: (file) =>
                          setState(() => this._droppedFile = file),
                    ),
                    SizedBox(height: 32.h),
                    RowOfTwoChildren(
                      child1: Button(
                        text: "Close",
                        primary: kWhite,
                        hasBorder: true,
                        textColor: kText1Color,
                        elevation: 0,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      child2: Button(
                        text: "Upload",
                        primary: kPrimaryColor,
                        hasBorder: false,
                        textColor: kWhite,
                        isLoading:
                            state.getMappingStatus == GetMappingStatus.loading,
                        elevation: 0,
                        // onPressed: () {
                        //   _pageController.nextPage(
                        //     duration: const Duration(
                        //       milliseconds: 250,
                        //     ),
                        //     curve: Curves.decelerate,
                        //   );
                        // },
                        onPressed: () => uploadOrder(),
                      ),
                    ),
                  ],
                ),
              ),
              if (state.createMultipleOrderStatus ==
                  CreateMultipleOrderStatus.idle)
                ...[]
              else if (state.createMultipleOrderStatus ==
                  CreateMultipleOrderStatus.loading) ...[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 100.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/upload-cloud.svg',
                        width: 75.w,
                        height: 75.w,
                      ),
                      SizedBox(
                        height: 48.h,
                      ),
                      Text(
                        'Uploading file, Please wait...',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ],
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(28.w, 24.h, 28.w, 16.h),
                    child: Column(
                      children: [
                        Text(
                          'Create task template',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          'Match the columns in your file to the identical task attributes',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: kGrey1Color,
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        TextButton(
                          onPressed: autoFillButton,
                          child: Text("Auto fill"),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    height: 0.7.sh,
                    child: SingleChildScrollView(
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // order details
                          ...[
                            Text(
                              'Order details',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Order number',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedOrderNumber,
                                onChanged: (String? v) {
                                  setState(() => _selectedOrderNumber = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Description',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedDescription,
                                onChanged: (String? v) {
                                  setState(() => _selectedDescription = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Quantity',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedQuantity,
                                onChanged: (String? v) {
                                  setState(() => _selectedQuantity = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Weight',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedWeight,
                                onChanged: (String? v) {
                                  setState(() => _selectedWeight = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Currency',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedCurrency,
                                onChanged: (String? v) {
                                  setState(() => _selectedCurrency = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Dimension Unit',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedDimensionUnit,
                                onChanged: (String? v) {
                                  setState(() => _selectedDimensionUnit = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Height',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedHeight,
                                onChanged: (String? v) {
                                  setState(() => _selectedHeight = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Length',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedLength,
                                onChanged: (String? v) {
                                  setState(() => _selectedLength = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Name',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedName,
                                onChanged: (String? v) {
                                  setState(() => _selectedName = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Price',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedPrice,
                                onChanged: (String? v) {
                                  setState(() => _selectedPrice = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Type',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedType,
                                onChanged: (String? v) {
                                  setState(() => _selectedType = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Weight Unit',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedWeightUnit,
                                onChanged: (String? v) {
                                  setState(() => _selectedWeightUnit = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Width',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedWidth,
                                onChanged: (String? v) {
                                  setState(() => _selectedWidth = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                          ],
                          SizedBox(height: 24.h),
                          // sender details
                          ...[
                            Text(
                              'Sender details',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Sender firstname',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedSenderFirstName,
                                onChanged: (String? v) {
                                  setState(() => _selectedSenderFirstName = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Sender lastname',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedSenderLastName,
                                onChanged: (String? v) {
                                  setState(() => _selectedSenderLastName = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Sender email address',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedSenderEmailAddress,
                                onChanged: (String? v) {
                                  setState(
                                      () => _selectedSenderEmailAddress = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Sender Phone Number',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedSenderPhoneNumber,
                                onChanged: (String? v) {
                                  setState(
                                      () => _selectedSenderPhoneNumber = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Sender company',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedSenderCompany,
                                onChanged: (String? v) {
                                  setState(() => _selectedSenderCompany = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Sender address line 1',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedSenderAddressLineOne,
                                onChanged: (String? v) {
                                  setState(
                                      () => _selectedSenderAddressLineOne = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Sender address line 2',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedSenderAddressLineTwo,
                                onChanged: (String? v) {
                                  setState(
                                      () => _selectedSenderAddressLineTwo = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Sender address line 3',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedSenderAddressLineThree,
                                onChanged: (String? v) {
                                  setState(() =>
                                      _selectedSenderAddressLineThree = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Sender Postal Code',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedSenderPostalCode,
                                onChanged: (String? v) {
                                  setState(() => _selectedSenderPostalCode = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Sender city',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedSenderCity,
                                onChanged: (String? v) {
                                  setState(() => _selectedSenderCity = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Sender country',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedSenderCountry,
                                onChanged: (String? v) {
                                  setState(() => _selectedSenderCountry = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Sender longitude',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedSenderLongitude,
                                onChanged: (String? v) {
                                  setState(() => _selectedSenderLongitude = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Sender latitude',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedSenderLatitude,
                                onChanged: (String? v) {
                                  setState(() => _selectedSenderLatitude = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Sender address type',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedSenderAddressType,
                                onChanged: (String? v) {
                                  setState(
                                      () => _selectedSenderAddressType = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                          ],
                          SizedBox(height: 24.h),
                          // receiver details
                          ...[
                            Text(
                              'Receiver details',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Receiver firstname',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedReceiverFirstName,
                                onChanged: (String? v) {
                                  setState(
                                      () => _selectedReceiverFirstName = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Receiver lastname',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedReceiverLastName,
                                onChanged: (String? v) {
                                  setState(() => _selectedReceiverLastName = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Receiver Email address',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedReceiverEmailAddress,
                                onChanged: (String? v) {
                                  setState(
                                      () => _selectedReceiverEmailAddress = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Receiver Phone Number',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedReceiverPhoneNumber,
                                onChanged: (String? v) {
                                  setState(
                                      () => _selectedReceiverPhoneNumber = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Receiver company',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedReceiverCompany,
                                onChanged: (String? v) {
                                  setState(() => _selectedReceiverCompany = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Receiver address line 1',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedReceiverAddressLineOne,
                                onChanged: (String? v) {
                                  setState(() =>
                                      _selectedReceiverAddressLineOne = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Receiver address line 2',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedReceiverAddressLineTwo,
                                onChanged: (String? v) {
                                  setState(() =>
                                      _selectedReceiverAddressLineTwo = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Receiver address line 3',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedReceiverAddressLineThree,
                                onChanged: (String? v) {
                                  setState(() =>
                                      _selectedReceiverAddressLineThree = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Receiver Postal Code',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedReceiverPostalCode,
                                onChanged: (String? v) {
                                  setState(
                                      () => _selectedReceiverPostalCode = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Receiver city',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedReceiverCity,
                                onChanged: (String? v) {
                                  setState(() => _selectedReceiverCity = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Receiver country',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedReceiverCountry,
                                onChanged: (String? v) {
                                  setState(() => _selectedReceiverCountry = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Receiver longitude',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedReceiverLongitude,
                                onChanged: (String? v) {
                                  setState(
                                      () => _selectedReceiverLongitude = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Receiver latitude',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedReceiverLatitude,
                                onChanged: (String? v) {
                                  setState(() => _selectedReceiverLatitude = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Receiver address type',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedReceiverAddressType,
                                onChanged: (String? v) {
                                  setState(
                                      () => _selectedReceiverAddressType = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                          ],
                          SizedBox(height: 24.h),
                          // other details
                          ...[
                            Text(
                              'Other details',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Service type',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedServiceType,
                                onChanged: (String? v) {
                                  setState(() => _selectedServiceType = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 16.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Service level',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedServiceLevel,
                                onChanged: (String? v) {
                                  setState(() => _selectedServiceLevel = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 16.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Is Dangerous Goods',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedisDangerousGoods,
                                onChanged: (String? v) {
                                  setState(() => _selectedisDangerousGoods = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Allow weekend delivery',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedallowWeekendDelivery,
                                onChanged: (String? v) {
                                  setState(
                                      () => _selectedallowWeekendDelivery = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Requested Delivery Time Slot Type',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedrequestedDeliveryTimeSlotType,
                                onChanged: (String? v) {
                                  setState(() =>
                                      _selectedrequestedDeliveryTimeSlotType =
                                          v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Requested Delivery Time Slot Start',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value:
                                    _selectedrequestedDeliveryTimeSlotStartTime,
                                onChanged: (String? v) {
                                  setState(() =>
                                      _selectedrequestedDeliveryTimeSlotStartTime =
                                          v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Requested Delivery Time Slot End',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value:
                                    _selectedrequestedDeliveryTimeSlotEndTime,
                                onChanged: (String? v) {
                                  setState(() =>
                                      _selectedrequestedDeliveryTimeSlotEndTime =
                                          v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Cash on Delivery Requested',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedcashOnDeliveryRequested,
                                onChanged: (String? v) {
                                  setState(() =>
                                      _selectedcashOnDeliveryRequested = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Cash on Delivery Amount',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedcashOnDeliveryAmount,
                                onChanged: (String? v) {
                                  setState(
                                      () => _selectedcashOnDeliveryAmount = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Cash on Delivery Currency',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedcashOnDeliveryCurrency,
                                onChanged: (String? v) {
                                  setState(() =>
                                      _selectedcashOnDeliveryCurrency = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Insured Amount',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedinsuredAmount,
                                onChanged: (String? v) {
                                  setState(() => _selectedinsuredAmount = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            RowOfTwoChildren(
                              flex2: 2,
                              child1: Text(
                                'Insured Currency',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              child2: DropdownButton<String>(
                                isExpanded: true,
                                value: _selectedinsuredCurrency,
                                onChanged: (String? v) {
                                  setState(() => _selectedinsuredCurrency = v);
                                },
                                items: orderBloc.state.mappingResponse?.headers
                                        ?.map((e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 18.h,
                      horizontal: 32.w,
                    ),
                    child: RowOfTwoChildren(
                      child1: Button(
                        text: "Close",
                        primary: kWhite,
                        hasBorder: true,
                        textColor: kText1Color,
                        elevation: 0,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      child2: Button(
                        text: "Upload",
                        primary: kPrimaryColor,
                        hasBorder: false,
                        textColor: kWhite,
                        isLoading: state.createMultipleOrderStatus ==
                            CreateMultipleOrderStatus.loading,
                        elevation: 0,
                        // onPressed: () {
                        //   // _pageController.nextPage(
                        //   //   duration: const Duration(
                        //   //     milliseconds: 250,
                        //   //   ),
                        //   //   curve: Curves.decelerate,
                        //   // );
                        // },
                        onPressed: () =>
                            uploadMultipleOrders(state.mappingResponse?.id),
                      ),
                    ),
                  ),
                ],
              ),
              ResponseDialog(
                type: DialogType.SUCCESS,
                message: 'Order uploaded successfully',
                onClose: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  autoFillButton() {
    setState(() {
      orderBloc.state.mappingResponse?.headers?.forEach((e) {
        switch (e) {
          case "Service Type":
            _selectedServiceType = e;
            break;
          case "Service Level":
            _selectedServiceLevel = e;
            break;
          case "Sender's first name":
            _selectedSenderFirstName = e;
            break;
          case "Sender's last name":
            _selectedSenderLastName = e;
            break;
          case "Sender's phone number":
            _selectedSenderPhoneNumber = e;
            break;
          case "Sender's email address":
            _selectedSenderEmailAddress = e;
            break;
          case "Sender's company":
            _selectedSenderCompany = e;
            break;
          case "Sender's address line 1":
            _selectedSenderAddressLineOne = e;
            break;
          case "Sender's address line 2":
            _selectedSenderAddressLineTwo = e;
            break;
          case "Sender's address line 3":
            _selectedSenderAddressLineThree = e;
            break;
          case "Sender's postal code":
            _selectedSenderPostalCode = e;
            break;
          case "Sender's city":
            _selectedSenderCity = e;
            break;
          case "Sender's country":
            _selectedSenderCountry = e;
            break;
          case "Sender's longitute":
            _selectedSenderLongitude = e;
            break;
          case "Sender's latititude":
            _selectedSenderLatitude = e;
            break;
          case "Sender's address type":
            _selectedSenderAddressType = e;
            break;
          case "Pick up notes":
            _selectedPickupNote = e;
            break;
          case "Receiver's first name":
            _selectedReceiverFirstName = e;
            break;
          case "Receiver's last name":
            _selectedReceiverLastName = e;
            break;
          case "Receiver's phone number":
            _selectedReceiverPhoneNumber = e;
            break;
          case "Receiver's email address":
            _selectedReceiverEmailAddress = e;
            break;
          case "Receiver's company":
            _selectedReceiverCompany = e;
            break;
          case "Receiver's address line 1":
            _selectedReceiverAddressLineOne = e;
            break;
          case "Receiver's address line 2":
            _selectedReceiverAddressLineTwo = e;
            break;
          case "Receiver's address line 3":
            _selectedReceiverAddressLineThree = e;
            break;
          case "Receiver's postal code":
            _selectedReceiverPostalCode = e;
            break;
          case "Receiver's city":
            _selectedReceiverCity = e;
            break;
          case "Receiver's country":
            _selectedReceiverCountry = e;
            break;
          case "Receiver's longitute":
            _selectedReceiverLongitude = e;
            break;
          case "Receiver's latititude":
            _selectedReceiverLatitude = e;
            break;
          case "Receiver's address type":
            _selectedReceiverAddressType = e;
            break;
          case "Delivery notes from merchant":
            _selectedDeliveryNoteMerchant = e;
            break;
          case "Delivery notes from receiver":
            _selectedDeliveryNoteReceiver = e;
            break;
          case "Merchant order number":
            _selectedOrderNumber = e;
            break;
          case "Other notes":
            _selectedOtherNotes = e;
            break;
          case "Product name":
            _selectedName = e;
            break;
          case "Product description":
            _selectedDescription = e;
            break;
          case "Product Quantity":
            _selectedQuantity = e;
            break;
          case "Product price":
            _selectedPrice = e;
            break;
          case "Product currency":
            _selectedCurrency = e;
            break;
          case "Product height":
            _selectedHeight = e;
            break;
          case "Product width":
            _selectedWidth = e;
            break;
          case "Product length":
            _selectedLength = e;
            break;
          case "Product dimensions unit":
            _selectedDimensionUnit = e;
            break;
          case "Product weight":
            _selectedWeight = e;
            break;
          case "Product weight unit":
            _selectedWeightUnit = e;
            break;
          case "Product is a dangerous good":
            _selectedisDangerousGoods = e;
            break;
          case "Product type":
            _selectedType = e;
            break;
          case "Product notes":
            _selectedProductNote = e;
            break;
          case "Allow weekend delivery":
            _selectedallowWeekendDelivery = e;
            break;
          case "Requested delivery time slot type":
            _selectedrequestedDeliveryTimeSlotType = e;
            break;
          case "Requested delivery time slot start time":
            _selectedrequestedDeliveryTimeSlotStartTime = e;
            break;
          case "Requested delivery time slot end time":
            _selectedrequestedDeliveryTimeSlotEndTime = e;
            break;
          case "Cash on delivery requested":
            _selectedcashOnDeliveryRequested = e;
            break;
          case "Cash on delivery amount ":
            _selectedcashOnDeliveryAmount = e;
            break;
          case "Cash on delivery currency":
            _selectedcashOnDeliveryCurrency = e;
            break;
          case "Insured amount":
            _selectedinsuredAmount = e;
            break;
          case "Insured currency":
            _selectedinsuredCurrency = e;
            break;
          default:
            break;
        }
      });
    });
  }

  uploadOrder() async {
    GetMapping mapping = GetMapping(
      excelBase64String: _droppedFile!.base64String,
    );
    await orderBloc.getMapping(mapping);
    if (orderBloc.state.getMappingStatus == GetMappingStatus.success) {
      _pageController.nextPage(
        duration: const Duration(
          milliseconds: 250,
        ),
        curve: Curves.decelerate,
      );
    } else {
      print('aaa');
    }
  }

  uploadMultipleOrders(String? mappingId) async {
    // order information
    KeyBoolPair _orderNumber =
        KeyBoolPair(isRequired: true, key: _selectedOrderNumber);
    KeyBoolPair _description =
        KeyBoolPair(isRequired: false, key: _selectedDescription);
    KeyBoolPair _quantity =
        KeyBoolPair(isRequired: false, key: _selectedQuantity);
    KeyBoolPair _weight = KeyBoolPair(isRequired: false, key: _selectedWeight);
    KeyBoolPair _currency =
        KeyBoolPair(isRequired: false, key: _selectedCurrency);
    KeyBoolPair _dimensionUnit =
        KeyBoolPair(isRequired: false, key: _selectedDimensionUnit);
    KeyBoolPair _height = KeyBoolPair(isRequired: false, key: _selectedHeight);
    KeyBoolPair _length = KeyBoolPair(isRequired: false, key: _selectedLength);
    KeyBoolPair _name = KeyBoolPair(isRequired: false, key: _selectedName);
    KeyBoolPair _price = KeyBoolPair(isRequired: false, key: _selectedPrice);
    KeyBoolPair _type = KeyBoolPair(isRequired: false, key: _selectedType);
    KeyBoolPair _weightUnit =
        KeyBoolPair(isRequired: false, key: _selectedWeightUnit);
    KeyBoolPair _width = KeyBoolPair(isRequired: false, key: _selectedWidth);

    // service information
    KeyBoolPair _serviceType =
        KeyBoolPair(isRequired: true, key: _selectedServiceType);
    KeyBoolPair _serviceLevel =
        KeyBoolPair(isRequired: true, key: _selectedServiceLevel);

    // sender information
    KeyBoolPair _senderFirstName =
        KeyBoolPair(isRequired: true, key: _selectedSenderFirstName);
    KeyBoolPair _senderLastName =
        KeyBoolPair(isRequired: false, key: _selectedSenderLastName);
    KeyBoolPair _senderEmailAddress =
        KeyBoolPair(isRequired: false, key: _selectedSenderEmailAddress);
    KeyBoolPair _senderPhoneNumber =
        KeyBoolPair(isRequired: true, key: _selectedSenderPhoneNumber);
    KeyBoolPair _senderCompany =
        KeyBoolPair(isRequired: false, key: _selectedSenderCompany);
    KeyBoolPair _senderAddress1 =
        KeyBoolPair(isRequired: true, key: _selectedSenderAddressLineOne);
    KeyBoolPair _senderAddress2 =
        KeyBoolPair(isRequired: false, key: _selectedSenderAddressLineTwo);
    KeyBoolPair _senderAddress3 =
        KeyBoolPair(isRequired: false, key: _selectedSenderAddressLineThree);
    KeyBoolPair _senderPostalCode =
        KeyBoolPair(isRequired: true, key: _selectedSenderPostalCode);
    KeyBoolPair _senderCity =
        KeyBoolPair(isRequired: true, key: _selectedSenderCity);
    KeyBoolPair _senderCountry =
        KeyBoolPair(isRequired: true, key: _selectedSenderCountry);
    KeyBoolPair _senderLongitude =
        KeyBoolPair(isRequired: false, key: _selectedSenderLongitude);
    KeyBoolPair _senderLatitude =
        KeyBoolPair(isRequired: false, key: _selectedSenderLatitude);
    KeyBoolPair _senderAddressType =
        KeyBoolPair(isRequired: false, key: _selectedSenderAddressType);

    // Receiver information
    KeyBoolPair _receiverFirstName =
        KeyBoolPair(isRequired: true, key: _selectedReceiverFirstName);
    KeyBoolPair _receiverLastName =
        KeyBoolPair(isRequired: false, key: _selectedReceiverLastName);
    KeyBoolPair _receiverEmailAddress =
        KeyBoolPair(isRequired: false, key: _selectedReceiverEmailAddress);
    KeyBoolPair _receiverPhoneNumber =
        KeyBoolPair(isRequired: true, key: _selectedReceiverPhoneNumber);
    KeyBoolPair _receiverCompany =
        KeyBoolPair(isRequired: false, key: _selectedReceiverCompany);
    KeyBoolPair _receiverAddress1 =
        KeyBoolPair(isRequired: true, key: _selectedReceiverAddressLineOne);
    KeyBoolPair _receiverAddress2 =
        KeyBoolPair(isRequired: false, key: _selectedReceiverAddressLineTwo);
    KeyBoolPair _receiverAddress3 =
        KeyBoolPair(isRequired: false, key: _selectedReceiverAddressLineThree);
    KeyBoolPair _receiverPostalCode =
        KeyBoolPair(isRequired: true, key: _selectedReceiverPostalCode);
    KeyBoolPair _receiverCity =
        KeyBoolPair(isRequired: true, key: _selectedReceiverCity);
    KeyBoolPair _receiverCountry =
        KeyBoolPair(isRequired: true, key: _selectedReceiverCountry);
    KeyBoolPair _receiverLongitude =
        KeyBoolPair(isRequired: false, key: _selectedReceiverLongitude);
    KeyBoolPair _receiverLatitude =
        KeyBoolPair(isRequired: false, key: _selectedReceiverLatitude);
    KeyBoolPair _receiverAddressType =
        KeyBoolPair(isRequired: false, key: _selectedReceiverAddressType);

    // notes and other information
    KeyBoolPair _pickupNote =
        KeyBoolPair(isRequired: false, key: _selectedPickupNote);
    KeyBoolPair _deliveryNoteMerchant =
        KeyBoolPair(isRequired: false, key: _selectedDeliveryNoteMerchant);
    KeyBoolPair _deliveryNoteReceiver =
        KeyBoolPair(isRequired: false, key: _selectedDeliveryNoteReceiver);
    KeyBoolPair _productNote =
        KeyBoolPair(isRequired: false, key: _selectedProductNote);
    KeyBoolPair _otherNotes =
        KeyBoolPair(isRequired: false, key: _selectedOtherNotes);
    KeyBoolPair _isDangerousGoods = KeyBoolPair(
      isRequired: false,
      key: _selectedisDangerousGoods,
    );
    KeyBoolPair _allowWeekendDelivery = KeyBoolPair(
      isRequired: false,
      key: _selectedallowWeekendDelivery,
    );
    KeyBoolPair _requestedDeliveryTimeSlotType = KeyBoolPair(
        isRequired: false, key: _selectedrequestedDeliveryTimeSlotType);

    KeyBoolPair _requestedDeliveryTimeSlotStart = KeyBoolPair(
        isRequired: false, key: _selectedrequestedDeliveryTimeSlotStartTime);

    KeyBoolPair _requestedDeliveryTimeSlotEnd = KeyBoolPair(
        isRequired: false, key: _selectedrequestedDeliveryTimeSlotEndTime);

    KeyBoolPair _codRequested =
        KeyBoolPair(isRequired: false, key: _selectedcashOnDeliveryRequested);

    KeyBoolPair _codAmount =
        KeyBoolPair(isRequired: false, key: _selectedcashOnDeliveryAmount);

    KeyBoolPair _codCurrency =
        KeyBoolPair(isRequired: false, key: _selectedcashOnDeliveryCurrency);

    KeyBoolPair _insuredAmount =
        KeyBoolPair(isRequired: false, key: _selectedinsuredAmount);

    KeyBoolPair _insuredCurrency =
        KeyBoolPair(isRequired: false, key: _selectedinsuredCurrency);

    OrderDetails orderInformation = OrderDetails(
      orderNumber: _orderNumber,
      description: _description,
      weight: _weight,
      quantity: _quantity,
      currency: _currency,
      dimensionUnit: _dimensionUnit,
      height: _height,
      length: _length,
      name: _name,
      price: _price,
      type: _type,
      weightUnit: _weightUnit,
      width: _width,
    );

    ServiceInformationMap serviceInformation = ServiceInformationMap(
      type: _serviceType,
      level: _serviceLevel,
    );

    DataMap senderInformation = DataMap(
      firstName: _senderFirstName,
      lastName: _senderLastName,
      emailAddress: _senderEmailAddress,
      phoneNumber: _senderPhoneNumber,
      company: _senderCompany,
      addressLineOne: _senderAddress1,
      addressLineTwo: _senderAddress2,
      addressLineThree: _senderAddress3,
      postalCode: _senderPostalCode,
      city: _senderCity,
      country: _senderCountry,
      longitude: _senderLongitude,
      latitude: _senderLatitude,
      addressType: _senderAddressType,
    );

    DataMap receiverInformation = DataMap(
      firstName: _receiverFirstName,
      lastName: _receiverLastName,
      emailAddress: _receiverEmailAddress,
      phoneNumber: _receiverPhoneNumber,
      company: _receiverCompany,
      addressLineOne: _receiverAddress1,
      addressLineTwo: _receiverAddress2,
      addressLineThree: _receiverAddress3,
      postalCode: _receiverPostalCode,
      city: _receiverCity,
      country: _receiverCountry,
      longitude: _receiverLongitude,
      latitude: _receiverLatitude,
      addressType: _receiverAddressType,
    );

    NoteMap noteInformation = NoteMap(
      pickupNote: _pickupNote,
      deliveryNoteMerchant: _deliveryNoteMerchant,
      deliveryNoteReceiver: _deliveryNoteReceiver,
      productNote: _productNote,
      otherNotes: _otherNotes,
    );

    OtherInformationMap otherInformation = OtherInformationMap(
      isDangerousGoods: _isDangerousGoods,
      allowWeekendDelivery: _allowWeekendDelivery,
      requestedDeliveryTimeSlotType: _requestedDeliveryTimeSlotType,
      requestedDeliveryTimeSlotStartTime: _requestedDeliveryTimeSlotStart,
      requestedDeliveryTimeSlotEndTime: _requestedDeliveryTimeSlotEnd,
      cashOnDeliveryRequested: _codRequested,
      cashOnDeliveryAmount: _codAmount,
      cashOnDeliveryCurrency: _codCurrency,
      insuredAmount: _insuredAmount,
      insuredCurrency: _insuredCurrency,
    );

    Mapping mapping = Mapping(
      orderInformation: orderInformation,
      receiverInformation: receiverInformation,
      senderInformation: senderInformation,
      notes: noteInformation,
      otherInformation: otherInformation,
      serviceInformation: serviceInformation,
    );

    FilledMappingRequest data = FilledMappingRequest(
      id: mappingId,
      // merchantId: AppService.currentUser.value?.merchant?.id,
      mapping: mapping,
    );

    await orderBloc.createMultipleOrders(data);

    if (orderBloc.state.createMultipleOrderStatus ==
        CreateMultipleOrderStatus.success) {
      _pageController.nextPage(
        duration: const Duration(
          milliseconds: 250,
        ),
        curve: Curves.decelerate,
      );
    }
  }
}
