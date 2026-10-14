import 'package:ecommerce_app_using_bloc/features/home/screens/home_screen.dart';
import 'package:ecommerce_app_using_bloc/features/home/home_bloc/home_bloc.dart';
import 'package:ecommerce_app_using_bloc/features/home/home_bloc/home_event.dart';
import 'package:ecommerce_app_using_bloc/features/order/bloc/order_bloc.dart';
import 'package:ecommerce_app_using_bloc/features/order/bloc/order_event.dart';
import 'package:ecommerce_app_using_bloc/features/order/screens/order_screen.dart';
import 'package:ecommerce_app_using_bloc/navigation_menu/navigation_bloc/navigation_menu_bloc.dart';
import 'package:ecommerce_app_using_bloc/navigation_menu/navigation_bloc/navigation_menu_state.dart';
import 'package:ecommerce_app_using_bloc/navigation_menu/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigation_bloc/navigation_menu_event.dart';

class MainScreenView extends StatelessWidget {
  const MainScreenView({super.key});

  static const List<Widget> _pages = [
    HomeScreen(),
    OrderScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationMenuBloc, NavigationMenuState>(
      listenWhen: (previous, current) =>
          previous.selectedIndex != current.selectedIndex,
      listener: (context, state) {
        // When navigating TO the Orders tab (index 1), refresh both cart and orders
        if (state.selectedIndex == 1) {
          context.read<HomeBloc>().add(FetchCartEvent());
          context.read<OrderBloc>().add(FetchOrdersEvent());
        }
      },
      child: BlocBuilder<NavigationMenuBloc, NavigationMenuState>(
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(
              index: state.selectedIndex,
              children: _pages,
            ),
            bottomNavigationBar: const AppBottomNavigation(),
          );
        },
      ),
    );
  }
}
