import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lng_adminapp/presentation/screens/dialog/delete/delete-dialog.bloc.dart';
import 'package:lng_adminapp/presentation/screens/dialog/enums/dialog.enum.dart';
import 'package:lng_adminapp/presentation/shared/colors.dart';
import 'package:lng_adminapp/presentation/shared/components/button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/foundation.dart';

class DeleteDialog extends StatefulWidget {
  final String? title;
  final String? message;
  final DialogType? type;
  final ModuleType? module;
  final String? id;

  DeleteDialog({
    Key? key,
    @required this.title,
    @required this.message,
    @required this.type,
    @required this.module,
    @required this.id,
  }) : super(key: key);

  @override
  _DeleteDialogState createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  late DeleteDialogBloc deleteDialogBloc;
  final inputController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    deleteDialogBloc = context.read<DeleteDialogBloc>();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
      ),
      width: 410.w,
      child: BlocBuilder<DeleteDialogBloc, DeleteDialogState>(
        bloc: deleteDialogBloc,
        builder: (context, deleteDialogState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${widget.title}",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: kFailedColor),
              ),
              SizedBox(height: 16.h),
              Text(
                "${widget.message}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(height: 32.sp),
              Text(
                "Please type '${describeEnum(widget.type!)}${describeEnum(widget.module!)}' if you would like to confirm delete",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(height: 16.sp),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 32.sp,
                      child: TextField(
                        controller: inputController,
                        onChanged: (v) => deleteDialogBloc.validateString(
                          widget.type!,
                          widget.module!,
                          v,
                        ),
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 8.sp,
                            horizontal: 12.sp,
                          ),
                          hintText: "Type here",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.sp),
                  Button(
                    elevation: 0,
                    text: "Delete",
                    hasBorder: true,
                    textColor: kFailedColor,
                    borderColor: kFailedColor,
                    isLoading: deleteDialogBloc.state.deleteDialogStatus ==
                        DeleteDialogStatus.loading,
                    onPressed: () => deleteDialogBloc.action(
                      widget.type!,
                      widget.module!,
                      inputController.text,
                      widget.id!,
                      context,
                    ),
                    isDisabled: deleteDialogBloc.state.deleteDialogStatus ==
                            DeleteDialogStatus.inactive
                        ? true
                        : false,
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
