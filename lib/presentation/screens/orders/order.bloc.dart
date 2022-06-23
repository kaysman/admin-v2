import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/data/models/orders/filter_parameters.dart';
import 'package:lng_adminapp/data/models/orders/order-column.dart';
import 'package:lng_adminapp/data/models/orders/order.model.dart';
import 'package:lng_adminapp/data/models/orders/get-mapping.model.dart';
import 'package:lng_adminapp/data/models/orders/mapping-response.model.dart';
import 'package:lng_adminapp/data/models/orders/single-order-upload.model.dart';
import 'package:lng_adminapp/data/services/app.service.dart';
import 'package:lng_adminapp/data/services/order.service.dart';
import 'package:lng_adminapp/presentation/blocs/snackbar.bloc.dart';
import 'package:lng_adminapp/presentation/screens/dialog/enums/dialog.enum.dart';
import 'package:lng_adminapp/presentation/screens/dialog/response/response-dialog.view.dart';
import 'package:lng_adminapp/shared.dart';

enum OrderStatus { idle, loading, filtering, error }

enum CreateSingleOrderStatus { idle, loading, error, success }

enum UpdateSingleOrderStatus { idle, loading, error, success }

enum DeleteMultipleOrderStatus { idle, loading, error, success }

enum GetMappingStatus { idle, loading, error, success }

enum CreateMultipleOrderStatus { idle, loading, error, success }

enum AssigningDriverStatus { idle, loading, error, success }

class OrderState {
  final OrderStatus orderStatus;
  final CreateSingleOrderStatus createSingleOrderStatus;
  final UpdateSingleOrderStatus updateSingleOrderStatus;
  final CreateMultipleOrderStatus createMultipleOrderStatus;
  final DeleteMultipleOrderStatus deleteMultipleOrderStatus;
  final GetMappingStatus getMappingStatus;
  final OrderList? orders;
  final List<Map<String, dynamic>>? orderItems;
  final Map<String, int> statusGroup;
  final MappingResponse? mappingResponse;

  final OrderFilterType? filterByValue;
  final DateRangeType? dateByValue;

  final List<OrderColumn>? allTableColumns;
  final List<OrderColumn>? defaultTableColumns;
  final List<OrderColumn> selectedColumns;

  OrderState({
    this.orderStatus = OrderStatus.idle,
    this.createSingleOrderStatus = CreateSingleOrderStatus.idle,
    this.updateSingleOrderStatus = UpdateSingleOrderStatus.idle,
    this.createMultipleOrderStatus = CreateMultipleOrderStatus.idle,
    this.deleteMultipleOrderStatus = DeleteMultipleOrderStatus.idle,
    this.getMappingStatus = GetMappingStatus.idle,
    this.orders,
    this.orderItems,
    this.mappingResponse,
    this.filterByValue,
    this.dateByValue,
    this.allTableColumns,
    this.defaultTableColumns,
    this.selectedColumns = const [],
    this.statusGroup = const {},
  });

  OrderState updateOrderState({
    OrderStatus? orderStatus,
    CreateSingleOrderStatus? createSingleOrderStatus,
    UpdateSingleOrderStatus? updateSingleOrderStatus,
    CreateMultipleOrderStatus? createMultipleOrderStatus,
    DeleteMultipleOrderStatus? deleteMultipleOrderStatus,
    OrderList? orders,
    List<Map<String, dynamic>>? orderItems,
    GetMappingStatus? getMappingStatus,
    MappingResponse? mappingResponse,
    OrderFilterType? filterByValue,
    DateRangeType? dateRangeType,
    List<OrderColumn>? defaultTableColumns,
    List<OrderColumn>? allTableColumns,
    List<OrderColumn>? selectedColumns,
    Map<String, int>? statusGroup,
  }) {
    return OrderState(
      orderStatus: orderStatus ?? this.orderStatus,
      createSingleOrderStatus:
          createSingleOrderStatus ?? this.createSingleOrderStatus,
      createMultipleOrderStatus:
          createMultipleOrderStatus ?? this.createMultipleOrderStatus,
      deleteMultipleOrderStatus:
          deleteMultipleOrderStatus ?? this.deleteMultipleOrderStatus,
      orders: orders ?? this.orders,
      getMappingStatus: getMappingStatus ?? this.getMappingStatus,
      statusGroup: statusGroup ?? this.statusGroup,
      mappingResponse: mappingResponse ?? this.mappingResponse,
      updateSingleOrderStatus:
          updateSingleOrderStatus ?? this.updateSingleOrderStatus,
      filterByValue: filterByValue ?? this.filterByValue,
      dateByValue: dateRangeType ?? this.dateByValue,
      orderItems: orderItems ?? this.orderItems,
      defaultTableColumns: defaultTableColumns ?? this.defaultTableColumns,
      allTableColumns: allTableColumns ?? this.allTableColumns,
      selectedColumns: selectedColumns ?? this.selectedColumns,
    );
  }
}

class OrderBloc extends Cubit<OrderState> {
  OrderBloc() : super(OrderState(orderStatus: OrderStatus.idle));

  Future<void> loadOrders([
    OrderFilterParameters params = const OrderFilterParameters(),
    bool loadColumns = false,
    List<OrderColumn>? columns,
    bool subtle = false,
  ]) async {
    OrderService.currentPage.value = params.page;
    var map = params.toJson();
    print(params.toJson());
    emit(state.updateOrderState(
      orderStatus: subtle ? OrderStatus.filtering : OrderStatus.loading,
    ));
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

      emit(state.updateOrderState(
        orderStatus: OrderStatus.idle,
        orders: orders,
        orderItems: orders.items,
        allTableColumns: allColumns,
        defaultTableColumns: defaultColumns,
        selectedColumns: selecteds,
        statusGroup: statuses,
      ));
    } catch (_) {
      emit(state.updateOrderState(orderStatus: OrderStatus.error));
      throw _;
    }
  }

  createSingleOrder(SingleOrderUploadModel data, BuildContext context) async {
    emit(
      state.updateOrderState(
          createSingleOrderStatus: CreateSingleOrderStatus.loading),
    );

    try {
      var result = await OrderService.createSingleOrder(data);
      if (result.success == true) {
        showWhiteDialog(
          context,
          ResponseDialog(
            type: DialogType.SUCCESS,
            message: result.message,
            onClose: () {
              emit(
                state.updateOrderState(
                  createSingleOrderStatus: CreateSingleOrderStatus.success,
                ),
              );
              Navigator.pop(context);
              Navigator.pop(context);
              loadOrders();
            },
          ),
        );
      } else {
        showWhiteDialog(
          context,
          ResponseDialog(
            type: DialogType.ERROR,
            message: result.message,
            onClose: () {},
          ),
        );
      }
      emit(state.updateOrderState(
          createSingleOrderStatus: CreateSingleOrderStatus.idle));
    } catch (error) {
      emit(
        state.updateOrderState(
            createSingleOrderStatus: CreateSingleOrderStatus.idle),
      );
    }
  }

  getMapping(GetMapping data) async {
    emit(state.updateOrderState(getMappingStatus: GetMappingStatus.loading));
    try {
      var result = await OrderService.getMapping(data);
      if (result.success == true) {
        final _mappingResponse = MappingResponse.fromJson(result.data);

        emit(state.updateOrderState(
          mappingResponse: _mappingResponse,
          getMappingStatus: GetMappingStatus.success,
        ));
      } else {
        emit(state.updateOrderState(getMappingStatus: GetMappingStatus.idle));
      }
    } catch (error) {
      emit(state.updateOrderState(getMappingStatus: GetMappingStatus.idle));
    }
  }

  createMultipleOrders(FilledMappingRequest data) async {
    emit(state.updateOrderState(
        createMultipleOrderStatus: CreateMultipleOrderStatus.loading));

    try {
      var result = await OrderService.createMultipleOrders(data);

      if (result.success == true) {
        emit(state.updateOrderState(
            createMultipleOrderStatus: CreateMultipleOrderStatus.success));
        loadOrders(
          OrderFilterParameters(page: OrderService.currentPage.value!),
        );
      } else {
        emit(state.updateOrderState(
            createMultipleOrderStatus: CreateMultipleOrderStatus.idle));
      }
    } catch (error) {
      emit(state.updateOrderState(
          createMultipleOrderStatus: CreateMultipleOrderStatus.idle));
    }
  }

  updateOrder(UpdateSingleOrderModel data, BuildContext context) async {
    emit(
      state.updateOrderState(
        updateSingleOrderStatus: UpdateSingleOrderStatus.loading,
      ),
    );
              
    try {
      var result = await OrderService.updateSingleOrder(data);
      if (result.code == 200) {
        emit(
          state.updateOrderState(
              updateSingleOrderStatus: UpdateSingleOrderStatus.success),
        );
        OrderService.selectedOrder.value = result.data;
        AppService.showSnackbar!("Order updated", SnackbarType.success);
      } else {
        AppService.showSnackbar!(
            "Error while updating order", SnackbarType.error);
      }
      emit(state.updateOrderState(
          updateSingleOrderStatus: UpdateSingleOrderStatus.idle));
    } catch (error) {
      emit(
        state.updateOrderState(
            updateSingleOrderStatus: UpdateSingleOrderStatus.error),
      );
    }
  }

  deleteOrders(List<String> orderIDs) async {
    emit(state.updateOrderState(
        deleteMultipleOrderStatus: DeleteMultipleOrderStatus.loading));
    try {
      var response = await OrderService.deleteMultipleOrders(orderIDs);
      emit(state.updateOrderState(
          deleteMultipleOrderStatus: DeleteMultipleOrderStatus.idle));
      if (response.success == true)
        await this.loadOrders(
          OrderFilterParameters(page: OrderService.currentPage.value!),
        );
    } catch (_) {
      emit(state.updateOrderState(
          deleteMultipleOrderStatus: DeleteMultipleOrderStatus.error));
    }
  }

  setFilterData({DateRangeType? date, OrderFilterType? filter}) {
    emit(state.updateOrderState(
      filterByValue: filter,
      dateRangeType: date,
    ));
  }

  sortOrders(bool sortAsc) {
    var orders = state.orders?.items;
    if (orders != null) {
      // orders.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      if (!sortAsc) orders = orders.reversed.toList();
      emit(state.updateOrderState(
          orders: OrderList(
        items: orders,
        meta: state.orders?.meta,
      )));
    }
  }
}
