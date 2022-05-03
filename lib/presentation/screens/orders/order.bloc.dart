import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/data/models/orders/filter_parameters.dart';
import 'package:lng_adminapp/data/models/orders/order.model.dart';
import 'package:lng_adminapp/data/models/orders/get-mapping.model.dart';
import 'package:lng_adminapp/data/models/orders/mapping-response.model.dart';
import 'package:lng_adminapp/data/models/orders/single-order-upload.model.dart';
import 'package:lng_adminapp/data/services/order.service.dart';
import 'package:lng_adminapp/presentation/screens/dialog/enums/dialog.enum.dart';
import 'package:lng_adminapp/presentation/screens/dialog/response/response-dialog.view.dart';
import 'package:lng_adminapp/shared.dart';

enum OrderStatus { idle, loading, error }
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
  final MappingResponse? mappingResponse;

  final OrderFilterType? filterByValue;
  final DateRangeType? dateByValue;

  OrderState({
    this.orderStatus = OrderStatus.idle,
    this.createSingleOrderStatus = CreateSingleOrderStatus.idle,
    this.updateSingleOrderStatus = UpdateSingleOrderStatus.idle,
    this.createMultipleOrderStatus = CreateMultipleOrderStatus.idle,
    this.deleteMultipleOrderStatus = DeleteMultipleOrderStatus.idle,
    this.getMappingStatus = GetMappingStatus.idle,
    this.orders,
    this.mappingResponse,
    this.filterByValue,
    this.dateByValue,
  });

  OrderState updateOrderState({
    OrderStatus? orderStatus,
    CreateSingleOrderStatus? createSingleOrderStatus,
    UpdateSingleOrderStatus? updateSingleOrderStatus,
    CreateMultipleOrderStatus? createMultipleOrderStatus,
    DeleteMultipleOrderStatus? deleteMultipleOrderStatus,
    OrderList? orders,
    GetMappingStatus? getMappingStatus,
    MappingResponse? mappingResponse,
    OrderFilterType? filterByValue,
    DateRangeType? dateRangeType,
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
      mappingResponse: mappingResponse ?? this.mappingResponse,
      updateSingleOrderStatus:
          updateSingleOrderStatus ?? this.updateSingleOrderStatus,
      filterByValue: filterByValue ?? this.filterByValue,
      dateByValue: dateRangeType ?? this.dateByValue,
    );
  }
}

class OrderBloc extends Cubit<OrderState> {
  OrderBloc() : super(OrderState(orderStatus: OrderStatus.loading)) {
    loadOrders(OrderFilterParameters(page: "60", limit: "4"));
  }

  loadOrders(
      [OrderFilterParameters params =
          const OrderFilterParameters(page: "60", limit: "4")]) async {
    OrderService.currentPage.value = params.page;
    emit(state.updateOrderState(orderStatus: OrderStatus.loading));
    try {
      var orders = await OrderService.getOrders(params.toJson());
      emit(state.updateOrderState(
          orderStatus: OrderStatus.idle, orders: orders));
    } catch (_) {
      print(_.toString());
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
              loadOrders(
                OrderFilterParameters(
                  page: OrderService.currentPage.value!,
                  limit: "4",
                ),
              );
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
        print(_mappingResponse.id);
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
      print(result);
      if (result.success == true) {
        emit(state.updateOrderState(
            createMultipleOrderStatus: CreateMultipleOrderStatus.success));
        loadOrders(
          OrderFilterParameters(
            page: OrderService.currentPage.value!,
            limit: "4",
          ),
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
      if (result.success == true) {
        showWhiteDialog(
          context,
          ResponseDialog(
            type: DialogType.SUCCESS,
            message: result.message,
            onClose: () {
              emit(
                state.updateOrderState(
                  updateSingleOrderStatus: UpdateSingleOrderStatus.success,
                ),
              );
              Navigator.pop(context);
              Navigator.pop(context);
              loadOrders(
                OrderFilterParameters(
                  page: OrderService.currentPage.value!,
                  limit: "4",
                ),
              );
            },
          ),
        );
        OrderService.selectedOrder.value = result.data;
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
          OrderFilterParameters(
            page: OrderService.currentPage.value!,
            limit: "4",
          ),
        );
      print(response);
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
}
