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
                    _header(context, merchantState),
                    SizedBox(
                      height: 32,
                    ),
                    Expanded(
                      child: LayoutBuilder(builder: (context, constraints) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 45,
                                color: const Color(0xff000000).withOpacity(0.1),
                              ),
                            ],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
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
                                      width: 60,
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
                              ScrollableWidget(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minWidth: constraints.maxWidth,
                                  ),
                                  child: DataTable(
                                    border: TableBorder.all(
                                      width: 1.0,
                                      color: Colors.grey.shade100,
                                    ),
                                    sortColumnIndex: sortColumnIndex,
                                    sortAscending: sortAscending,
                                    columns: tableColumns,
                                    rows: tableRows,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
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

  _header(BuildContext context, MerchantState merchantState) {
    return Row(
      children: [
        Text(
          'Merchants',
          style: Theme.of(context).textTheme.headline1,
        ),
        Spacings.SMALL_HORIZONTAL,
        SizedBox(
          width: 280,
          height: 34,
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
              hintStyle: Theme.of(context).textTheme.headline5?.copyWith(
                    color: kGrey1Color,
                  ),
              prefixIcon: SearchIcon(),
            ),
            onFieldSubmitted: (v) {
              if (v.isNotEmpty) {
                merchantBloc.loadMerchants(
                    PaginationOptions(filter: v, limit: merchantState.perPage));
              }
            },
          ),
        ),
        Spacer(),
        Spacings.SMALL_HORIZONTAL,
        InkWell(
          onTap: () async {
            await merchantBloc.loadMerchants();
          },
          child: Icon(Icons.refresh),
        ),
        Spacings.SMALL_HORIZONTAL,
        Row(
          children: [
            AppIcons.svgAsset(
              AppIcons.help,
            ),
            if (AppService.hasPermission(PermissionType.CREATE_MERCHANT))
              SizedBox(width: 24.w),
            if (AppService.hasPermission(PermissionType.CREATE_MERCHANT))
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
      final merchant = merchants[index];
      final data = [
        "${merchant.merchant?.companyName}",
        "${merchant.firstName} ${merchant.lastName}",
        "${merchant.phoneNumber}",
        "${merchant.merchant?.address?.addressLineOne ?? ''}"
      ];
      final cells = List.generate(
        data.length,
        (index) => DataCell(
          Text(
            data[index],
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          onTap: () => navigateToMerchantDetailsPage(merchant),
        ),
      );

      return DataRow(
        cells: <DataCell>[
          DataCell(
            Center(
              child: Container(
                width: 26,
                height: 26,
                child: CircleAvatar(
                  radius: 20.r,
                  child: merchant.photoUrl == null
                      ? SizedBox()
                      : Image.network(merchant.photoUrl!),
                ),
              ),
            ),
            onTap: () => navigateToMerchantDetailsPage(merchant),
          ),
          ...cells,
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
