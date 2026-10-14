import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_using_bloc/features/order/data/repositories/order_repositories.dart';

import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;

  OrderBloc({required this.orderRepository}) : super(const OrderState()) {
    on<FetchOrdersEvent>(_onFetchOrders);
  }

  Future<void> _onFetchOrders(
    FetchOrdersEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(status: OrderStatus.loading));
    try {
      final response = await orderRepository.getOrder('');
      emit(state.copyWith(
        status: OrderStatus.loaded,
        orders: response.orders,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: OrderStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
