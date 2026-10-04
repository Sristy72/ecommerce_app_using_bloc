import 'package:ecommerce_app_using_bloc/navigation_menu/navigation_bloc/navigation_menu_bloc.dart';
import 'package:ecommerce_app_using_bloc/navigation_menu/navigation_bloc/navigation_menu_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigation_bloc/navigation_menu_event.dart';


class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({
    super.key,
  });

  static const Color backgroundColor = Color(0xFFFFF8EC);
  static const Color selectedColor = Color(0xFF70A9F5);
  static const Color iconBackgroundColor = Color(0xFFFFEBCB);
  static const Color iconColor = Color(0xFF713E18);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: const Color(0xFFEEDFC9),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: BlocBuilder<NavigationMenuBloc, NavigationMenuState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavigationItem(
                index: 0,
                selectedIndex: state.selectedIndex,
                icon: Icons.home_outlined,
                selectedIcon: Icons.home,
                label: 'Home',
              ),

              _NavigationItem(
                index: 1,
                selectedIndex: state.selectedIndex,
                icon: Icons.shopping_bag_outlined,
                selectedIcon: Icons.shopping_bag,
                label: 'Orders',
              ),

              _NavigationItem(
                index: 2,
                selectedIndex: state.selectedIndex,
                icon: Icons.chat_bubble_outline,
                selectedIcon: Icons.chat_bubble,
                label: 'Chat',
              ),

              _NavigationItem(
                index: 3,
                selectedIndex: state.selectedIndex,
                icon: Icons.person_outline,
                selectedIcon: Icons.person,
                label: 'Profile',
              ),
            ],
          );
        },
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  const _NavigationItem({
    required this.index,
    required this.selectedIndex,
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  bool get isSelected => index == selectedIndex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<NavigationMenuBloc>().add(
          NavigationItemSelected(index),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        height: 48,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16 : 10,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppBottomNavigation.selectedColor
              : AppBottomNavigation.iconBackgroundColor,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSelected ? selectedIcon : icon,
                size: 23,
                color: isSelected
                    ? Colors.white
                    : AppBottomNavigation.iconColor,
              ),

              if (isSelected) ...[
                const SizedBox(width: 7),

                Flexible(
                  child: Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}