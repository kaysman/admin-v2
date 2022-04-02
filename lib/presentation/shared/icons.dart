import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AppIcons {
  // svg
  static String get dashboard => "assets/svg/dashboard.svg";
  static String get drivers => "assets/svg/drivers.svg";
  static String get flow => "assets/svg/flow.svg";
  static String get back => "assets/svg/menuBack.svg";
  static String get back_android => "assets/svg/back-android.svg";
  static String get teams => "assets/svg/teams.svg";
  static String get merchants => "assets/svg/merchants.svg";
  static String get settings => "assets/svg/settings.svg";
  static String get logout => "assets/svg/logout.svg";
  static String get undo => "assets/svg/undo.svg";
  static String get redo => "assets/svg/redo.svg";
  static String get lightning => "assets/svg/lightning.svg";
  static String get halfCircle => "assets/svg/halfCircle.svg";
  static String get analyze => "assets/svg/analyze.svg";
  static String get calendar => "assets/svg/calendar.svg";
  static String get circle => "assets/svg/circle.svg";
  static String get columns => "assets/svg/columns.svg";
  static String get delete => "assets/svg/delete.svg";
  static String get map => "assets/svg/map.svg";
  static String get pencil => "assets/svg/pencil.svg";
  static String get printer => "assets/svg/printer.svg";
  static String get search => "assets/svg/search.svg";
  static String get table => "assets/svg/table.svg";
  static String get payment => "assets/svg/money-svgrepo-com.svg";
  static String get invoice => "assets/svg/invoice-money-svgrepo-com.svg";
  static String get security => "assets/svg/security-svgrepo-com.svg";
  static String get help => "assets/svg/help.svg";
  static String get operationalFlow => "assets/svg/view-operational-flow.svg";
  static String get edit => "assets/svg/edit.svg";
  static String get subadmin => "assets/svg/subadmin.svg";
  static String get driver => "assets/svg/driver.svg";
  static String get add => "assets/svg/add.svg";
  static String get bag => "assets/svg/bag.svg";
  static String get permissions => "assets/svg/permissions.svg";
  static String get filter => "assets/svg/filter.svg";
  static String get locations => "assets/svg/location.svg";
  static String get clock => "assets/svg/clock.svg";
  static String get chevronDown => "assets/svg/chevron-down.svg";
  static String get edit2 => "assets/svg/edit2.svg";

  // png
  static String get logo => "assets/logo.png";
  static String get dots => "assets/dots.png";
  static String get empty_flow => "assets/empty-flow.png";

  static svgAsset(
    String path, {
    double? width,
    double? height,
    Color? color,
  }) {
    return SvgPicture.asset(
      path,
      width: width ?? 24.sp,
      height: height ?? 24.sp,
      color: color,
    );
  }
}
