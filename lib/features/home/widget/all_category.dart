import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_bloc/home_bloc.dart';
import '../home_bloc/home_event.dart';
import '../home_bloc/home_state.dart';
import '../screens/food_item_by_category_screen.dart';

class AllCategory extends StatelessWidget {
  final HomeState state;

  const AllCategory({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.categoryStatus == HomeStatus.loading) {
      return const SizedBox(
        height: 90,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.categoryStatus == HomeStatus.failure) {
      return SizedBox(
        height: 90,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Failed to load categories',
                style: TextStyle(color: Colors.red, fontSize: 13),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.refresh, size: 20, color: Colors.red),
                onPressed: () {
                  context.read<HomeBloc>().add(FetchCategoryEvent());
                },
              ),
            ],
          ),
        ),
      );
    }

    if (state.categoryStatus == HomeStatus.loaded) {
      if (state.categories.isEmpty) {
        return const SizedBox(
          height: 90,
          child: Center(
            child: Text(
              'No categories found',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        );
      }

      return Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: state.categories.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,       // must remain 4
            childAspectRatio: 0.7,  // makes cards bigger vertically
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final category = state.categories[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        FoodItemByCategoryScreen(category: category),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(category.bgColor),
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(
                    color: const Color(0xFFE7D5BF),
                    width: 1,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 2,
                            vertical: 5,
                          ),
                          child: Text(
                            category.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: SizedBox(
                        width: double.infinity,
                        child: _buildCategoryImage(category.image),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }

    return const SizedBox(height: 90);
  }

  Widget _buildCategoryImage(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return const SizedBox(
        height: 100,
        width: double.infinity,
        child: Icon(Icons.image_not_supported_outlined, color: Colors.grey),
      );
    }

    return Center(
      child: Image.network(
        imageUrl,
        height: 100,
        width: double.infinity,
        fit: BoxFit.fill,
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: const SizedBox(
              height: 100,
              width: double.infinity,
              child: Icon(Icons.broken_image_outlined, color: Colors.grey),
            ),
          );
        },
      ),
    );
  }
}
