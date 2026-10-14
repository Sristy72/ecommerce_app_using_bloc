import 'package:ecommerce_app_using_bloc/features/order/bloc/order_bloc.dart';
import 'package:ecommerce_app_using_bloc/features/order/bloc/order_event.dart';
import 'package:ecommerce_app_using_bloc/features/order/bloc/order_state.dart';
import 'package:ecommerce_app_using_bloc/features/order/data/models/response/get_order_by_id_response_model.dart';
import 'package:ecommerce_app_using_bloc/features/order/widgets/cart_item_card.dart';
import 'package:ecommerce_app_using_bloc/features/order/widgets/ordered_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/home_bloc/home_bloc.dart';
import '../../home/home_bloc/home_event.dart';
import '../../home/home_bloc/home_state.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    // Initial load on first mount
    context.read<HomeBloc>().add(FetchCartEvent());
    context.read<OrderBloc>().add(FetchOrdersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF1DB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF1DB),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        title: const Text(
          'My Orders',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1A1A1A),
          ),
        ),
        actions: [
          Container(
            height: 42,
            width: 42,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: const Color(0xFF7F3615)),
            ),
            child: const Center(
              child: Icon(Icons.search, color: Color(0xFF7F3615), size: 20),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Cart Section ─────────────────────────────────────────────
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, homeState) {
                final cartItems = homeState.cart?.items ?? [];
                final totalQty = homeState.totalCartItems;
                final totalPrice = homeState.cart?.total ?? 0.0;

                if (homeState.cartStatus == HomeStatus.loading &&
                    cartItems.isEmpty) {
                  return const _LoadingCard(message: 'Loading cart...');
                }

                if (cartItems.isEmpty) {
                  return _EmptyCartBanner();
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...cartItems.map((cartItem) {
                      final details = cartItem.item;
                      if (details == null) return const SizedBox.shrink();

                      return CartItemCard(
                        key: ValueKey(cartItem.id),
                        name: details.name,
                        description: details.description,
                        price: details.price,
                        imageUrl: details.image,
                        quantity: cartItem.quantity,
                        onAdd: () => context
                            .read<HomeBloc>()
                            .add(AddToCartEvent(itemId: details.id)),
                        onRemove: () => context
                            .read<HomeBloc>()
                            .add(RemoveFromCartEvent(itemId: details.id)),
                        onDismiss: () {
                          for (int i = 0; i < cartItem.quantity; i++) {
                            context
                                .read<HomeBloc>()
                                .add(RemoveFromCartEvent(itemId: details.id));
                          }
                        },
                      );
                    }),

                    const SizedBox(height: 4),
                    const Divider(color: Color(0xFFE0D5C5), thickness: 1),
                    const SizedBox(height: 6),

                    // Total row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total $totalQty item${totalQty == 1 ? '' : 's'}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF555555),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '\$${totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // Place Order button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () => _onPlaceOrder(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF70A9F5),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Place Order',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 28),

            // ─── Ordered Items Section ─────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Ordered Items',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.read<OrderBloc>().add(FetchOrdersEvent());
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'View all',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1753FF),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Orders list from backend via OrderBloc
            BlocBuilder<OrderBloc, OrderState>(
              builder: (context, orderState) {
                if (orderState.status == OrderStatus.loading) {
                  return const _LoadingCard(message: 'Loading orders...');
                }

                if (orderState.status == OrderStatus.failure) {
                  return _ErrorCard(
                    message: orderState.errorMessage,
                    onRetry: () =>
                        context.read<OrderBloc>().add(FetchOrdersEvent()),
                  );
                }

                if (orderState.orders.isEmpty) {
                  return const _EmptyOrdersBanner();
                }

                return Column(
                  children: orderState.orders
                      .map((order) => _OrderCard(order: order))
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onPlaceOrder(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Order placed successfully!'),
        backgroundColor: const Color(0xFF2E7D32),
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}

// ─── Order Card (real backend data) ───────────────────────────────────────────

class _OrderCard extends StatelessWidget {
  final Order order;

  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    // Each order may have multiple items — display one card per order item
    if (order.items.isEmpty) return const SizedBox.shrink();

    return Column(
      children: order.items.map((orderItem) {
        final item = orderItem.item;
        final status = _mapStatus(order.status);
        return OrderedItemCard(
          name: item.name,
          imageUrl: item.image,
          deliveryType: 'Delivery',
          address: order.address,
          restaurantName: 'Bakehouse Bakery',
          status: status,
        );
      }).toList(),
    );
  }

  OrderedItemStatus _mapStatus(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return OrderedItemStatus.delivered;
      case 'processing':
      case 'pending':
        return OrderedItemStatus.processing;
      case 'cancelled':
        return OrderedItemStatus.cancelled;
      case 'arriving':
      case 'out_for_delivery':
      case 'shipped':
      default:
        return OrderedItemStatus.arriving;
    }
  }
}

// ─── Helper Widgets ────────────────────────────────────────────────────────────

class _LoadingCard extends StatelessWidget {
  final String message;

  const _LoadingCard({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          const CircularProgressIndicator(
            color: Color(0xFF70A9F5),
            strokeWidth: 2.5,
          ),
          const SizedBox(height: 12),
          Text(message,
              style: const TextStyle(fontSize: 13, color: Color(0xFF888888))),
        ],
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorCard({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          const Icon(Icons.error_outline, color: Color(0xFFD32F2F), size: 40),
          const SizedBox(height: 10),
          const Text('Failed to load orders',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A1A))),
          const SizedBox(height: 6),
          Text(
            message,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: Color(0xFF888888)),
          ),
          const SizedBox(height: 14),
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh, size: 16),
            label: const Text('Try again'),
            style: TextButton.styleFrom(foregroundColor: const Color(0xFF1753FF)),
          ),
        ],
      ),
    );
  }
}

class _EmptyOrdersBanner extends StatelessWidget {
  const _EmptyOrdersBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Icon(Icons.receipt_long_outlined,
              size: 52, color: Colors.grey.shade300),
          const SizedBox(height: 12),
          const Text(
            'No orders yet',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF888888)),
          ),
          const SizedBox(height: 6),
          const Text(
            'Your past orders will appear here',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Color(0xFFAAAAAA)),
          ),
        ],
      ),
    );
  }
}

class _EmptyCartBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.shopping_cart_outlined,
              size: 56, color: Colors.grey.shade300),
          const SizedBox(height: 12),
          const Text(
            'Your cart is empty',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF888888)),
          ),
          const SizedBox(height: 6),
          const Text(
            'Add items from the home screen to get started',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Color(0xFFAAAAAA)),
          ),
        ],
      ),
    );
  }
}
