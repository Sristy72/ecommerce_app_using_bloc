import 'package:ecommerce_app_using_bloc/core/network/api_client.dart';
import 'package:ecommerce_app_using_bloc/core/network/constants/api_constant.dart';
import 'package:ecommerce_app_using_bloc/core/network/service/auth_storage_service.dart';
import 'package:ecommerce_app_using_bloc/features/auth/data/models/request/login_request_model.dart';
import 'package:ecommerce_app_using_bloc/features/auth/data/models/request/register_request_model.dart';
import 'package:ecommerce_app_using_bloc/features/auth/data/models/response/login_response_model.dart';
import 'package:ecommerce_app_using_bloc/features/auth/data/models/response/register_response_model.dart';

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

  Future<RegisterResponseModel> signUp(RegisterRequestModel register)async{
    final response =  await apiClient.post(ApiConstants.register, data: register.toJson());

    final registerResponse = RegisterResponseModel.fromJson(response.data);

    return registerResponse;
  }

  Future logout()async{
    await authStorageService.clearToken();
  }

<<<<<<< HEAD
=======
  Future<RegisterResponseModel> signUp(RegisterRequestModel register)async{
    final response =  await apiClient.post(ApiConstants.register, data: register.toJson());

    final registerResponse = RegisterResponseModel.fromJson(response.data);

    return registerResponse;
  }
>>>>>>> 64acd19b23684451f3f7d90c00f0263516f0cc60
}