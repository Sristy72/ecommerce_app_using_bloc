import 'package:ecommerce_app_using_bloc/core/network/api_client.dart';
import 'package:ecommerce_app_using_bloc/core/network/constants/api_constant.dart';
import 'package:ecommerce_app_using_bloc/core/network/service/auth_storage_service.dart';
import 'package:ecommerce_app_using_bloc/features/auth/data/models/request/forgot_pass_request_model.dart';
import 'package:ecommerce_app_using_bloc/features/auth/data/models/request/login_request_model.dart';
import 'package:ecommerce_app_using_bloc/features/auth/data/models/request/register_request_model.dart';
import 'package:ecommerce_app_using_bloc/features/auth/data/models/response/forgot_pass_response_model.dart';
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

  Future<ForgotPasswordResponseModel> forgotPass(
      ForgotPasswordRequestModel request) async {
    final response =
        await apiClient.post(ApiConstants.forgotPass, data: request.toJson());

    final forgotPassResponse =
        ForgotPasswordResponseModel.fromJson(response.data);
    return forgotPassResponse;
  }

  Future logout()async{
    await authStorageService.clearToken();
  }

}