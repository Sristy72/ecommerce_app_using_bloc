import 'package:ecommerce_app_using_bloc/core/network/api_client.dart';
import 'package:ecommerce_app_using_bloc/core/network/constants/api_constant.dart';
import 'package:ecommerce_app_using_bloc/core/network/service/auth_storage_service.dart';
import 'package:ecommerce_app_using_bloc/features/auth/data/models/login_request_model.dart';
import 'package:ecommerce_app_using_bloc/features/auth/data/models/login_response_model.dart';

class AuthRepository {
  final ApiClient apiClient;
  final AuthStorageService authStorageService;

  AuthRepository({required this.apiClient, required this.authStorageService});

  Future<LoginResponseModel> login(LoginRequestModel request)async{
    final response = await apiClient.post(ApiConstants.login, data: request.toJson());

    final loginResponse = LoginResponseModel.fromJson(
      response.data
    );

    authStorageService.saveAccessToken(loginResponse.accessToken);
    authStorageService.saveRefreshToken(loginResponse.refreshToken);

    return loginResponse;
  }

  Future logout()async{
    await authStorageService.clearToken();
  }
}