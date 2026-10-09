import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_bloc/home_bloc.dart';
import '../home_bloc/home_event.dart';
import '../home_bloc/home_state.dart';

class CategorySection extends StatelessWidget {
  final HomeState state;

  const CategorySection({super.key, required this.state});

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

      return SizedBox(
        height: 160,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: state.categories.length,
          itemBuilder: (context, index) {
            final category = state.categories[index];

            return Container(
              width: 120,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Color(category.bgColor),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black12, width: 0.5),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 4, right: 4),
                    child: Text(
                      category.name,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Spacer(),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    child: _buildCategoryImage(category.image),
                  ),
                ],
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
