import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_using_bloc/features/auth/bloc/auth_event.dart';
import 'package:ecommerce_app_using_bloc/features/auth/bloc/auth_state.dart';
import 'package:ecommerce_app_using_bloc/features/auth/data/models/login_request_model.dart';
import 'package:ecommerce_app_using_bloc/features/auth/data/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthState()){
    on<Login>(_login);
    on<Signup>();
    on<Logout>();
    on<RememberMe>(_rememberMe);
    on<PasswordVisibilityCheck>(_passwordVisibilityCheck);
  }
  _passwordVisibilityCheck(
      PasswordVisibilityCheck event,
      Emitter<AuthState> emit
      ){
    emit(
      state.copyWith(
        isPasswordVisible: !state.isPasswordVisible
      )
    );
  }

  _rememberMe(
      RememberMe event,
      Emitter<AuthState> emit
      ){
    emit(
      state.copyWith(
        isRememberMe: event.value
      )
    );
  }

  Future<void> _login(
      Login event,
      Emitter<AuthState> emit,
      ) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
      ),
    );

    try{
      final request = LoginRequestModel(email: event.email, password: event.password);

      final response = await authRepository.login(request);
      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          user: response.user
        ),
      );
    }catch(e){
      state.copyWith(
        status: AuthStatus.failure,
        errorMsg: e.toString()
      );
    }

  }
}