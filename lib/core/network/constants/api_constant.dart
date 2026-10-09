class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://api.danielabakehousebakery.com/api/v1';

  //auth
  static const String login = '$baseUrl/auth/login';
  static const String register = '$baseUrl/auth/register';
  static const String forgotPass = '$baseUrl/auth/forgot-password';
  static const String logout = 'auth/logout';
  static const String profile = 'profile';


  // home
  static String popular(String day) => '$baseUrl/items?day=$day';
  static String category = '$baseUrl/categories';
  static String items(String categoryId, {int page = 1, int limit = 10}) =>
      '${ApiConstants.baseUrl}/items?category=$categoryId&page=$page&limit=$limit';
  static const String home = 'home';
  static const String orders = 'orders';
  static const String chat = 'chat';
}