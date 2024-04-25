import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/cart_provider.dart';
import 'package:shopping_app/screens/mainpage.dart';

AppBar cartAppBar(BuildContext context) {
  return AppBar(
    centerTitle: false,
    toolbarHeight: 40,
    backgroundColor: Colors.white,
    elevation: 1,
    leading: Navigator.canPop(context)
        ? BackButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          )
        : Container(),
    title: Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return Text(
          "Shopping Cart (${cartProvider.selectedCartItems.length})",
          style: const TextStyle(color: Colors.black),
        );
      },
    ),
  );
}
