import 'package:flutter/material.dart';
import 'package:lng_adminapp/shared.dart';

import 'invoice.dart';
import 'org_settings.dart';
import 'payment.dart';
import 'security.dart';

class SettingsLayout extends StatefulWidget {
  static const String routeName = 'settings-page';

  @override
  State<SettingsLayout> createState() => _SettingsLayoutState();
}

class _SettingsLayoutState extends State<SettingsLayout> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: kGreyBackground,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildHeader(), _buildBody()],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Spacings.kSpaceLittleBig),
        Padding(
          padding: const EdgeInsets.only(left: Spacings.kSpaceLittleBig),
          child: Text(
            "Settings",
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Container(
          width: 600,
          margin: EdgeInsets.only(left: 28),
          child: TabBar(
            labelPadding: EdgeInsets.all(4),
            padding: EdgeInsets.only(right: Spacings.kSpaceLittleBig),
            isScrollable: true,
            labelColor: kPrimaryColor,
            labelStyle: Theme.of(context).textTheme.bodyText1,
            unselectedLabelStyle: Theme.of(context).textTheme.bodyText1,
            unselectedLabelColor: kGrey1Color,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: ['Organizational Settings', 'Payment', 'Invoice', 'Security']
                .map<Widget>((tab) {
              return Tab(child: Text(tab));
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: TabBarView(
        children: <Widget>[
          OrganizationalSettingsPage(),
          PaymentPage(),
          InvoicePage(),
          SecurityPage()
        ],
      ),
    );
  }
}
