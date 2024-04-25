import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import '../../providers/cart_provider.dart';
import '../../screens/cart.dart';

AppBar productDetailsAppBar(BuildContext context) {
  return AppBar(
    toolbarHeight: 40,
    backgroundColor: Colors.white,
    elevation: 1,
    leading: Row(
      children: [
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: BackButton(
            color: Colors.black,
            onPressed: () {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              Navigator.pop(context);
            },
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: IconButton(
            icon: const Icon(Icons.mail_outline),
            color: Colors.black,
            onPressed: () {},
          ),
        ),
      ],
    ),
    actions: [
      Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return badges.Badge(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const CartPage(),
            )),
            position: badges.BadgePosition.custom(start: 25, top: 10),
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
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const CartPage(),
              )),
            ),
          );
        },
      ),
      IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_vert,
            color: Colors.black,
          ))
    ],
  );
}
