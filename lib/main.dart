import 'package:ecommerce_app_using_bloc/core/theme/app_theme.dart';
import 'package:ecommerce_app_using_bloc/features/auth/bloc/auth_bloc.dart';
import 'package:ecommerce_app_using_bloc/features/home/home_bloc/home_bloc.dart';
import 'package:ecommerce_app_using_bloc/features/home/home_bloc/home_event.dart';
import 'package:ecommerce_app_using_bloc/features/splash/screens/splash_screen.dart';
import 'package:ecommerce_app_using_bloc/navigation_menu/navigation_bloc/navigation_menu_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => getIt<AuthBloc>(),
        ),
        BlocProvider(create: (_) => NavigationMenuBloc()),
        BlocProvider<HomeBloc>(
          create: (_) => getIt<HomeBloc>()
            ..add(FetchWeeklyMenuEvent())
            ..add(FetchCategoryEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme,
        home: SplashScreen(),
      ),
    );
  }
}


