abstract class HomeEvent {}

final class FetchWeeklyMenuEvent extends HomeEvent {}

final class FetchCategoryEvent extends HomeEvent {}

final class FetchItemsByCategoryEvent extends HomeEvent {
  final String categoryId;

  FetchItemsByCategoryEvent(this.categoryId);
}

