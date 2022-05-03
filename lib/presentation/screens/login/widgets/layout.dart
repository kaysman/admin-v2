import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/presentation/shared/colors.dart';
import 'package:lng_adminapp/presentation/shared/icons.dart';
import 'package:lng_adminapp/presentation/shared/spacings.dart';

class LoginLayout extends StatelessWidget {
  const LoginLayout({
    Key? key,
    required this.body,
    this.backgroundColor = kSecondaryColor,
  }) : super(key: key);

  final Color? backgroundColor;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 140.0,
        ),
        child: Column(
          children: [
            Spacings.BIG_VERTICAL,
            Row(
              children: [
                Image.asset(
                  AppIcons.logo,
                  width: 35.sp,
                  height: 45.sp,
                ),
                Spacings.TINY_HORIZONTAL,
                Text(
                  "Load and Go",
                  style: GoogleFonts.inter(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Spacer(),
                ...[
                  Icon(
                    Icons.phone,
                    size: 24.sp,
                  ),
                  Spacings.TINY_HORIZONTAL,
                  Text.rich(
                    TextSpan(
                      text: "Talk with our team at ",
                      style: Theme.of(context).textTheme.headline5,
                      children: [
                        TextSpan(
                          text: "+56 458 3256",
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(color: kPrimaryColor),
                          mouseCursor: MaterialStateMouseCursor.clickable,
                          onEnter: (v) {},
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
            body,
          ],
        ),
      ),
    );
  }
}
