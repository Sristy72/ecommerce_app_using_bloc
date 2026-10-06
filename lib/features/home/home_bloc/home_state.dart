import '../widget/weekly_menu_model.dart';

enum HomeStatus { initial, loading, loaded, failure }

class HomeState {
  final HomeStatus status;
  final List<WeeklyMenu> weeklyMenus;
  final String errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.weeklyMenus = const [],
    this.errorMessage = '',
  });

  HomeState copyWith({
    HomeStatus? status,
    List<WeeklyMenu>? weeklyMenus,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      weeklyMenus: weeklyMenus ?? this.weeklyMenus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
