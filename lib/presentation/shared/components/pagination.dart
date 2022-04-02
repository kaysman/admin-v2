import 'package:flutter/material.dart';
import 'package:lng_adminapp/data/models/meta.model.dart';

import '../colors.dart';

class Pagination extends StatelessWidget {
  const Pagination({
    Key? key,
    this.metaData,
    required this.goPrevious,
    required this.goNext,
  }) : super(key: key);

  final Meta? metaData;
  final Function goPrevious;
  final Function goNext;

  Future<void> fetchPage(Meta? meta, [toPrevious = false]) async {
    if (meta != null) {
      if (toPrevious && meta.hasPrevious)
        this.goPrevious();
      else if (meta.hasNext) this.goNext();
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    var _meta = metaData;
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Divider(
            indent: 0,
            endIndent: 0,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (_meta != null && _meta.hasPrevious)
              InkWell(
                onTap: () => fetchPage(_meta, true),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: kPrimaryColor,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Previous",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ],
                ),
              ),
            SizedBox(width: 8),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  const Radius.circular(6),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: Text(
                  "${_meta?.currentPage}",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
            ),
            if (_meta?.totalPages != null) SizedBox(width: 8),
            if (_meta?.totalPages != null)
              Text(
                "out of ${_meta?.totalPages}",
                style: Theme.of(context).textTheme.headline4,
              ),
            SizedBox(width: 16),
            if (_meta != null && _meta.hasNext)
              InkWell(
                onTap: () => fetchPage(_meta),
                child: Row(
                  children: [
                    Text(
                      "Next",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: kPrimaryColor,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}
