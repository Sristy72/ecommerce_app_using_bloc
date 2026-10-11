abstract class HomeEvent {}

final class FetchWeeklyMenuEvent extends HomeEvent {}

final class FetchCategoryEvent extends HomeEvent {}

final class FetchItemsByCategoryEvent extends HomeEvent {
  final String categoryId;

  FetchItemsByCategoryEvent(this.categoryId);
}

final class LoadMoreCategoryItemsEvent extends HomeEvent {}

final class FetchAllItemsEvent extends HomeEvent {}

final class LoadMoreAllItemsEvent extends HomeEvent {}

final class AddToCartEvent extends HomeEvent {
  final String itemId;

  AddToCartEvent({required this.itemId});
}

final class RemoveFromCartEvent extends HomeEvent {
  final String itemId;

  RemoveFromCartEvent({required this.itemId});
}

final class FetchCartEvent extends HomeEvent {}
