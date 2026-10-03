abstract class AuthEvent {}

class Login extends AuthEvent {
  final String email;
  final String password;

  Login({
    required this.email,
    required this.password,
  });
}

class Signup extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final bool termsCondition;

  Signup({
    required this.name,
    required this.email,
    required this.password,
    required this.termsCondition,
  });
}

class ForgotPass extends AuthEvent{
  final String email;
  ForgotPass({required this.email});
}

class Logout extends AuthEvent {}

class PasswordVisibilityCheck extends AuthEvent {}

class RememberMe extends AuthEvent {
  final bool value;

  RememberMe(this.value);
}

class TermsAndCondition extends AuthEvent {
  final bool value;

  TermsAndCondition(this.value);
}
