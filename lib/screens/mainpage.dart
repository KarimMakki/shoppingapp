import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/providers/cart_provider.dart';
import 'package:shopping_app/providers/coupons_provider.dart';
import 'package:shopping_app/providers/shipping_addresses_provider.dart';
import 'package:shopping_app/providers/wishlist_provider.dart';
import 'package:shopping_app/screens/profile.dart';
import 'package:shopping_app/screens/wallet.dart';
import 'package:shopping_app/services/wallet_methods.dart';
import 'cart.dart';
import 'categories.dart';
import 'homepage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> pages = [];

  @override
  void initState() {
    pages = const [Homepage(), CategoriesPage(), CartPage(), ProfilePage()];

    if (userbox.isNotEmpty) {
      Provider.of<WishlistProvider>(context, listen: false).getWishlist();
      Provider.of<CartProvider>(context, listen: false).getCartItems();
      Provider.of<ShippingAddressesProvider>(context, listen: false)
          .getShippingAddresses();
      Provider.of<CouponProvider>(context, listen: false).getCoupons();
    }

    super.initState();
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: ("Home"),
          activeColorPrimary: kPrimaryColor,
          inactiveColorPrimary: Colors.black,
          activeColorSecondary: kPrimaryColor,
          textStyle: const TextStyle(fontWeight: FontWeight.bold)),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.search),
          title: ("Category"),
          activeColorPrimary: kPrimaryColor,
          inactiveColorPrimary: Colors.black,
          textStyle: const TextStyle(fontWeight: FontWeight.bold)),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.shopping_cart_outlined),
          title: ("Cart"),
          activeColorPrimary: kPrimaryColor,
          inactiveColorPrimary: Colors.black,
          textStyle: const TextStyle(fontWeight: FontWeight.bold)),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          title: ("Me"),
          activeColorPrimary: kPrimaryColor,
          inactiveColorPrimary: Colors.black,
          textStyle: const TextStyle(fontWeight: FontWeight.bold)),
    ];
  }

  final controller = PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller,
      screens: pages,
      items: _navBarsItems(),
    );
  }
}
