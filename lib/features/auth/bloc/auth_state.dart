import 'package:ecommerce_app_using_bloc/features/auth/bloc/auth_event.dart';
import 'package:ecommerce_app_using_bloc/features/auth/data/models/login_response_model.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  failure
}

class AuthState {
  final AuthStatus status;
  final bool isPasswordVisible;
  final bool isRememberMe;
  final bool isTermsAndConditions;
  final UserModel? user;
  final String? errorMsg;

  AuthState({this.status = AuthStatus.initial,
    this.isPasswordVisible = false,
    this.isRememberMe = false,
    this.isTermsAndConditions = false,
    this.errorMsg,  this.user});

  AuthState copyWith({
    AuthStatus? status,
    bool? isPasswordVisible,
    bool? isRememberMe,
    bool? isTermsAndConditions,
    UserModel? user,
    String? errorMsg
  }) {
    return AuthState(
        status: status ?? this.status,
        isRememberMe: isRememberMe ?? this.isRememberMe,
        isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
        isTermsAndConditions: isTermsAndConditions ?? this.isTermsAndConditions,
        user: user ?? this.user,
        errorMsg: errorMsg);
  }
}