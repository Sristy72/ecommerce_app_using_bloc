import 'package:ecommerce_app_using_bloc/features/home/home_bloc/home_bloc.dart';
import 'package:ecommerce_app_using_bloc/features/home/home_bloc/home_event.dart';
import 'package:ecommerce_app_using_bloc/features/home/home_bloc/home_state.dart';
import 'package:ecommerce_app_using_bloc/features/home/widget/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllAvailableItemsScreen extends StatefulWidget {
  const AllAvailableItemsScreen({super.key});

  @override
  State<AllAvailableItemsScreen> createState() =>
      _AllAvailableItemsScreenState();
}

class _AllAvailableItemsScreenState extends State<AllAvailableItemsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<HomeBloc>().add(FetchAllItemsEvent());
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<HomeBloc>().add(LoadMoreAllItemsEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll - 200);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'All Available Items',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          // ── Loading ──────────────────────────────────────────────
          if (state.allItemsStatus == HomeStatus.loading &&
              state.allItems.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          // ── Error ────────────────────────────────────────────────
          if (state.allItemsStatus == HomeStatus.failure &&
              state.allItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 12),
                  Text(
                    state.allItemsErrorMessage.isNotEmpty
                        ? state.allItemsErrorMessage
                        : 'Failed to load items',
                    textAlign: TextAlign.center,
                    style:
                        const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () =>
                        context.read<HomeBloc>().add(FetchAllItemsEvent()),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // ── Loaded ───────────────────────────────────────────────
          return Column(
            children: [
              Expanded(
                child: ProductGrid(
                  controller: _scrollController,
                  state: state,
                  items: state.allItems,
                ),
              ),
              if (state.allItemsIsLoadingMore)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2.5),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
