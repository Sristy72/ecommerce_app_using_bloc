import 'package:ecommerce_app_using_bloc/features/auth/data/models/response/login_response_model.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  failure,
  forgotPasswordSuccess,
}

class AuthState {
  final AuthStatus status;
  final bool isPasswordVisible;
  final bool isRememberMe;
  final bool isTermsAndConditions;
  final UserModel? user;
  final String? errorMsg;
  final String? successMsg;
  final String? otp;

  AuthState({
    this.status = AuthStatus.initial,
    this.isPasswordVisible = false,
    this.isRememberMe = false,
    this.isTermsAndConditions = false,
    this.errorMsg,
    this.successMsg,
    this.user,
    this.otp,
  });

  AuthState copyWith({
    AuthStatus? status,
    bool? isPasswordVisible,
    bool? isRememberMe,
    bool? isTermsAndConditions,
    UserModel? user,
    String? errorMsg,
    String? successMsg,
  }) {
    return AuthState(
      status: status ?? this.status,
      isRememberMe: isRememberMe ?? this.isRememberMe,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isTermsAndConditions: isTermsAndConditions ?? this.isTermsAndConditions,
      user: user ?? this.user,
      errorMsg: errorMsg,
      successMsg: successMsg,
    );
  }
}