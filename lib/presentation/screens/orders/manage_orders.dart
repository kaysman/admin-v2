import 'package:flutter/material.dart';
import 'manage_order_map/manage_order.map.dart';
import 'manage_order_table/manage_order.table.dart';

class ManageOrders extends StatefulWidget {
  const ManageOrders({Key? key}) : super(key: key);

  @override
  State<ManageOrders> createState() => _ManageOrdersState();
}

class _ManageOrdersState extends State<ManageOrders> {
  bool isMapView = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: isMapView
          ? ManageOrdersMapScreen(onViewChanged: changeView)
          : ManageOrdersTableScreen(onViewChanged: changeView),
    );
  }

  changeView() {
    setState(() {
      isMapView = !isMapView;
    });
  }
}
