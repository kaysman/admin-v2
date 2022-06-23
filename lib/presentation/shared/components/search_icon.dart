import 'package:flutter/material.dart';
import 'package:lng_adminapp/shared.dart';

class SearchIcon extends StatelessWidget {
  const SearchIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: AppIcons.svgAsset(AppIcons.search),
    );
  }
}
