import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Spacings {
  static const kSpaceZero = 0.0;
  static const kSpaceTiny = 8.0;
  static const kSpaceSmall = 16.0;
  static const kSpaceNormal = 24.0;
  static const kSpaceLogoText = 24.0;
  static const kSpaceLittleBig = 32.0;
  static const kSpaceBig = 42.0;
  static const kSpaceLarge = 85.0;
  static const kSpaceHuge = 32.0;
  static const kSpaceGiant = 64.0;

  static const ZERO = SizedBox.shrink();

  static const TINY = SizedBox(width: kSpaceTiny, height: kSpaceTiny);
  static const TINY_HORIZONTAL =
      SizedBox(width: kSpaceTiny, height: kSpaceZero);
  static const TINY_VERTICAL = SizedBox(width: kSpaceZero, height: kSpaceTiny);

  static const SMALL = SizedBox(width: kSpaceSmall, height: kSpaceSmall);
  static const SMALL_HORIZONTAL =
      SizedBox(width: kSpaceSmall, height: kSpaceZero);
  static const SMALL_VERTICAL =
      SizedBox(width: kSpaceZero, height: kSpaceSmall);

  static const NORMAL = SizedBox(width: kSpaceNormal, height: kSpaceNormal);
  static const NORMAL_HORIZONTAL =
      SizedBox(width: kSpaceNormal, height: kSpaceZero);
  static const NORMAL_VERTICAL =
      SizedBox(width: kSpaceZero, height: kSpaceNormal);

  static const LITTLE_BIG =
      SizedBox(width: kSpaceLittleBig, height: kSpaceLittleBig);
  static const LITTLE_BIG_HORIZONTAL =
      SizedBox(width: kSpaceLittleBig, height: kSpaceZero);
  static const LITTLE_BIG_VERTICAL =
      SizedBox(width: kSpaceZero, height: kSpaceLittleBig);

  static const BIG = SizedBox(width: kSpaceBig, height: kSpaceBig);
  static const BIG_HORIZONTAL = SizedBox(width: kSpaceBig, height: kSpaceZero);
  static const BIG_VERTICAL = SizedBox(width: kSpaceZero, height: kSpaceBig);

  static const LARGE = SizedBox(width: kSpaceLarge, height: kSpaceLarge);
  static const LARGE_HORIZONTAL =
      SizedBox(width: kSpaceLarge, height: kSpaceZero);
  static const LARGE_VERTICAL =
      SizedBox(width: kSpaceZero, height: kSpaceLarge);

  static const HUGE = SizedBox(width: kSpaceHuge, height: kSpaceHuge);
  static const HUGE_HORIZONTAL =
      SizedBox(width: kSpaceHuge, height: kSpaceZero);
  static const HUGE_VERTICAL = SizedBox(width: kSpaceZero, height: kSpaceHuge);

  static const GIANT = SizedBox(width: kSpaceGiant, height: kSpaceGiant);
  static const GIANT_HORIZONTAL =
      SizedBox(width: kSpaceGiant, height: kSpaceZero);
  static const GIANT_VERTICAL =
      SizedBox(width: kSpaceZero, height: kSpaceGiant);
}

// SPACE static constANTS (padding, margin)

// FLEX SPACERS (Columns, Rows)

// static const kDividerTiny = Divider(height: kSpaceTiny);
// static const kDividerSmall = Divider(height: kSpaceSmall);
// static const kDividerNormal = Divider();
// static const kDividerLittleBig = Divider(height: kSpaceLittleBig);
// static const kDividerBig = Divider(height: kSpaceBig);
// static const kDividerLarge = Divider(height: kSpaceLarge);
// static const kDividerHuge = Divider(height: kSpaceHuge);
// static const kDividerGiant = Divider(height: kSpaceGiant);
