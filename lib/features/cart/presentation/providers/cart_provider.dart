import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/cart_item.dart';
import '../../../product/domain/entities/product_entity.dart';

final cartProvider =
    StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(ProductEntity product) {
    final index = state.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index >= 0) {
      final updated = [...state];

      updated[index] = updated[index].copyWith(
        quantity: updated[index].quantity + 1,
      );

      state = updated;
    } else {
      state = [
        ...state,
        CartItem(
          product: product,
          quantity: 1,
        ),
      ];
    }
  }

  void removeFromCart(String productId) {
    state = state
        .where(
          (item) => item.product.id != productId,
        )
        .toList();
  }

  void increaseQuantity(String productId) {
    state = state.map((item) {
      if (item.product.id == productId) {
        return item.copyWith(
          quantity: item.quantity + 1,
        );
      }

      return item;
    }).toList();
  }

  void decreaseQuantity(String productId) {
    final updated = <CartItem>[];

    for (final item in state) {
      if (item.product.id == productId) {
        if (item.quantity > 1) {
          updated.add(
            item.copyWith(
              quantity: item.quantity - 1,
            ),
          );
        }
      } else {
        updated.add(item);
      }
    }

    state = updated;
  }

  void clearCart() {
    state = [];
  }

  int get totalItems {
    return state.fold(
      0,
      (sum, item) => sum + item.quantity,
    );
  }

  double get totalPrice {
    return state.fold(
      0,
      (sum, item) => sum + item.totalPrice,
    );
  }
}