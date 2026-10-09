import 'package:ecommerce_app_using_bloc/core/network/api_client.dart';
import 'package:ecommerce_app_using_bloc/core/network/constants/api_constant.dart';
import 'package:ecommerce_app_using_bloc/features/auth/data/models/request/register_request_model.dart';
import 'package:ecommerce_app_using_bloc/features/auth/data/models/response/register_response_model.dart';
import 'package:ecommerce_app_using_bloc/features/home/data/models/response/get_category_response_model.dart';
import 'package:ecommerce_app_using_bloc/features/home/data/models/response/get_popular_items_response_model.dart';

class HomeRepository {
  final ApiClient apiClient;


  HomeRepository({required this.apiClient});

  Future<GetPopularItemResponseModel> getAllPopular(String day) async {
    final response = await apiClient.get(ApiConstants.popular(day));

    final getItem = GetPopularItemResponseModel.fromJson(response.data);

    return getItem;
  }
  Future<GetCategoryResponseModel> fetchCategory() async {
    final response = await apiClient.get(ApiConstants.category);

    final getCategory = GetCategoryResponseModel.fromJson(response.data);

    return getCategory;
  }

  Future<RegisterResponseModel> signUp(RegisterRequestModel register)async{
    final response =  await apiClient.post(ApiConstants.register, data: register.toJson());

    final registerResponse = RegisterResponseModel.fromJson(response.data);

    return registerResponse;
  }

}