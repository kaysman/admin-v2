import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/data/models/orders/filter_parameters.dart';
import 'package:lng_adminapp/data/models/orders/order-column.dart';
import 'package:lng_adminapp/data/models/orders/order.model.dart';
import 'package:lng_adminapp/data/models/shared/ids.model.dart';
import 'package:lng_adminapp/data/services/order.service.dart';

class PrepareOrderBloc extends Cubit<PrepareOrderState> {
  PrepareOrderBloc() : super(PrepareOrderState()) {
    loadOrders(OrderFilterParameters(), true);
  }

  loadOrders([
    OrderFilterParameters params = const OrderFilterParameters(),
    bool loadColumns = false,
    List<OrderColumn>? columns,
  ]) async {
    OrderService.currentPage.value = params.page;
    var map = params.toJson();
    emit(state.updateState(prepareOrderStatus: PrepareOrderStatus.loading));
    try {
      var defaultColumns = state.defaultTableColumns;
      var allColumns = state.allTableColumns;
      var selecteds = state.selectedColumns;

      if (loadColumns) {
        defaultColumns = await OrderService.getTableColumns(true);
        allColumns = await OrderService.getTableColumns(false);
      }

      if (columns != null) {
        selecteds = columns;
        map['requiredColumns'] = columns.map((e) => e.name).toList().toString();
      } else if (selecteds.isEmpty && defaultColumns != null) {
        selecteds = defaultColumns;
        map['requiredColumns'] =
            defaultColumns.map((e) => e.name).toList().toString();
      }

      var responseData = await OrderService.getOrders(map);
      var orders = OrderList.fromJson(responseData['ordersFormated']);
      Map<String, int> statuses = {};
      responseData.keys.forEach((e) {
        if (e != "ordersFormated") {
          statuses[getEnumTypeByPlainText(e)] = responseData[e];
        }
      });

      emit(state.updateState(
        prepareOrderStatus: PrepareOrderStatus.idle,
        orders: orders,
        allTableColumns: allColumns,
        defaultTableColumns: defaultColumns,
        selectedColumns: selecteds,
        statusGroup: statuses,
      ));
    } catch (_) {
      emit(state.updateState(prepareOrderStatus: PrepareOrderStatus.error));
      throw _;
    }
  }

  downloadAwb(List<String> selectedOders) async {
    emit(state.updateState(downloadStatus: DownloadStatus.loading));
    ListOfIds data = ListOfIds();

    try {
      data.ids = selectedOders;
      var result = await OrderService.printShippingLabels(data);

      if (result == true) {
        emit(state.updateState(downloadStatus: DownloadStatus.idle));
      } else {
        emit(state.updateState(downloadStatus: DownloadStatus.error));
      }
    } catch (_) {
      emit(state.updateState(downloadStatus: DownloadStatus.error));
      throw _;
    }

    //
  }

  sortOrders(bool sortAsc) {
    var orders = state.orders?.items;
    if (orders != null) {
      // orders.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      if (!sortAsc) orders = orders.reversed.toList();
      emit(state.updateState(
          orders: OrderList(
        items: orders,
        meta: state.orders?.meta,
      )));
    }
  }
}

enum PrepareOrderStatus { idle, loading, error }

enum DownloadStatus { idle, loading, error, success }

class PrepareOrderState {
  final PrepareOrderStatus prepareOrderStatus;
  final DownloadStatus downloadStatus;
  final OrderList? orders;

  final List<OrderColumn>? allTableColumns;
  final List<OrderColumn>? defaultTableColumns;
  final List<OrderColumn> selectedColumns;
  final Map<String, int> statusGroup;

  PrepareOrderState({
    this.prepareOrderStatus = PrepareOrderStatus.idle,
    this.downloadStatus = DownloadStatus.idle,
    this.orders,
    this.allTableColumns,
    this.defaultTableColumns,
    this.selectedColumns = const [],
    this.statusGroup = const {},
  });

  PrepareOrderState updateState({
    PrepareOrderStatus? prepareOrderStatus,
    DownloadStatus? downloadStatus,
    OrderList? orders,
    List<OrderColumn>? defaultTableColumns,
    List<OrderColumn>? allTableColumns,
    List<OrderColumn>? selectedColumns,
    Map<String, int>? statusGroup,
  }) {
    return PrepareOrderState(
      prepareOrderStatus: prepareOrderStatus ?? this.prepareOrderStatus,
      downloadStatus: downloadStatus ?? this.downloadStatus,
      orders: orders ?? this.orders,
      defaultTableColumns: defaultTableColumns ?? this.defaultTableColumns,
      allTableColumns: allTableColumns ?? this.allTableColumns,
      selectedColumns: selectedColumns ?? this.selectedColumns,
      statusGroup: statusGroup ?? this.statusGroup,
    );
  }
}
