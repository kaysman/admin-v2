import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lng_adminapp/data/models/orders/order.model.dart';
import 'package:lng_adminapp/data/models/shared/ids.model.dart';
import 'package:lng_adminapp/data/services/order.service.dart';

class PrepareOrderBloc extends Cubit<PrepareOrderState> {
  PrepareOrderBloc() : super(PrepareOrderState()) {
    loadOrders();
  }

  loadOrders([String page = "1", String limit = "10"]) async {
    final queryParams = <String, String>{"page": page, "limit": limit};
    emit(state.updateState(prepareOrderStatus: PrepareOrderStatus.loading));
    try {
      var orders = await OrderService.getOrders(queryParams);
      emit(state.updateState(
          prepareOrderStatus: PrepareOrderStatus.idle, orders: orders));
    } catch (_) {
      emit(state.updateState(prepareOrderStatus: PrepareOrderStatus.error));
      throw _;
    }
  }

  downloadAwb(List<Order> selectedOders) async {
    emit(state.updateState(downloadStatus: DownloadStatus.loading));
    ListOfIds data = ListOfIds();

    try {
      data.ids = selectedOders.map((v) => v.id).toList();
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

    // print(data.toJson());
  }
}

enum PrepareOrderStatus { idle, loading, error }
enum DownloadStatus { idle, loading, error, success }

class PrepareOrderState {
  final PrepareOrderStatus prepareOrderStatus;
  final DownloadStatus downloadStatus;
  final OrderList? orders;

  PrepareOrderState({
    this.prepareOrderStatus = PrepareOrderStatus.idle,
    this.downloadStatus = DownloadStatus.idle,
    this.orders,
  });

  PrepareOrderState updateState({
    PrepareOrderStatus? prepareOrderStatus,
    DownloadStatus? downloadStatus,
    OrderList? orders,
  }) {
    return PrepareOrderState(
      prepareOrderStatus: prepareOrderStatus ?? this.prepareOrderStatus,
      downloadStatus: downloadStatus ?? this.downloadStatus,
      orders: orders ?? this.orders,
    );
  }
}
