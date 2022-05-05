import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/data/models/meta.model.dart';
import 'package:lng_adminapp/data/models/pagination_options.dart';
import 'package:lng_adminapp/data/models/user.model.dart';
import 'package:lng_adminapp/data/services/user.service.dart';
import 'package:lng_adminapp/presentation/screens/dialog/delete/delete-dialog.bloc.dart';
import 'package:lng_adminapp/presentation/screens/merchants/create-merchant/create-merchant.view.dart';
import 'package:lng_adminapp/presentation/screens/merchants/merchant-information/merchant-information.view.dart';
import 'package:lng_adminapp/presentation/screens/merchants/merchants.bloc.dart';
import 'package:lng_adminapp/presentation/screens/orders/manage_order_table/manage_order.table.dart';
import 'package:lng_adminapp/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/enums/status.enum.dart';
import '../../../../data/services/app.service.dart';
import '../../../shared/components/search_icon.dart';

class ListMerchants extends StatelessWidget {
  static const String routeName = 'manage-merchants';
  const ListMerchants({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MerchantList();
  }
}

class MerchantList extends StatefulWidget {
  const MerchantList({Key? key}) : super(key: key);

  @override
  _MerchantListState createState() => _MerchantListState();
}

class _MerchantListState extends State<MerchantList> {
  int sortColumnIndex = 0;
  bool sortAscending = true;
  late MerchantBloc merchantBloc;
  List<String> headers = [
    'Photo',
    'Company Name',
    'Merchant Name',
    'Phone',
    'Address'
  ];

  @override
  void initState() {
    // TODO: implement initState
    merchantBloc = context.read<MerchantBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyBackground,
      body: Container(
        margin: EdgeInsets.all(Spacings.kSpaceLittleBig),
        child: BlocBuilder<MerchantBloc, MerchantState>(
          bloc: merchantBloc,
          builder: (context, merchantState) {
            var _listMerchantStatus = merchantState.listMerchantStatus;
            var _merchants = merchantState.merchantItems;
            var _meta = merchantState.merchants?.meta;

            if (_listMerchantStatus == ListMerchantStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (_listMerchantStatus == ListMerchantStatus.error) {
              return TryAgainButton(
                tryAgain: () async {
                  await merchantBloc.loadMerchants();
                },
              );
            }

            return BlocConsumer<DeleteDialogBloc, DeleteDialogState>(
              listener: (context, deleteDialogState) {
                if (deleteDialogState.deleteMerchantStatus ==
                    DeleteMerchantStatus.success) {
                  merchantBloc.loadMerchants();
                }
              },
              listenWhen: (state1, state2) => state1 != state2,
              builder: (context, state) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 0.35.sw,
                          child: Row(
                            children: [
                              Text(
                                'Merchants',
                                style: GoogleFonts.inter(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                width: 24,
                              ),
                              Expanded(
                                child: TextFormField(
                                  style: Theme.of(context).textTheme.bodyText1,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 16,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: const BorderSide(
                                        color: kWhite,
                                        width: 0.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: BorderSide(
                                          color: kPrimaryColor,
                                          width: 0.0,
                                        )),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: const BorderSide(
                                        color: kWhite,
                                        width: 0.0,
                                      ),
                                    ),
                                    hintText: 'Search',
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        ?.copyWith(
                                          color: kGrey1Color,
                                        ),
                                    prefixIcon: SearchIcon(),
                                  ),
                                  onFieldSubmitted: (v) {
                                    if (v.isNotEmpty) {
                                      merchantBloc.loadMerchants(
                                          PaginationOptions(
                                              filter: v,
                                              limit: merchantState.perPage));
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            AppIcons.svgAsset(
                              AppIcons.help,
                            ),
                            if (AppService.hasPermission(
                                PermissionType.CREATE_MERCHANT))
                              SizedBox(width: 24.w),
                            if (AppService.hasPermission(
                                PermissionType.CREATE_MERCHANT))
                              Button(
                                primary: Theme.of(context).primaryColor,
                                text: 'Add New Merchant',
                                textColor: kWhite,
                                permissions: [PermissionType.CREATE_MERCHANT],
                                onPressed: () {
                                  UserService.selectedMerchant.value = null;
                                  Navigator.pushNamed(
                                    context,
                                    CreateMerchant.routeName,
                                  );
                                },
                              ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 45,
                                color: const Color(0xff000000).withOpacity(0.1),
                              ),
                            ],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(32, 8, 32, 8),
                              child: Row(
                                children: [
                                  Text(
                                    '${_merchants?.length} merchants available',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  Spacer(),
                                  Text(
                                    'Results per page',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  Spacings.SMALL_HORIZONTAL,
                                  SizedBox(
                                    width: 85,
                                    child: DecoratedDropdown<int>(
                                      value: merchantState.perPage,
                                      icon: null,
                                      items: [10, 20, 50],
                                      onChanged: (v) {
                                        if (v != null) {
                                          merchantBloc.setPerPageAndLoad(v);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Table view
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 32.w,
                                  vertical: 14.h,
                                ),
                                child: ScrollableWidget(
                                  child: DataTable(
                                    dataRowHeight: 56.h,
                                    headingRowColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return kSecondaryColor
                                              .withOpacity(0.6);
                                        }
                                        return kSecondaryColor;
                                      },
                                    ),
                                    dataRowColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return kGrey5Color;
                                        }
                                        return kWhite;
                                      },
                                    ),
                                    headingTextStyle: GoogleFonts.inter(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    dataTextStyle: GoogleFonts.inter(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    border: TableBorder.all(
                                      width: 1.0,
                                      color: Colors.grey.shade100,
                                    ),
                                    columnSpacing: 120.w,
                                    horizontalMargin: 12.w,
                                    dividerThickness: 0.4.sp,
                                    showBottomBorder: false,
                                    headingRowHeight: 34.h,
                                    sortColumnIndex: sortColumnIndex,
                                    sortAscending: sortAscending,
                                    columns: tableColumns,
                                    rows: tableRows,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Pagination(
                      metaData: _meta,
                      goPrevious: () => loadPrevious(_meta),
                      goNext: () => loadNext(_meta),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  get tableColumns {
    return List.generate(headers.length, (index) {
      var name = headers[index];
      return DataColumn(label: Text(name));
    });
  }

  get tableRows {
    List<User>? merchants = merchantBloc.state.merchantItems;
    return List.generate(merchants!.length, (index) {
      var merchant = merchants[index];
      return DataRow(
        cells: <DataCell>[
          DataCell(
            SizedBox(
              width: 25.w,
              height: 25.w,
              child: merchant.photoUrl != null
                  ? Image.network(merchant.photoUrl!, height: 30.r, width: 30.r)
                  : CircleAvatar(
                      radius: 20.r,
                      backgroundImage: AssetImage('assets/wwe.png'),
                    ),
            ),
            onTap: () => navigateToMerchantDetailsPage(merchant),
          ),
          DataCell(
            Text("${merchant.merchant?.companyName}",
                style: Theme.of(context).textTheme.bodyText1),
            onTap: () => navigateToMerchantDetailsPage(merchant),
          ),
          DataCell(
            Text("${merchant.firstName} ${merchant.lastName}",
                style: Theme.of(context).textTheme.bodyText1),
            onTap: () => navigateToMerchantDetailsPage(merchant),
          ),
          DataCell(
            Text("${merchant.countryCode}${merchant.phoneNumber}",
                style: Theme.of(context).textTheme.bodyText1),
            onTap: () => navigateToMerchantDetailsPage(merchant),
          ),
          DataCell(
            Text("${merchant.merchant?.address?.addressLineOne ?? ''}",
                style: Theme.of(context).textTheme.bodyText1),
            onTap: () => navigateToMerchantDetailsPage(merchant),
          ),
        ],
      );
    });
  }

  loadPrevious(Meta? meta) async {
    var previous = (meta!.currentPage - 1);
    await context
        .read<MerchantBloc>()
        .loadMerchants(PaginationOptions(page: previous));
  }

  loadNext(Meta? meta) async {
    var next = (meta!.currentPage + 1);
    await context
        .read<MerchantBloc>()
        .loadMerchants(PaginationOptions(page: next));
  }

  navigateToMerchantDetailsPage(data) {
    UserService.selectedMerchant.value = data;
    Navigator.pushNamed(context, MerchantInformation.routeName);
  }
}
