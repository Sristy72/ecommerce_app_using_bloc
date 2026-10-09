import '../data/models/response/get_category_response_model.dart';
import '../data/models/response/get_item_by_category_id_response_model.dart';
import '../data/models/response/get_popular_items_response_model.dart';
import '../model/weekly_menu_model.dart';

enum HomeStatus { initial, loading, loaded, failure }

class HomeState {
  final HomeStatus status;
  final List<WeeklyMenu> weeklyMenus;
  final String errorMessage;

  final HomeStatus categoryStatus;
  final List<CategoryItem> categories;
  final String categoryErrorMessage;

  final HomeStatus categoryItemsStatus;
  final List<FoodItem> categoryItems;
  final String categoryItemsErrorMessage;

  final HomeStatus popularItemStatus;
  final List<PopularItem> popularItems;
  final String popularItemErrorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.weeklyMenus = const [],
    this.errorMessage = '',
    this.categoryStatus = HomeStatus.initial,
    this.categories = const [],
    this.categoryErrorMessage = '',
    this.categoryItemsStatus = HomeStatus.initial,
    this.categoryItems = const [],
    this.categoryItemsErrorMessage = '',
    this.popularItemStatus = HomeStatus.initial,
    this.popularItems = const [],
    this.popularItemErrorMessage = '',
  });

  HomeState copyWith({
    HomeStatus? status,
    List<WeeklyMenu>? weeklyMenus,
    String? errorMessage,
    HomeStatus? categoryStatus,
    List<CategoryItem>? categories,
    String? categoryErrorMessage,
    HomeStatus? categoryItemsStatus,
    List<FoodItem>? categoryItems,
    String? categoryItemsErrorMessage,
    HomeStatus? popularItemStatus,
    List<PopularItem>? popularItems,
    String? popularItemErrorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      weeklyMenus: weeklyMenus ?? this.weeklyMenus,
      errorMessage: errorMessage ?? this.errorMessage,
      categoryStatus: categoryStatus ?? this.categoryStatus,
      categories: categories ?? this.categories,
      categoryErrorMessage: categoryErrorMessage ?? this.categoryErrorMessage,
      categoryItemsStatus: categoryItemsStatus ?? this.categoryItemsStatus,
      categoryItems: categoryItems ?? this.categoryItems,
      categoryItemsErrorMessage:
          categoryItemsErrorMessage ?? this.categoryItemsErrorMessage,
      popularItemStatus: popularItemStatus ?? this.popularItemStatus,
      popularItems: popularItems ?? this.popularItems,
      popularItemErrorMessage:
          popularItemErrorMessage ?? this.popularItemErrorMessage,
    );
  }
}



