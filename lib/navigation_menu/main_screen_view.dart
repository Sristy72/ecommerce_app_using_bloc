import 'package:ecommerce_app_using_bloc/features/home/screens/home_screen.dart';
import 'package:ecommerce_app_using_bloc/navigation_menu/navigation_bloc/navigation_menu_bloc.dart';
import 'package:ecommerce_app_using_bloc/navigation_menu/navigation_bloc/navigation_menu_state.dart';
import 'package:ecommerce_app_using_bloc/navigation_menu/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreenView extends StatelessWidget {
  const MainScreenView({super.key});

  final List<Widget> pages = const[
    HomeScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationMenuBloc, NavigationMenuState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.selectedIndex,
            children:
              pages
            ,
          ),
          bottomNavigationBar: AppBottomNavigation(),
        );
      },
    );
  }
}
