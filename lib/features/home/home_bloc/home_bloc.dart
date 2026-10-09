import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_using_bloc/features/home/data/repositories/home_repository.dart';
import 'package:ecommerce_app_using_bloc/features/home/model/weekly_menu_model.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  /// Maps API query value → display label shown in the slider.
  /// The API only accepts: mon, tue, wed, thu, fri, today, all.
  static const Map<String, String> _dayMap = {
    'mon': 'Monday',
    'tue': 'Tuesday',
    'wed': 'Wednesday',
    'thu': 'Thursday',
    'fri': 'Friday',
  };

  HomeBloc({required this.homeRepository}) : super(const HomeState()) {
    on<FetchWeeklyMenuEvent>(_onFetchWeeklyMenu);
    on<FetchCategoryEvent>(_onFetchCategory);
    on<FetchItemsByCategoryEvent>(_onFetchItemsByCategory);
  }

  Future<void> _onFetchItemsByCategory(
    FetchItemsByCategoryEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(categoryItemsStatus: HomeStatus.loading));
    try {
      final response = await homeRepository.fetchSpecificItem(event.categoryId);
      emit(state.copyWith(
        categoryItemsStatus: HomeStatus.loaded,
        categoryItems: response.items,
      ));
    } catch (e) {
      emit(state.copyWith(
        categoryItemsStatus: HomeStatus.failure,
        categoryItemsErrorMessage: e.toString(),
      ));
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
        entries.map((e) => homeRepository.getAllPopular(e.key)),
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

