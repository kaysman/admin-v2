import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/data/models/orders/filter_parameters.dart';
import 'package:lng_adminapp/data/models/orders/order-column.dart';
import 'package:lng_adminapp/presentation/screens/orders/order.bloc.dart';
import 'package:lng_adminapp/shared.dart';

import '../manage_order.table.dart';

class SelectColumnDialog extends StatefulWidget {
  const SelectColumnDialog({Key? key, required this.selecteds})
      : super(key: key);

  final List<OrderColumn> selecteds;

  @override
  State<SelectColumnDialog> createState() => _SelectColumnDialogState();
}

class _SelectColumnDialogState extends State<SelectColumnDialog> {
  List<OrderColumn> selectedColumns = [];
  List<OrderColumn> pastSelections = [];
  // bool isDefault = true;
  // bool isSelectAll = false;

  late OrderBloc orderBloc;

  @override
  void initState() {
    selectedColumns = widget.selecteds;
    orderBloc = BlocProvider.of<OrderBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 402.w,
      padding: EdgeInsets.symmetric(
        horizontal: 32.w,
        vertical: 24.h,
      ),
      child: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select columns',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 24.h),
              CheckBoxTile(
                title: "Default",
                onPressed: (bool? value) {
                  setState(() {
                    if (value == false) {
                      selectedColumns = pastSelections;
                    } else {
                      pastSelections = selectedColumns;
                      selectedColumns = state.defaultTableColumns ?? [];
                    }
                  });
                },
                value: listEquals(selectedColumns, state.defaultTableColumns),
              ),
              SizedBox(height: 12),
              CheckBoxTile(
                title: "Select all",
                onPressed: (bool? value) {
                  setState(() {
                    if (value == true) {
                      selectedColumns = state.allTableColumns ?? [];
                    } else {
                      selectedColumns = [];
                    }
                  });
                },
                value: listEquals(selectedColumns, state.allTableColumns),
              ),
              SizedBox(height: 24.h),
              Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: state.allTableColumns!.map((e) {
                      return CheckBoxTile(
                        title: e.name,
                        value: selectedColumns.contains(e),
                        onPressed: (bool? newValue) {
                          setState(() {
                            if (newValue == false) {
                              selectedColumns.remove(e);
                            } else if (newValue == true) {
                              selectedColumns.add(e);
                            }
                            // if (listEquals(
                            //     selectedColumns, state.allTableColumns)) {
                            //   this.isSelectAll = true;
                            // } else {
                            //   this.isSelectAll = false;
                            // }
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("Cancel"),
                  ),
                  SizedBox(width: 24),
                  Button(
                    text: "Save",
                    textColor: kWhite,
                    primary: kPrimaryColor,
                    isLoading: state.orderStatus == OrderStatus.loading,
                    onPressed: () async {
                      await orderBloc.loadOrders(
                          OrderFilterParameters(), false, selectedColumns);
                      if (state.orderStatus == OrderStatus.idle) {
                        Navigator.of(context).pop(selectedColumns);
                      }
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
