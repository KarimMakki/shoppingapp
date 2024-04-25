import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/wishlist_provider.dart';

AppBar wishlistAppBar() {
  return AppBar(
    toolbarHeight: 40,
    backgroundColor: Colors.white,
    elevation: 1,
    centerTitle: true,
    leading: const BackButton(
      color: Colors.black,
    ),
    title:
        Consumer<WishlistProvider>(builder: (context, wishlistProvider, child) {
      return Text(
        "Wishlist (${wishlistProvider.wishlistCount})",
        style: const TextStyle(color: Colors.black),
      );
    }),
  );
}
