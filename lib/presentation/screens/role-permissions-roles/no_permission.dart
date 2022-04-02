import 'package:flutter/material.dart';
import 'package:lng_adminapp/presentation/screens/index/index.screen.dart';
import 'package:lng_adminapp/shared.dart';

class NoPermissionPage extends StatelessWidget {
  const NoPermissionPage({
    Key? key,
    required this.description,
  }) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(description),
            const SizedBox(height: 14.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Button(
                  text: "Go back",
                  textColor: kPrimaryColor,
                  onPressed: () {
                    print("go back");
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(width: 14),
                Button(
                  primary: kPrimaryColor,
                  text: "Go home",
                  onPressed: () => Navigator.of(context)
                      .pushNamedAndRemoveUntil(
                          IndexScreen.routeName, (route) => false),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
