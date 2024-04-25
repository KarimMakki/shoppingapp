import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import '../../constants.dart';
import '../../providers/cart_provider.dart';
import '../../screens/cart.dart';
import '../../screens/wishlist.dart';

AppBar categoryproductsAppBar(BuildContext context) {
  return AppBar(
    toolbarHeight: 60,
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    title: Image.asset(
      kLogocoloured,
      scale: 20,
    ),
    leading: const BackButton(
      color: Colors.black,
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.favorite_outline),
        color: Colors.black,
        onPressed: () => PersistentNavBarNavigator.pushNewScreen(context,
            screen: const WishListPage(), withNavBar: false),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 5.5),
        child: Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            return badges.Badge(
              onTap: () => PersistentNavBarNavigator.pushNewScreen(context,
                  screen: const CartPage(), withNavBar: false),
              position: badges.BadgePosition.custom(start: 25, top: 13),
              badgeStyle: const badges.BadgeStyle(
                padding: EdgeInsets.all(4),
              ),
              badgeContent: Text(
                cartProvider.cartItemsFromDb.length.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                color: Colors.black,
                onPressed: () => PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const CartPage(),
                    withNavBar: false),
              ),
            );
          },
        ),
      ),
    ],
  );
}