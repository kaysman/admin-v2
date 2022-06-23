import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lng_adminapp/data/models/meta.model.dart';
import 'package:lng_adminapp/data/models/pickup/approve-pickup-request.model.dart';
import 'package:lng_adminapp/data/models/pickup/pickup-time-breakdown.model.dart';
import 'package:lng_adminapp/data/models/pickup/pickup.model.dart';
import 'package:lng_adminapp/data/models/user.model.dart';
import 'package:lng_adminapp/presentation/screens/drivers/drivers.bloc.dart';
import 'package:lng_adminapp/presentation/screens/orders/manage_order_table/manage_order.table.dart';
import 'package:lng_adminapp/presentation/screens/pickups/pickup.bloc.dart';
import 'package:lng_adminapp/presentation/screens/pickups/request-pickup/request-pickup.view.dart';
import 'package:lng_adminapp/presentation/shared/components/search_icon.dart';
import 'package:lng_adminapp/shared.dart';
import 'package:flutter_svg/svg.dart';

class ManagePickups extends StatelessWidget {
  static const String routeName = "manage-pickups";
  ManagePickups({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _PickupAccepting();
  }
}

class _PickupAccepting extends StatefulWidget {
  const _PickupAccepting({Key? key}) : super(key: key);

  @override
  State<_PickupAccepting> createState() => _PickupAcceptingState();
}

class _PickupAcceptingState extends State<_PickupAccepting> {
  int sortColumnIndex = 0;
  bool sortAscending = true;
  final _pageViewController = PageController();
  var _nextButtonText = ValueNotifier('Next');
  final TextEditingController _pickupDateController =
      TextEditingController(text: todayDate());
  GlobalKey<FormState> _requestPickupFormKey = GlobalKey<FormState>();

  String? _pickupTime;
  String? _closeTime;
  String? daysFilter;
  String? viewType;
  String? perPage;
  String? _driver;

  int _currentPage = 0;
  List<String> showTypes = [
    'ALL',
    'PENDING',
    'REQUESTED',
    'ASSIGNED',
    'APPROVED',
    'COMPLETED',
    'REJECTED'
  ];

  List<String> pickupRequestColumnNames = [
    "Merchant name",
    "Pickup start date",
    "Pickup end date",
    "Warehouse",
    "Status",
  ];
  int selectedIndex = 0;
  late PickupBloc pickupBloc;
  late DriverBloc driverBloc;
  List<User>? drivers;

  @override
  void initState() {
    pickupBloc = context.read<PickupBloc>();
    driverBloc = context.read<DriverBloc>();

    // revise this later TODO:
    drivers = driverBloc.state.driverItems;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kGrey5Color,
      padding: const EdgeInsets.fromLTRB(21, 32, 21, 0),
      child: BlocBuilder<PickupBloc, PickupState>(
        bloc: pickupBloc,
        builder: (context, pickupState) {
          var _pickupStatus = pickupState.pickupStatus;
          var _pickups = pickupState.pickupItems;
          var _meta = pickupState.pickups?.meta;

          if (_pickupStatus == PickupStatus.loading)
            return const Center(child: CircularProgressIndicator());

          if (_pickupStatus == PickupStatus.error)
            return TryAgainButton(
              tryAgain: () async {
                await pickupBloc.loadPickupRequests();
              },
            );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 34,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    Text(
                      "Pickup requests",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Spacings.SMALL_HORIZONTAL,
                    SizedBox(
                      width: 260,
                      child: TextField(
                        style: Theme.of(context).textTheme.headline5,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: const BorderSide(
                              color: kWhite,
                              width: 0.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: const BorderSide(
                              color: kWhite,
                              width: 0.0,
                            ),
                          ),
                          hintText: 'Search',
                          hintStyle:
                              Theme.of(context).textTheme.headline5?.copyWith(
                                    color: kGrey1Color,
                                  ),
                          prefixIcon: SearchIcon(),
                        ),
                      ),
                    ),
                    Spacings.SMALL_HORIZONTAL,
                    SizedBox(
                      width: 160,
                      child: DecoratedDropdown<String>(
                        value: daysFilter,
                        icon: AppIcons.svgAsset(AppIcons.calendar),
                        items: ['Past 1 day', 'Past 1 week', 'Past 1 month'],
                        onChanged: (v) {
                          setState(() => daysFilter = v);
                        },
                      ),
                    ),
                    Spacer(),
                    Spacings.SMALL_HORIZONTAL,
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(6),
                    //     ),
                    //   ),
                    //   child: Text(
                    //     "Accept pickup",
                    //     style: Theme.of(context)
                    //         .textTheme
                    //         .bodyText2
                    //         ?.copyWith(color: kWhite),
                    //   ),
                    //   onPressed: () {},
                    // ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                      child: Text(
                        "Request pickup",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(color: kWhite),
                      ),
                      onPressed: () =>
                          Navigator.pushNamed(context, RequestPickup.routeName),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 24),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            ...showTypes.map(
                              (e) {
                                final selected =
                                    selectedIndex == showTypes.indexOf(e);
                                return InkWell(
                                  onTap: () {
                                    if (!selected) {
                                      setState(() {
                                        selectedIndex = showTypes.indexOf(e);
                                        changeList(
                                          pickupBloc.state.pickups!,
                                          showTypes[showTypes.indexOf(e)],
                                        );
                                      });
                                    }
                                  },
                                  child: Card(
                                    elevation: 0,
                                    margin: EdgeInsets.zero,
                                    color: selected ? kSecondaryColor : kWhite,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 9,
                                      ),
                                      child: Text(
                                        '$e (${getRequestCountByStatus(showTypes[showTypes.indexOf(e)], pickupState.pickups!.items)})',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.copyWith(
                                              color: selected
                                                  ? kPrimaryColor
                                                  : kText1Color,
                                            ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 0,
                        indent: 0,
                        endIndent: 0,
                        color: kGrey3Color,
                        thickness: 1,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(32, 8, 32, 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${_pickups?.length} pickup requests",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  Spacer(),
                                  Text(
                                    'Results per page',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  Spacings.SMALL_HORIZONTAL,
                                  SizedBox(
                                    width: 85,
                                    child: DecoratedDropdown<String>(
                                      value: pickupState.perPage,
                                      icon: null,
                                      items: ['10', '20', '50'],
                                      onChanged: (v) {
                                        if (v != null) {
                                          context
                                              .read<PickupBloc>()
                                              .setPerPageAndLoad(v);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Expanded(
                                child: ScrollableWidget(
                                  child: DataTable(
                                    border: TableBorder.all(
                                      width: 1.0,
                                      color: Colors.grey.shade100,
                                    ),
                                    onSelectAll: (value) {},
                                    sortColumnIndex: this.sortColumnIndex,
                                    sortAscending: this.sortAscending,
                                    columns: this.tableColumns,
                                    rows: this.tableRows,
                                  ),
                                ),
                              ),
                              Pagination(
                                metaData: _meta,
                                goPrevious: () => loadPrevious(_meta),
                                goNext: () => loadNext(_meta),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  get tableColumns {
    return List.generate(pickupRequestColumnNames.length, (index) {
      var name = pickupRequestColumnNames[index];
      return DataColumn(
        label: Text(name),
        onSort: (i, b) {},
      );
    });
  }

  get tableRows {
    List<Pickup>? pickups = pickupBloc.state.pickupItems;
    return List.generate(pickups!.length, (index) {
      var pickup = pickups[index];
      return DataRow(
        color: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return kPrimaryColor.withOpacity(0.08);
          }
          if (states.contains(MaterialState.hovered)) {
            return kGrey5Color;
          }
          return null;
        }),
        // onSelectChanged: (v) {
        //   showDialog(
        //     barrierDismissible: false,
        //     context: context,
        //     barrierColor: kGrey4Color.withOpacity(0.1),
        //     builder: (context) {
        //       return Dialog(
        //         backgroundColor: Colors.transparent,
        //         insetPadding: EdgeInsets.zero,
        //         clipBehavior: Clip.hardEdge,
        //         child: PickupAcceptingDialog(),
        //       );
        //     },
        //   );
        // },
        cells: <DataCell>[
          DataCell(
            Text("${pickup.merchant?.companyName}"),
            onTap: () => showAssignDriverDialog(pickup, pickupBloc, context),
          ),
          DataCell(Text("${pickup.pickupTimeWindowStart}")),
          DataCell(Text("${pickup.pickupTimeWindowEnd}")),
          DataCell(Text("${pickup.merchant?.address?.addressLineOne}")),
          DataCell(Text("${pickup.status}")),
        ],
      );
    });
  }

  loadPrevious(Meta? meta) async {
    var previous = (meta!.currentPage - 1).toString();
    await context.read<PickupBloc>().loadPickupRequests(previous);
  }

  loadNext(Meta? meta) async {
    var next = (meta!.currentPage + 1).toString();
    await context.read<PickupBloc>().loadPickupRequests((next));
  }

  changeList(PickupList data, String? status) async {
    await context.read<PickupBloc>().getPickupBasedOnStatus(data, status);
  }

  int getRequestCountByStatus(String? status, List<Pickup>? data) {
    int count = 0;

    if (status == 'ALL') {
      count = data!.length;
    } else {
      count = data!.where((s) => s.status == status).toList().length;
    }
    return count;
  }

  showAssignDriverDialog(
      Pickup pickup, PickupBloc pickupBloc, BuildContext context) {
    PickupTimeBreakDown _breakDown = timeBreakDown(
      DateTime.now(),
      DateTime.now(),
      // pickup.pickupTimeWindowStart!,
      // pickup.pickupTimeWindowEnd!,
    );
    _pickupDateController.text = _breakDown.date!;
    _pickupTime = _breakDown.pickupTime!;
    _closeTime = _breakDown.closingTime!;
    return showWhiteDialog(
      context,
      BlocConsumer<PickupBloc, PickupState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        listenWhen: (state1, state2) => state1 != state2,
        builder: (context, state) {
          return Container(
            width: 402.w,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        _pageViewController.animateToPage(
                          0,
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.decelerate,
                        );
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset('assets/svg/times.svg'),
                    ),
                    Text(
                      'Assign Drivers',
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(),
                  ],
                ),
                SizedBox(height: 16.h),
                ExpandablePageView(
                  controller: _pageViewController,
                  onPageChanged: (value) {
                    _currentPage = value;
                    if (value == 1) {
                      _nextButtonText.value = 'Submit';
                    } else {
                      _nextButtonText.value = 'Next';
                    }
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    StatefulBuilder(builder: (context, _setState) {
                      return Form(
                          key: _requestPickupFormKey,
                          child: Column(
                            children: [
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
                                    _setState(() {
                                      _pickupTime = v;
                                    });
                                  },
                                  items: [],
                                ),
                                child2: LabeledHourSelectInput(
                                  label: "Closing time",
                                  value: _closeTime,
                                  onSelected: (v) {
                                    _setState(() {
                                      _closeTime = v;
                                    });
                                  },
                                  items: [],
                                ),
                              ),
                            ],
                          ));
                    }),
                    StatefulBuilder(builder: (context, _setState) {
                      return OpenRadioDropdown(
                        items: drivers,
                        value: _driver,
                        onSelected: (v) => _setState(() {
                          _driver = v;
                        }),
                      );
                    }),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    Row(
                      children: [
                        Button(
                          primary: kPrimaryColor,
                          textColor: kWhite,
                          text: "Previous",
                          onPressed: () {
                            _pageViewController.previousPage(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.decelerate,
                            );
                          },
                        ),
                        SizedBox(width: 10.w),
                        ValueListenableBuilder(
                          valueListenable: _nextButtonText,
                          builder:
                              (BuildContext context, String? v, Widget? child) {
                            return Button(
                              primary: kPrimaryColor,
                              textColor: kWhite,
                              isLoading: state.approvePickupRequestStatus ==
                                  ApprovePickupRequestStatus.loading,
                              text: v!,
                              // isDisabled: _currentPage == 1
                              //     ? (_driver == null ? true : false)
                              //     : false,
                              onPressed: () async {
                                if (_currentPage == 1) {
                                  // submit
                                  await submitForm(pickup, pickupBloc, context);
                                } else {
                                  _pageViewController.nextPage(
                                    duration: const Duration(milliseconds: 250),
                                    curve: Curves.decelerate,
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  submitForm(Pickup pickup, PickupBloc pickupBloc, BuildContext context) async {
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
    ApproveRequestModel request = ApproveRequestModel();
    request.driverId = _driver;
    request.requestId = pickup.id;
    request.pickupTimeWindowStart = _startDate;
    request.pickupTimeWindowEnd = _endDate;
    // get the driver id instead of user id
    await pickupBloc.approvePickupRequest(request, context);
  }
}
