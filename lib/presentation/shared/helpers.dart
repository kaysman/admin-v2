import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:intl/intl.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/data/models/pickup/pickup-time-breakdown.model.dart';
import 'package:lng_adminapp/presentation/shared/components/status-indicator.widget.dart';
import '../../data/services/app.service.dart';
import '../../data/services/storage.service.dart';
import '../screens/role-permissions-roles/no_permission.dart';
import 'colors.dart';

String apiUrl = "lng-test-environment.as.r.appspot.com";
Future<Map<String, String>> get headers async => {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Authorization": 'Bearer ${await getToken()}',
      "x-timezone": "${await getTimezone()}",
    };

Future<String?> getToken() async {
  var disk = (await LocalStorage.instance);
  return disk.credentials?.accessToken;
}

Future<String> getTimezone() async {
  return await FlutterNativeTimezone.getLocalTimezone();
}

guardedRouteBuilder(BuildContext context, List<PermissionType> permissions,
    Widget directTo, String description) {
  if (!permissions
      .map((e) => AppService.hasPermission(e))
      .toList()
      .contains(false)) {
    return directTo;
  } else {
    return NoPermissionPage(
      description: description,
    );
  }
}

/// -------------
/// [showSnackBar] method shows snackbar.
/// Context should not be null
/// -------------
void showSnackBar(
  BuildContext context,
  Widget object, {
  Color? backgroundColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 4),
      width: 270.0,
      content: object,
    ),
  );
}

/// ---------
/// [hideKeyboard] hides keyboard in provided context
/// ---------
void hideKeyboard({BuildContext? context}) {
  if (context == null) {
    FocusManager.instance.primaryFocus?.unfocus();
  } else {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}

/// --------
/// [showWhiteDialog] shows dialog with kGrey5Color(0.5)
/// --------
showWhiteDialog<T>(BuildContext context, Widget content,
    [dismissible = true]) async {
  var res = await showDialog<T>(
    barrierDismissible: dismissible,
    context: context,
    barrierColor: kGrey4Color.withOpacity(0.5),
    builder: (context) {
      return Dialog(
        backgroundColor: kWhite,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: content,
      );
    },
  );
  return res;
}

todayDate() {
  var now = new DateTime.now();
  return DateHelper.yyyyMMdd(now);
}

String convertTo24HrTime(String time) {
  var _time = time.split(' ');
  String response = '';
  var timeBreakdown = _time[0].split(':');
  String hour = '00';
  String min = timeBreakdown[1];

  if (timeBreakdown[0] == '12') {
    hour = '00';
  } else {
    hour = timeBreakdown[0];
  }

  if (_time[1] == 'PM') {
    hour = (int.parse(hour) + 12).toString();
    response = '$hour:${min}';
  } else {
    response = '$hour:$min';
  }
  return response;
}

String timelineDate(String? date) {
  DateTime parsedDate = DateTime.parse(date!);
  var formatter = new DateFormat('MMM dd');

  String formattedDate = formatter.format(parsedDate);
  return formattedDate;
}

String timelineTime(String? date) {
  DateTime parsedDate = DateTime.parse(date!);
  var formatter = new DateFormat('hh:mm aaa');

  String formattedDate = formatter.format(parsedDate);
  return formattedDate;
}

String formatToOrderStatusDate(String? date) {
  // 12:05 PM 03 November 2021
  DateTime parsedDate = DateTime.parse(date!);
  var formatter = new DateFormat('hh:mm aaa dd MMMM yyyy');

  String formattedDate = formatter.format(parsedDate);
  return formattedDate;
}

PickupTimeBreakDown timeBreakDown(DateTime pickupTime, DateTime closingTime) {
  PickupTimeBreakDown result = PickupTimeBreakDown();
  DateTime _date = pickupTime;
  var timeFormatter = new DateFormat('hh:mm aaa');
  var dateFormatter = new DateFormat('yyyy-MM-dd');
  String _pickupTime = timeFormatter.format(pickupTime);
  String _closingTime = timeFormatter.format(closingTime);
  String date = dateFormatter.format(_date);

  result.pickupTime = _pickupTime;
  result.closingTime = _closingTime;
  result.date = date;
  return result;
}

String replaceStringWithDash(String? value) {
  if (value == null || value == "".trim()) {
    return '-';
  }

  return value;
}

Widget statusBall(String? status, bool? isBold) {
  Widget result = Text('-');
  if (status == 'ORDER_CREATED') {
    result = StatusIndicator(
      isBold: isBold ??true,
      color: kPrimaryColor,
      label: status,
    );
  } 
  return result;
}

class DateHelper {
  static String hourIn24System(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }

  static String ddMMYYY(DateTime date) {
    return DateFormat('dd/MM/y').format(date);
  }

  static String yyyyMMdd(DateTime date) {
    return DateFormat('yyyy-MM-dd hh:mm a').format(date);
  }

  static List<String> getCalendarWeekLabels() {
    Queue<String> labels =
        Queue<String>.from(['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa']);
    return labels.toList();
  }

  static DateTime getDateDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static int getFirstDayOffset(String dayString) {
    var first = getWeekdayIndex(dayString);
    return 1 - first;
  }

  static bool futureDay(DateTime selectedDate) {
    return (getDateDay(selectedDate).isAfter(getDateDay(DateTime.now())));
  }

  static DateTime getStartOfWeek(DateTime date, String dayString) {
    var today = getDateDay(date);
    while (today.weekday != getWeekdayIndex(dayString)) {
      today = today.subtract(Duration(days: 1));
    }
    return today;
  }

  static int getWeekdayIndex(String dayString) {
    switch (dayString) {
      case 'Sunday':
        return 7;
      case 'Monday':
        return 1;
      case 'Tuesday':
        return 2;
      case 'Wednesday':
        return 3;
      case 'Thursday':
        return 4;
      case 'Friday':
        return 5;
      case 'Saturday':
        return 6;
      default:
        return 1;
    }
  }
}

T? checkIfChangedAndReturn<T>(T? oldValue, T? newValue) {
  return (oldValue != newValue && newValue != '-') ? newValue : null;
}
