import 'package:ecommerce_app_using_bloc/core/network/api_client.dart';
import 'package:ecommerce_app_using_bloc/features/order/data/models/response/get_order_by_id_response_model.dart';
import '../../../../core/network/constants/api_constant.dart';

class OrderRepository {
  final ApiClient apiClient;

  OrderRepository({required this.apiClient});

  Future<GetOrderByIdResponseModel> getOrder(String userId) async {
    final response = await apiClient.get(ApiConstants.fetchOrder);
    return GetOrderByIdResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

}