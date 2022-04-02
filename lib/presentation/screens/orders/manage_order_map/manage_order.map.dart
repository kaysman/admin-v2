import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:lng_adminapp/shared.dart';
import 'components/view_display_widget.dart';
import 'options.dart';

class ManageOrdersMapScreen extends StatefulWidget {
  static const String routeName = 'manage-order-map';
  const ManageOrdersMapScreen({
    Key? key,
    required this.onViewChanged,
  }) : super(key: key);

  final VoidCallback onViewChanged;

  @override
  State<ManageOrdersMapScreen> createState() => _ManageOrdersMapScreenState();
}

class _ManageOrdersMapScreenState extends State<ManageOrdersMapScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(key: _formKey, child: _buildBody());
  }

  _buildBody() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 4, child: _buildMapView()),
        SelectableOptions(),
      ],
    );
  }

  _buildMapView() {
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            center: LatLng(1.290270, 103.851959), // Singapore city lat, lng
            boundsOptions: FitBoundsOptions(
              padding: EdgeInsets.all(8.0),
              zoom: 11.5,
            ),
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
              backgroundColor: kBlack,
              maxZoom: 18.0,
              minZoom: 1,
            ),
            ...List.generate(latLongs.length, (index) {
              return MarkerLayerOptions(
                markers: [
                  Marker(
                    width: 60.sp,
                    height: 60.sp,
                    point: LatLng(latLongs[index][0], latLongs[index][1]),
                    builder: (ctx) => Icon(
                      Icons.pin_drop,
                      color: latLongs[index][2],
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
        _buildTopSnackbar(),
        _buildBottomSnackbar(),
      ],
    );
  }

  _buildTopSnackbar() {
    return Positioned.fill(
      top: 20.sp,
      child: Align(
        alignment: Alignment.topCenter,
        child: TopViewDefiningWidget(
          onViewChanged: widget.onViewChanged,
        ),
      ),
    );
  }

  _buildBottomSnackbar() {
    return Positioned.fill(
      bottom: 20.sp,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              boxShadow: kBoxShadow,
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(26),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("1 tasks selected",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: kWhite)),
                Spacings.TINY_HORIZONTAL,
                Icon(Icons.close, color: kWhite, size: 24.sp),
              ],
            )),
      ),
    );
  }
}

List latLongs = [
  [1.3778, 103.8000, Colors.blue.shade500],
  [1.3778, 103.7442, Colors.blue.shade500],
  [1.3833, 103.7500, Colors.blue.shade500],
  [1.3817, 103.7525, Colors.blue.shade500],
  [1.4411, 103.7708, Colors.blue.shade500],
  [1.3244, 103.9544, Colors.blue.shade500],
];
