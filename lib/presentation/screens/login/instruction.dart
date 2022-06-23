import 'package:flutter/material.dart';
import 'package:lng_adminapp/shared.dart';
import 'widgets/layout.dart';

class InstructionsSentPage extends StatelessWidget {
  static const String routeName = 'instruction-sent';
  const InstructionsSentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginLayout(
      body: Expanded(
        child: Center(
          child: Container(
            width: 420,
            padding: const EdgeInsets.symmetric(
              vertical: Spacings.kSpaceLittleBig,
              horizontal: Spacings.kSpaceBig + 12,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 45,
                  color: const Color(0xff000000).withOpacity(0.1),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Instructions sent!",
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                        color: Colors.black,
                      ),
                ),
                Spacings.SMALL_VERTICAL,
                Text(
                  "Instructions for resetting your password have been sent to towsiful.design@gmail.com.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
