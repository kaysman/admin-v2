import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/data/models/orders/order.model.dart';
import 'package:lng_adminapp/data/services/order.service.dart';
import 'package:lng_adminapp/shared.dart';

import 'delivery_details.dart';
import 'order_details.dart';
import 'pickup_details.dart';

class OrderStatusEndDrawer extends StatelessWidget {
  const OrderStatusEndDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orderId = OrderService.selectedOrder.value?['id'];
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.r),
          bottomLeft: Radius.circular(15.r),
        ),
        color: kWhite,
      ),
      child: orderId == null
          ? Center(child: Text("No order selected"))
          : FutureBuilder<Order>(
              future: OrderService.getOrderbyID(orderId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return OrderStatusPage(snapshot.data!);
                } else if (snapshot.hasError) {
                  return SizedBox.expand(
                    child: Center(
                      child: Text("${snapshot.error}"),
                    ),
                  );
                } else {
                  return SizedBox.expand(
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
    );
  }
}

class OrderStatusPage extends StatefulWidget {
  const OrderStatusPage(this.order, {Key? key}) : super(key: key);

  final Order order;

  @override
  State<OrderStatusPage> createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage>
    with SingleTickerProviderStateMixin {
  late Order selectedOrder;
  late TabController tabController;

  List<String> tabNames = [
    "Order details",
    "Pickup details",
    "Delivery details"
  ];

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    selectedOrder = widget.order;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(context),
        TabBar(
          controller: tabController,
          padding: EdgeInsets.zero,
          labelColor: kPrimaryColor,
          unselectedLabelColor: kText1Color,
          labelStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          tabs: List.generate(tabNames.length, (index) {
            return Tab(text: tabNames[index]);
          }),
        ),
        Divider(
          height: 1,
          color: kGrey3Color,
        ),
        Expanded(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: [
              OrderDetails(order: selectedOrder),
              PickupDetails(order: selectedOrder),
              DeliveryDetails(order: selectedOrder),
            ],
          ),
        ),
        buildBottomBar(context),
      ],
    );
  }

  buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: kGrey3Color.withOpacity(0.5),
            offset: Offset(0, -8.0),
            blurRadius: 8,
          ),
        ],
        color: kWhite,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xff25D366),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.message, color: kWhite),
                  SizedBox(width: 8),
                  Text(
                    "Whatsapp receiver",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: kWhite,
                          fontWeight: FontWeight.bold,
                        ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xffefefef),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.message, color: kBlack),
                  SizedBox(width: 8),
                  Text(
                    "Email receiver",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: kBlack,
                          fontWeight: FontWeight.bold,
                        ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _header(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              backButton(),
              copyButton(),
            ],
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (selectedOrder.orderPackage != null &&
                  selectedOrder.orderPackage!.isNotEmpty)
                Expanded(
                  child: Text(
                    "${selectedOrder.orderPackage!.first.name}",
                    style: GoogleFonts.inter(
                      color: kBlack,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              statusBall(selectedOrder.status, true),
            ],
          ),
        ],
      ),
    );
  }

  backButton() {
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.arrow_back_ios,
            color: kGrey1Color,
            size: 16.sp,
          ),
          SizedBox(width: 8.w),
          Text(
            "Back to table",
            style: GoogleFonts.inter(
              color: kGrey1Color,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }

  copyButton() {
    return InkWell(
      onTap: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.copy,
            color: kPrimaryColor,
            size: 16,
          ),
          SizedBox(width: 8.w),
          Text(
            "Copy link",
            style: GoogleFonts.inter(
              color: kPrimaryColor,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
