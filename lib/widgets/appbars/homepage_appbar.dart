import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/cart_provider.dart';
import 'package:shopping_app/screens/cart.dart';
import 'package:shopping_app/screens/wishlist.dart';
import 'package:shopping_app/widgets/mainTabbar.dart';
import 'package:badges/badges.dart' as badges;
import '../../constants.dart';

AppBar homepageAppBar(BuildContext wishlistcontext) {
  return AppBar(
      toolbarHeight: 70,
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Image.asset(
        kLogocoloured,
        scale: 20,
      ),
      leading: IconButton(
        icon: const Icon(Icons.mail_outline),
        color: Colors.black,
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite_outline),
          color: Colors.black,
          onPressed: () => PersistentNavBarNavigator.pushNewScreen(
              wishlistcontext,
              screen: const WishListPage(),
              withNavBar: false),
        ),
        Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            return badges.Badge(
              onTap: () => PersistentNavBarNavigator.pushNewScreen(context,
                  screen: const CartPage(), withNavBar: false),
              position: badges.BadgePosition.custom(start: 25, top: 5),
              badgeStyle: const badges.BadgeStyle(padding: EdgeInsets.all(4)),
              badgeContent: Text(
                cartProvider.cartItemsFromDb.length.toString(),
                style: const TextStyle(color: Colors.white),
              ),
              child: IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  color: Colors.black,
                  onPressed: () => PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: const CartPage(),
                      withNavBar: false)),
            );
          },
        ),
      ],
      bottom: const MainTabBar());
}
