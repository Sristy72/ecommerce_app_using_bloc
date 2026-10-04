import 'package:ecommerce_app_using_bloc/navigation_menu/navigation_bloc/navigation_menu_event.dart';
import 'package:ecommerce_app_using_bloc/navigation_menu/navigation_bloc/navigation_menu_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationMenuBloc extends Bloc<NavigationMenuEvent, NavigationMenuState>{
  NavigationMenuBloc() : super(const NavigationMenuState()){
    on<NavigationItemSelected>(_onNavigationItemSelected);
  }

  void _onNavigationItemSelected(
      NavigationItemSelected event,
      Emitter<NavigationMenuState> emit
      ){
    emit(state.copyWith(index: event.index));
  }

}