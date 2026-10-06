import '../data/models/response/get_popular_items_response_model.dart';

class WeeklyMenu {
  final String day;
  final List<PopularItem> items;

  WeeklyMenu({
    required this.day,
    required this.items,
  });
}