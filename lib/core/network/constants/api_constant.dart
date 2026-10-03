class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://api.danielabakehousebakery.com/api/v1';

  static const String login = '$baseUrl/auth/login';
  static const String register = '$baseUrl/auth/register';
  static const String forgotPass = '$baseUrl/auth/register';
  static const String logout = 'auth/logout';
  static const String profile = 'profile';

  static const String home = 'home';
  static const String orders = 'orders';
  static const String chat = 'chat';
}