import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_using_bloc/features/home/data/repositories/home_repository.dart';
import 'package:ecommerce_app_using_bloc/features/home/model/weekly_menu_model.dart';

import 'package:ecommerce_app_using_bloc/core/network/service/auth_storage_service.dart';
import 'package:ecommerce_app_using_bloc/features/home/data/models/requests/add_item_tocart_request_model.dart';
import 'package:ecommerce_app_using_bloc/features/home/data/models/requests/remove_cart_request_model.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;
  final AuthStorageService authStorageService;

  /// Maps API query value → display label shown in the slider.
  /// The API only accepts: mon, tue, wed, thu, fri, today, all.
  static const Map<String, String> _dayMap = {
    'mon': 'Monday',
    'tue': 'Tuesday',
    'wed': 'Wednesday',
    'thu': 'Thursday',
    'fri': 'Friday',
  };

  HomeBloc({
    required this.homeRepository,
    required this.authStorageService,
  }) : super(const HomeState()) {
    on<FetchWeeklyMenuEvent>(_onFetchWeeklyMenu);
    on<FetchCategoryEvent>(_onFetchCategory);
    on<FetchItemsByCategoryEvent>(_onFetchItemsByCategory);
    on<LoadMoreCategoryItemsEvent>(_onLoadMoreCategoryItems);
    on<FetchAllItemsEvent>(_onFetchAllItems);
    on<LoadMoreAllItemsEvent>(_onLoadMoreAllItems);
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<FetchCartEvent>(_onFetchCart);
  }

  Future<void> _onAddToCart(
    AddToCartEvent event,
    Emitter<HomeState> emit,
  ) async {
    final currentQty = state.cartQuantities[event.itemId] ?? 0;
    final updatedQuantities = Map<String, int>.from(state.cartQuantities);
    updatedQuantities[event.itemId] = currentQty + 1;

    // Optimistically update UI
    emit(state.copyWith(
      cartQuantities: updatedQuantities,
      cartStatus: HomeStatus.loading,
    ));

    try {
      final userId = await authStorageService.getUserId();
      if (userId != null && userId.isNotEmpty) {
        final request = AddItemRequest(
          userId: userId,
          itemId: event.itemId,
          quantity: 1,
        );
        final response = await homeRepository.addToCart(request);
        if (response.items != null && response.items!.isNotEmpty) {
          final serverQuantities = <String, int>{};
          for (final item in response.items!) {
            final id = item.item;
            if (id != null && item.quantity != null) {
              serverQuantities[id] = item.quantity!;
            }
          }
          emit(state.copyWith(
            cartQuantities: serverQuantities,
            cartStatus: HomeStatus.loaded,
          ));
          return;
        }
      }
      emit(state.copyWith(cartStatus: HomeStatus.loaded));
    } catch (e) {
      emit(state.copyWith(
        cartStatus: HomeStatus.failure,
        cartErrorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCartEvent event,
    Emitter<HomeState> emit,
  ) async {
    final currentQty = state.cartQuantities[event.itemId] ?? 0;
    if (currentQty <= 0) return;

    final updatedQuantities = Map<String, int>.from(state.cartQuantities);
    if (currentQty <= 1) {
      updatedQuantities.remove(event.itemId);
    } else {
      updatedQuantities[event.itemId] = currentQty - 1;
    }

    // Optimistically update UI
    emit(state.copyWith(
      cartQuantities: updatedQuantities,
      cartStatus: HomeStatus.loading,
    ));

    try {
      final userId = await authStorageService.getUserId();
      if (userId != null && userId.isNotEmpty) {
        final request = RemoveCartRequestModel(
          userId: userId,
          itemId: event.itemId,
        );

        if (currentQty <= 1) {
          final response = await homeRepository.reduceCart(request);
          final serverQuantities = <String, int>{};
          for (final item in response.items) {
            serverQuantities[item.item] = item.quantity;
          }
          emit(state.copyWith(
            cartQuantities: serverQuantities,
            cartStatus: HomeStatus.loaded,
          ));
          return;
        } else {
          final response = await homeRepository.reduceCart(request);
          final serverQuantities = <String, int>{};
          for (final item in response.items) {
            serverQuantities[item.item] = item.quantity;
          }
          emit(state.copyWith(
            cartQuantities: serverQuantities,
            cartStatus: HomeStatus.loaded,
          ));
          return;
        }
      }
      emit(state.copyWith(cartStatus: HomeStatus.loaded));
    } catch (e) {
      emit(state.copyWith(
        cartStatus: HomeStatus.failure,
        cartErrorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onFetchCart(
    FetchCartEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final userId = await authStorageService.getUserId();
      if (userId != null && userId.isNotEmpty) {
        final getCartItems = await homeRepository.getCart(userId);
        final Map<String, int> quantities = {};
        for (final cartItem in getCartItems.items) {
          if (cartItem.item != null) {
            quantities[cartItem.item!.id] = cartItem.quantity;
          }
        }
        emit(state.copyWith(
          cart: getCartItems,
          cartQuantities: quantities,
          cartStatus: HomeStatus.loaded,
        ));
      }
    } catch (_) {
      // Cart might not exist yet, keep existing
    }
  }

  Future<void> _onFetchItemsByCategory(
    FetchItemsByCategoryEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(
      categoryItemsStatus: HomeStatus.loading,
      currentCategoryId: event.categoryId,
      categoryItemsPage: 1,
      categoryItemsHasReachedMax: false,
      categoryItemsIsLoadingMore: false,
    ));
    try {
      final response = await homeRepository.fetchSpecificItem(
        event.categoryId,
        page: 1,
        limit: 20,
      );
      final hasReachedMax =
          response.page >= response.pages || response.items.isEmpty;
      emit(state.copyWith(
        categoryItemsStatus: HomeStatus.loaded,
        categoryItems: response.items,
        currentCategoryId: event.categoryId,
        categoryItemsPage: 1,
        categoryItemsHasReachedMax: hasReachedMax,
        categoryItemsIsLoadingMore: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        categoryItemsStatus: HomeStatus.failure,
        categoryItemsErrorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoadMoreCategoryItems(
    LoadMoreCategoryItemsEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state.categoryItemsHasReachedMax ||
        state.categoryItemsIsLoadingMore ||
        state.currentCategoryId.isEmpty) {
      return;
    }

    emit(state.copyWith(categoryItemsIsLoadingMore: true));
    try {
      final nextPage = state.categoryItemsPage + 1;
      final response = await homeRepository.fetchSpecificItem(
        state.currentCategoryId,
        page: nextPage,
        limit: 20,
      );
      final hasReachedMax =
          response.page >= response.pages || response.items.isEmpty;
      emit(state.copyWith(
        categoryItems: [...state.categoryItems, ...response.items],
        categoryItemsPage: nextPage,
        categoryItemsHasReachedMax: hasReachedMax,
        categoryItemsIsLoadingMore: false,
      ));
    } catch (e) {
      emit(state.copyWith(categoryItemsIsLoadingMore: false));
    }
  }

  Future<void> _onFetchAllItems(
    FetchAllItemsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(
      allItemsStatus: HomeStatus.loading,
      allItemsPage: 1,
      allItemsHasReachedMax: false,
      allItemsIsLoadingMore: false,
    ));
    try {
      final response = await homeRepository.getAllPopularItems(
        page: 1,
        limit: 20,
      );
      final hasReachedMax =
          response.page >= response.pages || response.items.isEmpty;
      emit(state.copyWith(
        allItemsStatus: HomeStatus.loaded,
        allItems: response.items,
        allItemsPage: 1,
        allItemsHasReachedMax: hasReachedMax,
        allItemsIsLoadingMore: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        allItemsStatus: HomeStatus.failure,
        allItemsErrorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoadMoreAllItems(
    LoadMoreAllItemsEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state.allItemsHasReachedMax || state.allItemsIsLoadingMore) {
      return;
    }

    emit(state.copyWith(allItemsIsLoadingMore: true));
    try {
      final nextPage = state.allItemsPage + 1;
      final response = await homeRepository.getAllPopularItems(
        page: nextPage,
        limit: 20,
      );
      final hasReachedMax =
          response.page >= response.pages || response.items.isEmpty;
      emit(state.copyWith(
        allItems: [...state.allItems, ...response.items],
        allItemsPage: nextPage,
        allItemsHasReachedMax: hasReachedMax,
        allItemsIsLoadingMore: false,
      ));
    } catch (e) {
      emit(state.copyWith(allItemsIsLoadingMore: false));
    }
  }

  Future<void> _onFetchCategory(
    FetchCategoryEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(categoryStatus: HomeStatus.loading));
    try {
      final categoryResponse = await homeRepository.fetchCategory();
      emit(state.copyWith(
        categoryStatus: HomeStatus.loaded,
        categories: categoryResponse.data,
      ));
    } catch (e) {
      emit(state.copyWith(
        categoryStatus: HomeStatus.failure,
        categoryErrorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onFetchWeeklyMenu(
    FetchWeeklyMenuEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final entries = _dayMap.entries.toList();

      // Fetch items for all weekdays in parallel
      final results = await Future.wait(
        entries.map((e) => homeRepository.getPopular(e.key)),
      );

      final weeklyMenus = <WeeklyMenu>[];
      for (int i = 0; i < entries.length; i++) {
        weeklyMenus.add(
          WeeklyMenu(day: entries[i].value, items: results[i].items),
        );
      }

      emit(state.copyWith(
        status: HomeStatus.loaded,
        weeklyMenus: weeklyMenus,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HomeStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}

