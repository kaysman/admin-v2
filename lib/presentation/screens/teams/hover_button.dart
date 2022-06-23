import 'package:flutter/material.dart';
import 'package:lng_adminapp/shared.dart';

class HoverButton extends StatefulWidget {
  const HoverButton({
    required this.list,
    required this.index,
  });

  final List<List<String>> list;
  final int index;

  @override
  _HoverButtonState createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool showBorder = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      child: Row(children: [
        CircleAvatar(
          radius: 8,
          backgroundImage: AssetImage(widget.list[widget.index][0]),
        ),
        DecoratedBox(
            decoration: BoxDecoration(
                color: kWhite,
                border: showBorder
                    ? Border(bottom: BorderSide(color: kBlack, width: 1.5))
                    : null),
            child: InkWell(
                onTap: () {},
                onHover: (hovered) {
                  setState(() {
                    showBorder = hovered;
                  });
                },
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      widget.list[widget.index][1],
                      style: Theme.of(context).textTheme.bodyText1,
                    ))))
      ]),
    );
  }
}
