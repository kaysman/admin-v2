import 'package:flutter/material.dart';
import '../colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabViewedContainer extends StatelessWidget {
  const TabViewedContainer({
    Key? key,
    required this.tabs,
    required this.views,
    this.tabIndex,
    this.padding,
    this.margin,
    this.width = 520,
    this.height,
    this.controller,
    @required this.footer,
  }) : super(key: key);

  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final List<String> tabs;
  final List<Widget> views;
  final int? tabIndex;
  final TabController? controller;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 45.r,
            color: const Color(0xff000000).withOpacity(0.1),
          ),
        ],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      child: DefaultTabController(
        length: tabs.length,
        initialIndex: tabIndex ?? 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: AbsorbPointer(
                    absorbing: true,
                    child: TabBar(
                      labelColor: kPrimaryColor,
                      controller: controller,
                      labelStyle: Theme.of(context).textTheme.bodyText1,
                      unselectedLabelStyle:
                          Theme.of(context).textTheme.bodyText1,
                      unselectedLabelColor: kGrey1Color,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: tabs
                          .map<Widget>(
                            (tab) => Tab(
                              child: Container(
                                width: width! / tabs.length,
                                child: Center(child: Text(tab)),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              height: 0,
              endIndent: 0,
              indent: 0,
              thickness: 1,
            ),
            Expanded(
              child: Padding(
                padding: padding ?? EdgeInsets.all(24.w),
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: controller,
                  children: views,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 24.w,
                bottom: 24.w,
                right: 24.w,
              ),
              child: footer!,
            )
          ],
        ),
      ),
    );
  }
}
