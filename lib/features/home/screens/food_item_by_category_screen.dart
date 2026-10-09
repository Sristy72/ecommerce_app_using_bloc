import 'package:ecommerce_app_using_bloc/features/home/data/models/response/get_category_response_model.dart';
import 'package:ecommerce_app_using_bloc/features/home/home_bloc/home_bloc.dart';
import 'package:ecommerce_app_using_bloc/features/home/home_bloc/home_event.dart';
import 'package:ecommerce_app_using_bloc/features/home/home_bloc/home_state.dart';
import 'package:ecommerce_app_using_bloc/features/home/widget/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodItemByCategoryScreen extends StatefulWidget {
  final CategoryItem category;

  const FoodItemByCategoryScreen({
    super.key,
    required this.category,
  });

  @override
  State<FoodItemByCategoryScreen> createState() =>
      _FoodItemByCategoryScreenState();
}

class _FoodItemByCategoryScreenState extends State<FoodItemByCategoryScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<HomeBloc>()
        .add(FetchItemsByCategoryEvent(widget.category.id));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.categoryItemsStatus == HomeStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.categoryItemsStatus == HomeStatus.failure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 40),
                  const SizedBox(height: 8),
                  Text(
                    'Failed to load items.\n${state.categoryItemsErrorMessage}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      context
                          .read<HomeBloc>()
                          .add(FetchItemsByCategoryEvent(widget.category.id));
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state.categoryItems.isEmpty) {
            return const Center(
              child: Text(
                'No items found in this category',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return ProductGrid(state: state);
        },
      ),
    );
  }
}
