import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_bloc/home_bloc.dart';
import '../home_bloc/home_event.dart';
import '../home_bloc/home_state.dart';
import 'weekly_menu_slider.dart';

class WeeklyMenuSection extends StatelessWidget {
  final HomeState state;

  const WeeklyMenuSection({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
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
              const Icon(Icons.error_outline, color: Colors.red, size: 40),
              const SizedBox(height: 8),
              Text(
                'Failed to load menu.\n${state.errorMessage}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () {
                  context.read<HomeBloc>().add(FetchWeeklyMenuEvent());
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (state.status == HomeStatus.loaded) {
      return WeeklyMenuSlider(weeklyMenus: state.weeklyMenus);
    }

    return const SizedBox(height: 200);
  }
}
