import 'package:flutter/material.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import '../colors.dart';
import 'dropdowns.dart';
import 'labeled_input.dart';

class GridTimePicker extends StatelessWidget {
  GridTimePicker({
    Key? key,
    required this.child,
    required this.items,
    required this.onSelected,
    this.value,
  }) : super(key: key);

  final Widget child;
  final String? value;
  final List<String> items;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    var first16items = items.sublist(0, 16);
    var second16items = items.sublist(16, 32);
    var last16items = items.sublist(32);

    return StatefulBuilder(builder: (context, state) {
      return PopupMenuButton<String>(
        color: kWhite,
        padding: EdgeInsets.zero,
        child: child,
        itemBuilder: (context) {
          return <PopupMenuItem<String>>[
            PopupMenuItem<String>(
              enabled: false,
              padding: const EdgeInsets.only(left: 8, right: 6),
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: List.generate(3, (index) {
                    var data = index == 0
                        ? first16items
                        : index == 1
                            ? second16items
                            : last16items;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: data.map((x) {
                        return SizedBox(
                          width: 87,
                          child: Row(
                            children: [
                              Radio(
                                value: x == this.value,
                                groupValue: true,
                                onChanged: (v) {
                                  state(() => onSelected(x));
                                  Navigator.of(context).pop();
                                },
                              ),
                              Text(
                                x,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  }),
                ),
              ),
            ),
          ];
        },
      );
    });
  }
}

class DateFilter<T, T1> extends StatelessWidget {
  const DateFilter({
    Key? key,
    this.child,
    this.dateByValue,
    this.filterByValue,
    required this.onFilterBySelected,
    required this.filterByItemBuilder,
    required this.onDateByChanged,
    required this.dateByItemBuilder,
    required this.filterInputWidgetBuilder,
    this.dateChild,
  }) : super(key: key);

  final Widget? child;

  /// FILTER BY
  final T? filterByValue;
  final Widget Function(BuildContext context) filterInputWidgetBuilder;
  final List<DropdownMenuItem<T>> Function(BuildContext context)
      filterByItemBuilder;
  final ValueChanged<T?> onFilterBySelected;

  /// DATE BY
  final T1? dateByValue;
  final Widget? dateChild;
  final List<RadioDropdownMenuItem<T1>> Function(BuildContext context)
      dateByItemBuilder;
  final ValueChanged<T1> onDateByChanged;

  // final ValueChanged<DateTimeRange>? onDateTimeRangeSelected;

  @override
  Widget build(BuildContext context) {
    var filterByItems = this.filterByItemBuilder.call(context);
    var inputWidget = this.filterInputWidgetBuilder.call(context);

    return PopupMenuButton(
      padding: EdgeInsets.zero,
      color: kWhite,
      child: child,
      itemBuilder: (context) {
        return <PopupMenuItem>[
          PopupMenuItem(
            enabled: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Filter by"),
                const SizedBox(height: 12),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<T>(
                      value: filterByValue,
                      onChanged: (v) => this.onFilterBySelected.call(v),
                      items: filterByItems,
                    ),
                  ),
                ),
                if (filterByValue != null) const SizedBox(height: 16),
                if (filterByValue != null) inputWidget,
                const SizedBox(height: 16),
                RadioDropdown<T1>(
                  label: "Date by",
                  child: dateChild,
                  searchable: false,
                  value: this.dateByValue,
                  onSelected: (v) => this.onDateByChanged.call(v),
                  radioItemBuilder: this.dateByItemBuilder,
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ];
      },
    );
  }
}
