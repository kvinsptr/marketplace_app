import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/cart_item.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(CartItem item) {
    final index =
        state.indexWhere((e) => e.id == item.id);

    if (index != -1) {
      final updated = [...state];

      updated[index] = updated[index].copyWith(
        quantity:
            updated[index].quantity + 1,
      );

      state = updated;
    } else {
      state = [...state, item];
    }
  }

  void increaseQty(String id) {
    state = state.map((item) {
      if (item.id == id) {
        return item.copyWith(
          quantity: item.quantity + 1,
        );
      }

      return item;
    }).toList();
  }

  void decreaseQty(String id) {
    state = state.map((item) {
      if (item.id == id &&
          item.quantity > 1) {
        return item.copyWith(
          quantity: item.quantity - 1,
        );
      }

      return item;
    }).toList();
  }

  void removeItem(String id) {
    state = state
        .where((item) => item.id != id)
        .toList();
  }

  void clearCart() {
    state = [];
  }

  double get totalPrice {
    return state.fold(
      0,
      (sum, item) => sum + item.total,
    );
  }
}

final cartProvider =
    StateNotifierProvider<CartNotifier,
        List<CartItem>>(
  (ref) => CartNotifier(),
);