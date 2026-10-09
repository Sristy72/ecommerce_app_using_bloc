import '../data/models/response/get_category_response_model.dart';
import '../model/weekly_menu_model.dart';

enum HomeStatus { initial, loading, loaded, failure }

class HomeState {
  final HomeStatus status;
  final List<WeeklyMenu> weeklyMenus;
  final String errorMessage;

  final HomeStatus categoryStatus;
  final List<CategoryItem> categories;
  final String categoryErrorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.weeklyMenus = const [],
    this.errorMessage = '',
    this.categoryStatus = HomeStatus.initial,
    this.categories = const [],
    this.categoryErrorMessage = '',
  });

  HomeState copyWith({
    HomeStatus? status,
    List<WeeklyMenu>? weeklyMenus,
    String? errorMessage,
    HomeStatus? categoryStatus,
    List<CategoryItem>? categories,
    String? categoryErrorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      weeklyMenus: weeklyMenus ?? this.weeklyMenus,
      errorMessage: errorMessage ?? this.errorMessage,
      categoryStatus: categoryStatus ?? this.categoryStatus,
      categories: categories ?? this.categories,
      categoryErrorMessage: categoryErrorMessage ?? this.categoryErrorMessage,
    );
  }
}

