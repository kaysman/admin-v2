import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../shared.dart';

class Calendar extends StatefulWidget {
  const Calendar(
      {Key? key, required this.selectedDate, required this.onDateSelected})
      : super(key: key);

  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late PageController calendarController;
  PageController yearController = PageController();
  ValueNotifier<int> weekIndex = ValueNotifier(0);

  late DateTime today;
  late int todayMonthOffset;
  late DateTime calendarFocusedDate;

  @override
  void initState() {
    calendarController = PageController();

    today = DateHelper.getDateDay(DateTime.now());
    todayMonthOffset = today.month;

    var monthIndex = getFocusedWeekMonthIndex();
    calendarFocusedDate = getMonthFromIndex(monthIndex);

    super.initState();
  }

  DateTime getMonthFromIndex(index) {
    var monthIndex = determineMonth(index);
    var yearOffset = 0;
    if ((todayMonthOffset - index) % 12 == 0) {
      yearOffset = 1 + ((todayMonthOffset - index) / 12).abs().round();
    } else if (index > todayMonthOffset) {
      yearOffset = ((todayMonthOffset - index) / 12).abs().ceil();
    }
    return DateTime(today.year - yearOffset, monthIndex);
  }

  @override
  void dispose() {
    calendarController.dispose();
    yearController.dispose();
    weekIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // calendar header with previous, next month icon
            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(width: 12.0),
                  Material(
                    color: Colors.white,
                    child: IconButton(
                      onPressed: () {},
                      color: Colors.black,
                      icon: const Icon(
                        Icons.chevron_left,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () => toggleCalendarView(),
                      child: Text(
                        DateFormat.MMMM().format(calendarFocusedDate),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.white,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                ],
              ),
            ),

            // seven days of the week
            Container(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 8,
                left: 16,
                right: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: DateHelper.getCalendarWeekLabels()
                    .map((e) => Container(
                          width: 30.0,
                          child: Text(
                            e,
                            textAlign: TextAlign.center,
                          ),
                        ))
                    .toList(),
              ),
            ),

            // 28 or 30 or 31 days of the month
            Container(
              width: 320.0,
              height: 225.0,
              color: Colors.white,
              padding: EdgeInsets.only(left: 16, right: 16),
              child: PageView.builder(
                key: PageStorageKey('expandedCalendar'),
                physics: AlwaysScrollableScrollPhysics(),
                controller: calendarController,
                reverse: true,
                onPageChanged: (index) {
                  setState(() {
                    calendarFocusedDate = getMonthFromIndex(index);
                  });
                },
                itemBuilder: (context, monthPage) {
                  var monthIndex = determineMonth(monthPage);

                  var yearOffset = 0;
                  if ((todayMonthOffset - monthPage) % 12 == 0) {
                    yearOffset =
                        1 + ((todayMonthOffset - monthPage) / 12).abs().round();
                  } else if (monthPage > todayMonthOffset) {
                    yearOffset =
                        ((todayMonthOffset - monthPage) / 12).abs().ceil();
                  }

                  var dayOffset =
                      (DateTime(today.year - yearOffset, monthIndex, 1)
                                  .weekday -
                              1) -
                          DateHelper.getFirstDayOffset("Monday");

                  return Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          key: PageStorageKey('expandedCalendar$monthIndex'),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 42,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 7),
                          itemBuilder: (context, index) {
                            index -= dayOffset;

                            var date = DateTime(
                                today.year - yearOffset, monthIndex, index);

                            FontWeight dayWeight = FontWeight.normal;

                            final isToday = date == today;
                            final selected = widget.selectedDate == date;
                            final selectable = !DateHelper.futureDay(date);
                            final isFocusedMonth =
                                date.month == calendarFocusedDate.month;

                            if (selected || isToday) {
                              dayWeight = FontWeight.w900;
                            }

                            Color dayColor = kText1Color;

                            if (!selectable) {
                              dayColor = kGrey2Color;
                            } else if (!isFocusedMonth) {
                              dayColor = kGrey1Color;
                            } else if (isToday) {
                              dayColor = Theme.of(context).primaryColor;
                            }

                            return SizedBox(
                              width: 30.0,
                              child: Container(
                                margin: const EdgeInsets.all(6),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashFactory: InkRipple.splashFactory,
                                    borderRadius: BorderRadius.circular(48),
                                    onTap: () =>
                                        widget.onDateSelected.call(date),
                                    child: Center(
                                      child: Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(24.0)),
                                        child: Center(
                                          child: Text(date.day.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                      color: dayColor,
                                                      fontSize: selected
                                                          ? 16.0
                                                          : 14.0,
                                                      fontWeight: dayWeight)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
        //
        Offstage(
          offstage: !selectMonth,
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 54,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Material(
                          color: Colors.white,
                          child: IconButton(
                            onPressed: () => prevYear(),
                            icon: const Icon(Icons.chevron_left),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () => toggleCalendarView(),
                          child: Text(
                            '${yearLabel()}',
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 20,
                                    ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Material(
                          color: Colors.white,
                          child: IconButton(
                            onPressed: () => nextYear(),
                            icon: const Icon(Icons.chevron_right),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 320.0,
                  height: 225.0,
                  child: Column(
                    children: [
                      Expanded(
                        child: PageView.builder(
                          key: PageStorageKey('monthSelector'),
                          physics: AlwaysScrollableScrollPhysics(),
                          controller: yearController,
                          itemCount: (today.year - 2020) + 1,
                          reverse: true,
                          onPageChanged: (index) => setState(() {}),
                          itemBuilder: (context, yearPage) {
                            return Wrap(
                              children: monthIndices.map((i) {
                                DateTime date =
                                    DateTime(today.year - yearPage, i);
                                Widget child;

                                if (yearPage == 0 && i > today.month) {
                                  child = TextButton(
                                    style: TextButton.styleFrom(
                                      primary: kGrey4Color,
                                      backgroundColor: Colors.transparent,
                                    ),
                                    child: Text(DateFormat.MMMM().format(date)),
                                    onPressed: null,
                                  );
                                } else if ((today.year - yearPage) ==
                                        calendarFocusedDate.year &&
                                    i == calendarFocusedDate.month) {
                                  child = TextButton(
                                    style: TextButton.styleFrom(
                                      primary: kPrimaryColor,
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                    ),
                                    onPressed: () =>
                                        setState(() => selectMonth = false),
                                    child: Text(DateFormat.MMMM().format(date)),
                                  );
                                } else {
                                  child = TextButton(
                                    style: TextButton.styleFrom(
                                      primary: kText1Color,
                                      backgroundColor: Colors.transparent,
                                    ),
                                    child: Text(DateFormat.MMMM().format(date)),
                                    onPressed: () {
                                      focusDate(date);
                                      setState(() {
                                        calendarFocusedDate = date;
                                        selectMonth = false;
                                      });
                                    },
                                  );
                                }
                                return Container(
                                  height: 225.0 / 4.0,
                                  width: 90.0,
                                  child: Center(
                                    child: child,
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  bool selectMonth = false;
  var monthIndices = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  toggleCalendarView() {
    if (selectMonth) {
      setState(() {
        selectMonth = false;
      });
    } else {
      setState(() {
        selectMonth = true;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        yearController.jumpToPage(today.year - calendarFocusedDate.year);
      });
    }
  }

  nextYear() {
    if (yearController.page != null && yearController.page! > 0) {
      yearController.jumpToPage(yearController.page!.round() - 1);
    }
  }

  prevYear() {
    if (yearController.page != null &&
        (today.year - yearController.page!) != 2020) {
      yearController.jumpToPage(yearController.page!.round() + 1);
    }
  }

  int yearLabel() {
    if (yearController.hasClients) {
      return today.year - yearController.page!.round();
    } else
      return calendarFocusedDate.year;
  }

  focusDate(DateTime date) async {
    var monthDifference = 0;
    var lastMonth = today.month;
    var difference = today.difference(date).inDays;

    var _d = today;
    for (int i = 0; i < difference; i++) {
      _d = _d.subtract(Duration(days: 1));
      if (lastMonth != _d.month) {
        monthDifference++;
        lastMonth = _d.month;
      }
    }
    calendarFocusedDate = getMonthFromIndex(monthDifference);
    calendarController.jumpToPage(monthDifference);
  }

  int determineMonth(pageIndex) {
    var monthIndex = today.month - pageIndex;
    while (monthIndex < 1) {
      monthIndex += 12;
    }
    return monthIndex.round();
  }

  int getFocusedWeekMonthIndex() {
    var todayOffset = today.day;

    var selectedDayWeek_initialWeekDay =
        DateHelper.getDateDay(widget.selectedDate);

    var focusWeek_initialWeekDay = DateHelper.getStartOfWeek(
        today.subtract(Duration(days: (weekIndex.value * 7))), "Monday");

    bool selectedDayIsInFocus =
        selectedDayWeek_initialWeekDay == focusWeek_initialWeekDay;

    DateTime anchorDate;
    // focus month to selectedDate month
    if (selectedDayIsInFocus &&
        widget.selectedDate.month != focusWeek_initialWeekDay.month) {
      anchorDate = widget.selectedDate;
    }
    // focus month to focusWeek initial weekday month
    else {
      anchorDate = focusWeek_initialWeekDay;
    }

    // difference from today to focus week start day
    var difference = today.difference(anchorDate).inDays;
    // # of months back the focus week is
    var monthDifference = 0;
    // rolling month index, increments with monthDifference
    var lastMonth = today.month;

    if (difference >= todayOffset) {
      // cannot use static day subtraction because days in month is dynamic
      // therefore we will use dart:DateTime subtraction for each day of difference
      // and count the # of times month changed
      var date = today;
      for (int i = 0; i < difference; i++) {
        date = date.subtract(Duration(days: 1));
        if (lastMonth != date.month) {
          monthDifference++;
          lastMonth = date.month;
        }
      }
    }
    return monthDifference;
  }
}
