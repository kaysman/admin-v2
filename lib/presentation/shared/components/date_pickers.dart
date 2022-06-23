import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/shared.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../data/models/orders/filter_parameters.dart';
import '../../screens/orders/manage_order_table/dialogs/filter_dialog.dart';
import '../../screens/orders/order.bloc.dart';

class GridTimePicker extends StatelessWidget {
  GridTimePicker({
    Key? key,
    required this.child,
    required this.items,
    required this.onSelected,
    this.value,
  }) : super(key: key);

  final Widget child;
  final String? value;
  final List<String> items;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    var first16items = items.sublist(0, 16);
    var second16items = items.sublist(16, 32);
    var last16items = items.sublist(32);

    return StatefulBuilder(builder: (context, state) {
      return PopupMenuButton<String>(
        color: kWhite,
        padding: EdgeInsets.zero,
        child: child,
        itemBuilder: (context) {
          return <PopupMenuItem<String>>[
            PopupMenuItem<String>(
              enabled: false,
              padding: const EdgeInsets.only(left: 8, right: 6),
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: List.generate(3, (index) {
                    var data = index == 0
                        ? first16items
                        : index == 1
                            ? second16items
                            : last16items;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: data.map((x) {
                        return SizedBox(
                          width: 87,
                          child: Row(
                            children: [
                              Radio(
                                value: x == this.value,
                                groupValue: true,
                                onChanged: (v) {
                                  state(() => onSelected(x));
                                  Navigator.of(context).pop();
                                },
                              ),
                              Text(
                                x,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  }),
                ),
              ),
            ),
          ];
        },
      );
    });
  }
}

class DateFilter extends StatefulWidget {
  const DateFilter({
    Key? key,
    required this.child,
    this.dateByValue,
    required this.onSubmit,
  }) : super(key: key);

  final Widget? child;

  /// DATE BY
  final DateRangeType? dateByValue;
  final ValueChanged<DateRangeType?> onSubmit;

  @override
  State<DateFilter> createState() => _DateFilterState();
}

class _DateFilterState extends State<DateFilter> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateRangeType? selectedDaterange;
  DateTime? startDate;
  DateTime? endDate;
  DateFilterType? dateFilterType;
  late OrderBloc orderBloc;

  @override
  void initState() {
    orderBloc = BlocProvider.of<OrderBloc>(context);
    selectedDaterange = widget.dateByValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: PopupMenuButton(
        padding: EdgeInsets.zero,
        color: kWhite,
        child: this.widget.child,
        offset: Offset(0, 8),
        position: PopupMenuPosition.under,
        itemBuilder: (context) {
          return <PopupMenuItem>[
            PopupMenuItem(
              enabled: false,
              padding: EdgeInsets.only(bottom: 8),
              child: StatefulBuilder(builder: (context, setState) {
                return Container(
                  width: 220,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      FilterDateType(setState, context),
                      SizedBox(height: 15),
                      Divider(height: 1, endIndent: 0, indent: 0),
                      dateRangePortion(context, setState),
                      if (selectedDaterange == DateRangeType.custom) ...[
                        Divider(height: 1, endIndent: 0, indent: 0),
                        FilterStartDate(context, setState),
                        FilterEndDate(context, setState),
                      ],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (selectedDaterange != null ||
                              dateFilterType != null) ...[
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  selectedDaterange = null;
                                  dateFilterType = null;
                                });
                              },
                              child: Text("Clear"),
                            ),
                            SizedBox(width: 14),
                          ],
                          BlocBuilder<OrderBloc, OrderState>(
                              builder: (context, state) {
                            return Button(
                              textColor: kWhite,
                              hasBorder: false,
                              primary: kPrimaryColor,
                              text: "Filter",
                              isLoading:
                                  state.orderStatus == OrderStatus.filtering,
                              onPressed: () async {
                                OrderFilterParameters params;
                                switch (selectedDaterange) {
                                  case DateRangeType.custom:
                                    params = OrderFilterParameters(
                                      dateFilterType: dateFilterType,
                                      startDate: startDate,
                                      endDate: endDate,
                                    );
                                    break;
                                  case DateRangeType.today:
                                    params = OrderFilterParameters(
                                      dateFilterType: dateFilterType,
                                      startDate: DateTime.now(),
                                      endDate: DateTime.now(),
                                    );
                                    break;
                                  case DateRangeType.last90days:
                                    params = OrderFilterParameters(
                                      dateFilterType: dateFilterType,
                                      startDate: DateTime.now()
                                          .subtract(Duration(days: 90)),
                                      endDate: DateTime.now(),
                                    );
                                    break;
                                  case DateRangeType.last30days:
                                    params = OrderFilterParameters(
                                      dateFilterType: dateFilterType,
                                      startDate: DateTime.now()
                                          .subtract(Duration(days: 30)),
                                      endDate: DateTime.now(),
                                    );
                                    break;
                                  case DateRangeType.last7days:
                                    params = OrderFilterParameters(
                                      dateFilterType: dateFilterType,
                                      startDate: DateTime.now()
                                          .subtract(Duration(days: 7)),
                                      endDate: DateTime.now(),
                                    );
                                    break;
                                  case DateRangeType.yesterday:
                                    params = OrderFilterParameters(
                                      dateFilterType: dateFilterType,
                                      startDate: DateTime.now()
                                          .subtract(Duration(days: 1)),
                                      endDate: DateTime.now()
                                          .subtract(Duration(days: 1)),
                                    );
                                    break;
                                  default:
                                    params = OrderFilterParameters();
                                    break;
                                }
                                await orderBloc.loadOrders(
                                    params, false, null, true);
                                if (state.orderStatus == OrderStatus.idle) {
                                  widget.onSubmit(selectedDaterange);
                                }
                              },
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ),
          ];
        },
      ),
    );
  }

  FilterDateType(StateSetter setState, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Date Type", style: Theme.of(context).textTheme.caption),
          SizedBox(height: 10.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                width: 1.0,
                color: kGrey3Color,
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<DateFilterType>(
                value: dateFilterType,
                onChanged: (v) {
                  setState(() => dateFilterType = v);
                },
                borderRadius: BorderRadius.circular(6),
                elevation: 1,
                isExpanded: true,
                items: DateFilterType.values
                    .map((e) => DropdownMenuItem(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Text(e.name,
                                style: Theme.of(context).textTheme.caption),
                          ),
                          value: e,
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  FilterEndDate(
    BuildContext context,
    void Function(void Function()) setState,
  ) {
    return ExpansionTile(
      title: Text(
        "End date",
        style: Theme.of(context).textTheme.headline3,
      ),
      children: [
        InkWell(
          onTap: () async {
            var res = await showDatePicker(
              context: context,
              initialDate: endDate ?? DateTime.now(),
              firstDate: DateTime(2020, 1, 1),
              lastDate: DateTime(DateTime.now().year, DateTime.now().month + 1),
            );
            if (res != null) {
              setState(() {
                endDate = res;
              });
            }
          },
          child: Container(
            width: double.infinity,
            height: 34,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: kGrey5Color,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (endDate != null)
                  Expanded(child: Text(DateHelper.yyyyMMdd(endDate!))),
                AppIcons.svgAsset(AppIcons.calendar),
              ],
            ),
          ),
        ),
        ClearButton(() {
          setState(() {
            endDate = null;
          });
        }),
      ],
    );
  }

  FilterStartDate(
    BuildContext context,
    void Function(void Function()) setState,
  ) {
    return ExpansionTile(
      title: Text(
        "Start date",
        style: Theme.of(context).textTheme.headline3,
      ),
      children: [
        InkWell(
          onTap: () async {
            var res = await showDatePicker(
              context: context,
              initialDate: startDate ?? DateTime.now(),
              firstDate: DateTime(2020, 1, 1),
              lastDate: DateTime(DateTime.now().year, DateTime.now().month + 1),
            );
            if (res != null) {
              setState(() {
                startDate = res;
              });
            }
          },
          child: Container(
            width: double.infinity,
            height: 34,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: kGrey5Color,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (startDate != null)
                  Expanded(child: Text(DateHelper.yyyyMMdd(startDate!))),
                AppIcons.svgAsset(AppIcons.calendar),
              ],
            ),
          ),
        ),
        ClearButton(() {
          setState(() {
            startDate = null;
          });
        }),
      ],
    );
  }

  buildCalendar(BuildContext context) {
    return TableCalendar(
      focusedDay: DateTime.now(),
      firstDay: DateTime(2010, 1, 1),
      lastDay: DateTime(
        DateTime.now().year,
        DateTime.now().month + 1,
      ),
      availableCalendarFormats: {CalendarFormat.month: 'Month'},
      pageJumpingEnabled: true,
      startingDayOfWeek: StartingDayOfWeek.monday,
      rowHeight: 24,
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: Theme.of(context).textTheme.caption!,
        weekendStyle: Theme.of(context)
            .textTheme
            .caption!
            .copyWith(color: Colors.black87),
      ),
      calendarStyle: CalendarStyle(
        cellMargin: EdgeInsets.all(4),
        todayTextStyle: Theme.of(context).textTheme.caption!,
        todayDecoration: BoxDecoration(),
        selectedTextStyle:
            Theme.of(context).textTheme.caption!.copyWith(color: Colors.white),
        selectedDecoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        outsideTextStyle: Theme.of(context).textTheme.caption!,
        disabledTextStyle: Theme.of(context)
            .textTheme
            .caption!
            .copyWith(color: Colors.black45),
        holidayTextStyle: Theme.of(context).textTheme.caption!,
        weekendTextStyle: Theme.of(context)
            .textTheme
            .caption!
            .copyWith(color: Colors.black87),
        defaultTextStyle: Theme.of(context).textTheme.caption!,
      ),
    );
  }

  Widget dateRangePortion(
    BuildContext context,
    void Function(void Function()) setState,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Date Range", style: Theme.of(context).textTheme.caption),
          SizedBox(height: 10.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                width: 1.0,
                color: kGrey3Color,
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<DateRangeType>(
                borderRadius: BorderRadius.circular(6),
                elevation: 1,
                isExpanded: true,
                value: selectedDaterange,
                onChanged: (v) {
                  setState(() {
                    selectedDaterange = v;
                  });
                },
                items: DateRangeType.values.map((e) {
                  return DropdownMenuItem<DateRangeType>(
                    value: e,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        e.text,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
