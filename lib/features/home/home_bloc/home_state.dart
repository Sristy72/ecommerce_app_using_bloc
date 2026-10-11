import '../data/models/response/get_cart_response_model.dart';
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
  final int categoryItemsPage;
  final bool categoryItemsHasReachedMax;
  final bool categoryItemsIsLoadingMore;
  final String currentCategoryId;

  final HomeStatus popularItemStatus;
  final List<PopularItem> popularItems;
  final String popularItemErrorMessage;

  final HomeStatus allItemsStatus;
  final List<PopularItem> allItems;
  final String allItemsErrorMessage;
  final int allItemsPage;
  final bool allItemsHasReachedMax;
  final bool allItemsIsLoadingMore;

  final GetCartResponseModel? cart;
  final Map<String, int> cartQuantities;
  final HomeStatus cartStatus;
  final String cartErrorMessage;

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
    this.categoryItemsPage = 1,
    this.categoryItemsHasReachedMax = false,
    this.categoryItemsIsLoadingMore = false,
    this.currentCategoryId = '',
    this.popularItemStatus = HomeStatus.initial,
    this.popularItems = const [],
    this.popularItemErrorMessage = '',
    this.allItemsStatus = HomeStatus.initial,
    this.allItems = const [],
    this.allItemsErrorMessage = '',
    this.allItemsPage = 1,
    this.allItemsHasReachedMax = false,
    this.allItemsIsLoadingMore = false,
    this.cart,
    this.cartQuantities = const {},
    this.cartStatus = HomeStatus.initial,
    this.cartErrorMessage = '',
  });

  int getCartQuantity(String itemId) => cartQuantities[itemId] ?? 0;

  bool isInCart(String itemId) => (cartQuantities[itemId] ?? 0) > 0;

  int get totalCartItems =>
      cartQuantities.values.fold(0, (sum, qty) => sum + qty);

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
    int? categoryItemsPage,
    bool? categoryItemsHasReachedMax,
    bool? categoryItemsIsLoadingMore,
    String? currentCategoryId,
    HomeStatus? popularItemStatus,
    List<PopularItem>? popularItems,
    String? popularItemErrorMessage,
    HomeStatus? allItemsStatus,
    List<PopularItem>? allItems,
    String? allItemsErrorMessage,
    int? allItemsPage,
    bool? allItemsHasReachedMax,
    bool? allItemsIsLoadingMore,
    GetCartResponseModel? cart,
    Map<String, int>? cartQuantities,
    HomeStatus? cartStatus,
    String? cartErrorMessage,
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
      categoryItemsPage: categoryItemsPage ?? this.categoryItemsPage,
      categoryItemsHasReachedMax:
          categoryItemsHasReachedMax ?? this.categoryItemsHasReachedMax,
      categoryItemsIsLoadingMore:
          categoryItemsIsLoadingMore ?? this.categoryItemsIsLoadingMore,
      currentCategoryId: currentCategoryId ?? this.currentCategoryId,
      popularItemStatus: popularItemStatus ?? this.popularItemStatus,
      popularItems: popularItems ?? this.popularItems,
      popularItemErrorMessage:
          popularItemErrorMessage ?? this.popularItemErrorMessage,
      allItemsStatus: allItemsStatus ?? this.allItemsStatus,
      allItems: allItems ?? this.allItems,
      allItemsErrorMessage: allItemsErrorMessage ?? this.allItemsErrorMessage,
      allItemsPage: allItemsPage ?? this.allItemsPage,
      allItemsHasReachedMax:
          allItemsHasReachedMax ?? this.allItemsHasReachedMax,
      allItemsIsLoadingMore:
          allItemsIsLoadingMore ?? this.allItemsIsLoadingMore,
      cart: cart ?? this.cart,
      cartQuantities: cartQuantities ?? this.cartQuantities,
      cartStatus: cartStatus ?? this.cartStatus,
      cartErrorMessage: cartErrorMessage ?? this.cartErrorMessage,
    );
  }
}



