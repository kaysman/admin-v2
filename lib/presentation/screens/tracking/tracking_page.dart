import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/data/models/orders/filter_parameters.dart';
import 'package:lng_adminapp/presentation/screens/index/index.screen.dart';
import 'package:lng_adminapp/presentation/screens/login/widgets/layout.dart';
import 'package:lng_adminapp/presentation/screens/orders/order.bloc.dart';
import 'package:lng_adminapp/shared.dart';

import '../../../data/models/orders/order-column.dart';
import '../orders/manage_order_table/dialogs/select_column.dart';

class TrackingScreen extends StatefulWidget {
  static const String routeName = 'tracking';
  const TrackingScreen({Key? key}) : super(key: key);

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _trackingNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _trackingNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: LoginLayout(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Shipment Tracking",
              style: Theme.of(context).textTheme.headline4?.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Spacings.TINY_VERTICAL,
            Text("Track your order",
                style: Theme.of(context).textTheme.bodyText1),
            Spacings.LITTLE_BIG_VERTICAL,
            Container(
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
              child: buildEmailSection(),
            ),
            Spacings.LITTLE_BIG_VERTICAL,
            contactUs(),
          ],
        ),
      ),
    );
  }

  contactUs() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Have an issue? ",
          style: GoogleFonts.inter(
            fontSize: 14,
          ),
        ),
        InkWell(
          onTap: () {},
          child: Text(
            "Contact us",
            style: GoogleFonts.inter(
              fontSize: 14,
              color: kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }

  goToHome() => Navigator.of(context)
      .pushNamedAndRemoveUntil(IndexScreen.routeName, (_) => false);

  goTo(String route) =>
      Navigator.of(context).pushNamedAndRemoveUntil(route, (_) => false);

  buildEmailSection() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 0.35.sw,
            child: TextFormField(
              controller: _trackingNumberController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(16),
                hintText: 'Type your tracking number',
                hintStyle:
                    Theme.of(context).inputDecorationTheme.hintStyle?.copyWith(
                          fontSize: 12,
                        ),
                errorStyle: TextStyle(
                  height: 0,
                  fontSize: 0,
                ),
              ),
            ),
          ),
          SizedBox(width: 24),
          Button(
            text: "Track order",
            primary: kPrimaryColor,
            textColor: kWhite,
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 22,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Future<void> onLoginTapped() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    } else {
      throw ("error");
    }
  }
}
