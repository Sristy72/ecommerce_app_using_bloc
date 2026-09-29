import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_using_bloc/features/auth/bloc/auth_event.dart';
import 'package:ecommerce_app_using_bloc/features/auth/bloc/auth_state.dart';
import 'package:ecommerce_app_using_bloc/features/auth/data/models/request/login_request_model.dart';
import 'package:ecommerce_app_using_bloc/features/auth/data/models/request/register_request_model.dart';
import 'package:ecommerce_app_using_bloc/features/auth/data/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthState()) {
    on<Login>(_login);
    on<Signup>(_signUp);
    on<Logout>(_logout);
    on<RememberMe>(_rememberMe);
    on<PasswordVisibilityCheck>(_passwordVisibilityCheck);
<<<<<<< HEAD
    on<TermsAndCondition>(_termsAndCondition);
  }

  void _termsAndCondition(
      TermsAndCondition event,
      Emitter<AuthState> emit,
      ) {
    emit(
      state.copyWith(
        isTermsAndConditions: event.value,
      ),
    );
  }

  _passwordVisibilityCheck(
    PasswordVisibilityCheck event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  _rememberMe(RememberMe event, Emitter<AuthState> emit) {
    emit(state.copyWith(isRememberMe: event.value));
  }

  Future<void> _login(Login event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));

=======
  }

  _passwordVisibilityCheck(
    PasswordVisibilityCheck event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  _rememberMe(RememberMe event, Emitter<AuthState> emit) {
    emit(state.copyWith(isRememberMe: event.value));
  }

  Future<void> _login(Login event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));

>>>>>>> 64acd19b23684451f3f7d90c00f0263516f0cc60
    try {
      final request = LoginRequestModel(
        email: event.email,
        password: event.password,
      );

      final response = await authRepository.login(request);
      emit(
        state.copyWith(status: AuthStatus.authenticated, user: response.user),
      );
    } catch (e) {
      state.copyWith(status: AuthStatus.failure, errorMsg: e.toString());
    }
  }

  Future<void> _signUp(Signup event, Emitter<AuthState> emit) async {
    if (!event.termsCondition) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMsg: 'Please accept the terms and conditions',
        ),
      );
      return;
    }
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      final register = RegisterRequestModel(
        name: event.name,
        email: event.email,
        password: event.password,
      );
      final response = authRepository.signUp(register);
      emit(state.copyWith(status: AuthStatus.authenticated));
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMsg: e.toString()),
      );
    }
  }

  Future<void> _logout(Logout event, Emitter<AuthState> emit)async{
    emit(
      state.copyWith(
        status: AuthStatus.loading
      )
    );
    try{
      authRepository.logout();
      emit(state.copyWith(
        status: AuthStatus.unauthenticated
      ));
    }catch(e){
      emit(state.copyWith(
        status: AuthStatus.failure,
        errorMsg: e.toString()
      ));
    }
  }
}
