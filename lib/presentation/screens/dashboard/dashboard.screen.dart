import 'package:flutter/material.dart';
import 'package:lng_adminapp/data/services/order.service.dart';
import 'package:lng_adminapp/presentation/screens/orders/manage_order_table/order_status/order_status.dart';
import 'package:lng_adminapp/presentation/shared/components/assign.dialog.dart';
import 'package:lng_adminapp/shared.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = 'dashboard';
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      endDrawerEnableOpenDragGesture: false,
      endDrawer: OrderStatusEndDrawer(),
      body: Container(
        color: kGrey5Color,
        padding: EdgeInsets.fromLTRB(21, 32, 21, 0),
        child: Center(
          child: InkWell(
            onTap: () {
              OrderService.selectedOrder.value = {
                'id': "5b311651-dd49-4eb9-994f-4aa92a858b11"
              };
              key.currentState!.openEndDrawer();
            },
            child: Text("Open"),
          ),
        ),
      ),
    );
  }
}
