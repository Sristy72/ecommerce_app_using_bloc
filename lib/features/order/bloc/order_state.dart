import 'package:ecommerce_app_using_bloc/features/order/data/models/response/get_order_by_id_response_model.dart';

enum OrderStatus { initial, loading, loaded, failure }

class OrderState {
  final OrderStatus status;
  final List<Order> orders;
  final String errorMessage;

  const OrderState({
    this.status = OrderStatus.initial,
    this.orders = const [],
    this.errorMessage = '',
  });

  OrderState copyWith({
    OrderStatus? status,
    List<Order>? orders,
    String? errorMessage,
  }) {
    return OrderState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}