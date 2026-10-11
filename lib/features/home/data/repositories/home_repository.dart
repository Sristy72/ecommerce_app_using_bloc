import 'package:ecommerce_app_using_bloc/core/network/api_client.dart';
import 'package:ecommerce_app_using_bloc/core/network/constants/api_constant.dart';
import 'package:ecommerce_app_using_bloc/features/home/data/models/requests/remove_cart_request_model.dart';
import 'package:ecommerce_app_using_bloc/features/home/data/models/response/get_category_response_model.dart';
import 'package:ecommerce_app_using_bloc/features/home/data/models/response/get_item_by_category_id_response_model.dart';
import 'package:ecommerce_app_using_bloc/features/home/data/models/response/get_popular_items_response_model.dart';
import 'package:ecommerce_app_using_bloc/features/home/data/models/response/remove_cart_response_model.dart';

import '../models/requests/add_item_tocart_request_model.dart';
import '../models/response/add_cart_response_model.dart';

class HomeRepository {
  final ApiClient apiClient;


  HomeRepository({required this.apiClient});

  Future<GetPopularItemResponseModel> getPopular(String day) async {
    final response = await apiClient.get(ApiConstants.popular(day));

    final getItem = GetPopularItemResponseModel.fromJson(response.data);

    return getItem;
  }

  Future<GetPopularItemResponseModel> getAllPopularItems() async {
    final response = await apiClient.get(ApiConstants.allPopular());

    // The /items endpoint wraps the payload inside a "data" key:
    // { success, message, data: { total, page, pages, items } }
    final payload = (response.data is Map && response.data['data'] != null)
        ? response.data['data'] as Map<String, dynamic>
        : response.data as Map<String, dynamic>;

    final getItem = GetPopularItemResponseModel.fromJson(payload);

    return getItem;
  }
  Future<GetCategoryResponseModel> fetchCategory() async {
    final response = await apiClient.get(ApiConstants.category);

    final getCategory = GetCategoryResponseModel.fromJson(response.data);

    return getCategory;
  }
  Future<GetItemByCategoryIdResponseModel> fetchSpecificItem(String categoryId, {int limit = 100}) async {
    final response = await apiClient.get(ApiConstants.items(categoryId));

    final getItems = GetItemByCategoryIdResponseModel.fromJson(response.data);

    return getItems;
  }

  Future<AddCartResponseModel> addToCart(AddItemRequest request) async {
    final response = await apiClient.post(ApiConstants.addCart, data: request.toJson());
    final addCartResponse = AddCartResponseModel.fromJson(response.data);
    return addCartResponse;
  }

  Future<RemoveCartResponseModel> removeCart(RemoveCartRequestModel request) async {
    final response = await apiClient.put(ApiConstants.removeCart, data: request.toJson());
    final removeCartResponse = RemoveCartResponseModel.fromJson(response.data);
    return removeCartResponse;
  }

}