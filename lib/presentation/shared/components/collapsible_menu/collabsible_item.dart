import 'package:flutter/material.dart';

class CollapsibleItemWidget extends StatelessWidget {
  const CollapsibleItemWidget({
    // required this.onHoverPointer,
    required this.leading,
    required this.title,
    required this.offsetX,
    required this.scale,
    required this.tooltip,
    this.onTap,
  });

  // final MouseCursor onHoverPointer;
  final Widget leading;
  final Widget title;
  final String tooltip;
  final double offsetX, scale;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Tooltip(
        message: tooltip,
        showDuration: const Duration(milliseconds: 10),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shadowColor: Colors.white,
            elevation: 0.0,
            padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
          ),
          child: Stack(
            // alignment: Alignment.centerLeft,
            children: [
              leading,
              _title,
            ],
          ),
        ),
      ),
    );
  }

  Widget get _title {
    return Opacity(
      opacity: scale,
      child: Transform.translate(
        offset: Offset(offsetX, 0),
        child: Transform.scale(
          scale: scale,
          child: SizedBox(
            width: double.infinity,
            child: title,
          ),
        ),
      ),
    );
  }
}

class SideBarItem {
  SideBarItem({
    required this.text,
    required this.icon,
    required this.bodyBuilder,
  });

  final String text;
  final String icon;
  final WidgetBuilder bodyBuilder;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SideBarItem && other.text == text && other.icon == icon;
  }

  @override
  int get hashCode => text.hashCode ^ icon.hashCode;
}

class SideBarGroup {
  final String title;
  final List<SideBarItem> items;

  const SideBarGroup({
    required this.title,
    required this.items,
  });
}

// // THIS LOGIC can be used to
// // check if user is admin or merchant
// // ...
// List<SideBarGroup> getSideBarGroups(/*UserRole role*/) {
//   List<SideBarItem> managementItems = [];
//   // if (role == UserRole.MERCHANT) {}

//   managementItems.addAll(menuItems);
//   return [SideBarGroup(title: 'Management', items: managementItems)];
// }
