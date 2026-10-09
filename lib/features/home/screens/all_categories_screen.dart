import 'package:ecommerce_app_using_bloc/features/home/home_bloc/home_bloc.dart';
import 'package:ecommerce_app_using_bloc/features/home/home_bloc/home_state.dart';
import 'package:ecommerce_app_using_bloc/features/home/widget/all_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllCategoriesScreen extends StatefulWidget {
  const AllCategoriesScreen({super.key, required this.state});
  final HomeState state;

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Category Screen'),
      ),
      body: AllCategory(state: widget.state),
    );
  }
}
