import 'dart:convert';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/data/models/orders/dropped-file.model.dart';
import 'dart:html' as webfile;
import 'package:lng_adminapp/shared.dart';

class DropzoneWidget extends StatefulWidget {
  final ValueChanged<DroppedFile>? onDroppedFile;
  DropzoneWidget({
    Key? key,
    @required this.onDroppedFile,
  }) : super(key: key);

  @override
  State<DropzoneWidget> createState() => _DropzoneWidgetState();
}

class _DropzoneWidgetState extends State<DropzoneWidget> {
  late DropzoneViewController controller;
  DroppedFile? file;
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: kPrimaryColor,
      borderType: BorderType.RRect,
      dashPattern: [6, 2],
      strokeWidth: 1.w,
      radius: Radius.circular(10.r),
      child: Stack(
        children: [
          Container(
            height: 140.h,
            width: double.infinity,
            color: Colors.transparent,
            child: DropzoneView(
              onDrop: acceptFile,
              onCreated: (controller) => this.controller = controller,
            ),
          ),
          Container(
            width: double.infinity,
            height: 140.h,
            decoration: BoxDecoration(
              color: kSecondaryColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (file != null) ...[
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.w),
                        margin: EdgeInsets.symmetric(horizontal: 40.w),
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(
                            color: kPrimaryColor,
                            width: 2.w,
                          ),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/svg/excel-file.svg'),
                            SizedBox(
                              width: 5.w,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${file?.name}',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                    color: kGrey1Color,
                                  ),
                                ),
                                Text(
                                  '${file?.size}',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                    color: kGrey1Color,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 40.w),
                          padding: EdgeInsets.only(top: 4.w, right: 4.w),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(
                              20.r,
                            ),
                            child: Icon(
                              Icons.cancel,
                              color: kFailedColor,
                              size: 15.w,
                            ),
                            onTap: () {
                              removeDroppedFile();
                            },
                          ),
                        ),
                      )
                    ],
                  )
                ] else ...[
                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: "Drop your file(s) here or ",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: kGrey1Color,
                        ),
                        children: [
                          TextSpan(
                            text: "browse",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                final events =
                                    await controller.pickFiles(mime: ['.xlsx']);
                                if (events.isEmpty) return;

                                acceptFile(events.first);
                              },
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                              color: kPrimaryColor,
                            ),
                          ),
                          TextSpan(
                            text: "\n\nFiles supported: Xlsx",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ]
              ],
            ),
          )
        ],
      ),
    );
  }

  Future acceptFile(dynamic event) async {
    final name = event.name;
    final mime = await controller.getFileMIME(event);
    final bytes = await controller.getFileSize(event);
    final url = await controller.createFileUrl(event);
    // controller.
    final data = await controller.getFileData(event);
    final byteData = await data;

    final base64String = base64.encode(await data);
    final droppedFile = DroppedFile(
      url: url,
      name: name,
      mime: mime,
      bytes: bytes,
      base64String: base64String,
    );

    setState(() {
      file = droppedFile;
    });
    widget.onDroppedFile!(droppedFile);
  }

  removeDroppedFile() {
    setState(() {
      file = null;
    });
  }
}
