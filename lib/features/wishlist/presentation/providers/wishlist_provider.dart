import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/wishlist_item.dart';

class WishlistNotifier
    extends StateNotifier<List<WishlistItem>> {
  WishlistNotifier() : super([]);

  void toggle(WishlistItem item) {
    final exists = state.any(
      (e) => e.id == item.id,
    );

    if (exists) {
      state = state
          .where((e) => e.id != item.id)
          .toList();
    } else {
      state = [...state, item];
    }
  }
}

final wishlistProvider =
    StateNotifierProvider<
        WishlistNotifier,
        List<WishlistItem>>(
  (ref) => WishlistNotifier(),
);