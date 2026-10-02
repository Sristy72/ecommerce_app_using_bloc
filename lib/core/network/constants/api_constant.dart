class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://api.danielabakehousebakery.com/api/v1/auth';

  static const String login = '$baseUrl/login';
  static const String register = '$baseUrl/register';
  static const String logout = 'auth/logout';
  static const String profile = 'profile';

  static const String home = 'home';
  static const String orders = 'orders';
  static const String chat = 'chat';
}