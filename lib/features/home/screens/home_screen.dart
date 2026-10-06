import 'package:ecommerce_app_using_bloc/core/di/injection.dart';
import 'package:ecommerce_app_using_bloc/features/home/home_bloc/home_bloc.dart';
import 'package:ecommerce_app_using_bloc/features/home/widget/weekly_menu_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_bloc/home_event.dart';
import '../home_bloc/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) =>
          getIt<HomeBloc>()..add(FetchWeeklyMenuEvent()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

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
                  padding: EdgeInsets.all(10.0),
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
                  padding: EdgeInsets.all(10.0),
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
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Weekly Menu',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state.status == HomeStatus.loading) {
                    return const SizedBox(
                      height: 200,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (state.status == HomeStatus.failure) {
                    return SizedBox(
                      height: 200,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error_outline,
                                color: Colors.red, size: 40),
                            const SizedBox(height: 8),
                            Text(
                              'Failed to load menu.\n${state.errorMessage}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.red),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton.icon(
                              onPressed: () => context
                                  .read<HomeBloc>()
                                  .add(FetchWeeklyMenuEvent()),
                              icon: const Icon(Icons.refresh),
                              label: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  if (state.status == HomeStatus.loaded) {
                    return WeeklyMenuSlider(
                      weeklyMenus: state.weeklyMenus,
                    );
                  }

                  // HomeStatus.initial — show empty placeholder
                  return const SizedBox(height: 200);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
