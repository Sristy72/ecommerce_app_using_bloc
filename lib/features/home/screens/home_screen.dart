import 'package:ecommerce_app_using_bloc/features/home/home_bloc/home_bloc.dart';
import 'package:ecommerce_app_using_bloc/features/home/screens/all_categories_screen.dart';
import 'package:ecommerce_app_using_bloc/features/home/widget/category_section.dart';
import 'package:ecommerce_app_using_bloc/features/home/widget/item_card.dart';
import 'package:ecommerce_app_using_bloc/features/home/widget/weekly_menu_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_bloc/home_event.dart';
import '../home_bloc/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    final homeBloc = context.read<HomeBloc>();

    if (homeBloc.state.status == HomeStatus.initial) {
      homeBloc.add(FetchWeeklyMenuEvent());
    }

    if (homeBloc.state.categoryStatus == HomeStatus.initial) {
      homeBloc.add(FetchCategoryEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Place a order',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        actions: [
          Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: const Color(0xFF7F3615)),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Icon(Icons.search, color: Color(0xFF7F3615)),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: const Color(0xFF0B6DFF)),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Icon(Icons.shopping_cart, color: Color(0xFF0B6DFF)),
                  ),
                ),
              ),
              const SizedBox(width: 18),
            ],
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          // Filter items based on selected day from weekly menus
          final activeDay = selectedDay ?? 'Monday';
          List<dynamic> dayItems = [];
          if (state.weeklyMenus.isNotEmpty) {
            final matchingMenu = state.weeklyMenus.firstWhere(
              (m) => m.day.toLowerCase() == activeDay.toLowerCase(),
              orElse: () => state.weeklyMenus.first,
            );
            dayItems = matchingMenu.items;
          }

          return Padding(
            padding: const EdgeInsets.all(18),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Weekly Menu',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  WeeklyMenuSection(state: state),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        'Select by Category',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AllCategoriesScreen(state: state),
                            ),
                          );
                        },
                        child: const Text(
                          'View all',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1753FF),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CategorySection(state: state),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      DropdownButton<String>(
                        hint: const Text(
                          'Select a day',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        value: selectedDay,
                        items: days.map((String day) {
                          return DropdownMenuItem<String>(
                            value: day,
                            child: Text(day),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedDay = newValue;
                          });
                        },
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'View all',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1753FF),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  ProductGrid(
                    state: state,
                    items: dayItems,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  String? selectedDay;
}
