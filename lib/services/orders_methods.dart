import 'package:flutter/material.dart';
import 'package:shopping_app/models/cart_item_model.dart';
import 'package:shopping_app/models/order_model.dart';
import 'package:shopping_app/models/payment_method_model.dart';
import 'package:shopping_app/models/shipping_address_model.dart';
import 'package:shopping_app/models/shipping_method_model.dart';
import 'package:shopping_app/models/user_model.dart';
import 'package:shopping_app/providers/cart_provider.dart';
import 'package:shopping_app/screens/thank_you_page.dart';
import 'package:shopping_app/widgets/error_message_dialog.dart';
import '../constants.dart';
import '../models/coupon_model.dart';
import '../widgets/loading_widget.dart';

Future<void> createOrder(
    BuildContext context,
    PaymentMethod? selectedPaymentMethod,
    ShippingAddress? selectedshippingAddress,
    ShippingMethod? selectedShippingMethod,
    CartProvider cartProvider,
    CartItem? buyNowCartItem,
    Coupon? coupon,
    UserModel user) async {
  var cartItems = cartProvider.selectedCartItems
      .map((cartItem) => cartItem.toJson(coupon, cartProvider))
      .toList();

  if (selectedPaymentMethod == null || selectedShippingMethod == null) {
    errorMessageDialog(
        "Please make sure payment/shipping method is valid", context);
  } else if (selectedshippingAddress == null) {
    errorMessageDialog("Please Select a shipping address", context);
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CustomLoading(),
        );
      },
    );
    await wcApi.postAsync("orders", {
      "payment_method": selectedPaymentMethod.id,
      "payment_method_title": selectedPaymentMethod.title,
      "status": "processing",
      "set_paid": true,
      "date_created": DateTime.now().toString(),
      "customer_id": user.userId,
      "billing": {
        "first_name": selectedshippingAddress!.firstName,
        "last_name": selectedshippingAddress.lastName,
        "address_1": selectedshippingAddress.address1,
        "address_2": selectedshippingAddress.address2,
        "city": selectedshippingAddress.city,
        "postcode": selectedshippingAddress.postcode,
        "country": selectedshippingAddress.country!.name,
        "phone": selectedshippingAddress.phoneNo
      },
      "shipping": {
        "first_name": selectedshippingAddress.firstName,
        "last_name": selectedshippingAddress.lastName,
        "address_1": selectedshippingAddress.address1,
        "address_2": selectedshippingAddress.address2,
        "city": selectedshippingAddress.city,
        "postcode": selectedshippingAddress.postcode,
        "country": selectedshippingAddress.country!.name,
        "phone": selectedshippingAddress.phoneNo
      },
      "line_items": buyNowCartItem == null
          ? cartItems
          : [buyNowCartItem.toJson(coupon, cartProvider)],
      if (coupon != null)
        "coupon_lines": [
          {"code": coupon.code, "discount": coupon.amount!.toString()}
        ],
      "shipping_lines": [
        {
          "method_id": selectedShippingMethod.methodId,
          "method_title": selectedShippingMethod.methodTitle,
          "total": selectedShippingMethod.cost.toString()
        }
      ]
    });
    if (buyNowCartItem == null) {
      cartProvider.clearOrderedCartItemData();
    }
    if (context.mounted) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const ThankYouPage(),
      ));
    }
  }
}

Future<List<Order>> getOrders() async {
  var user = userbox.get(1);
  var response =
      await wcApi.getAsync("orders?customer=${user!.userId}&lang=en");
  List<Order> orderList = [];
  response.map((data) => orderList.add(Order.fromJson(data))).toList();
  return orderList;
}

Future<void> createWalletOrder(
    BuildContext context,
    PaymentMethod? selectedPaymentMethod,
    ShippingAddress? selectedshippingAddress,
    CartProvider cartProvider,
    CartItem buyNowCartItem,
    Coupon? coupon,
    UserModel user) async {
  var cartItems = cartProvider.selectedCartItems
      .map((cartItem) => cartItem.toJson(coupon, cartProvider))
      .toList();

  if (selectedPaymentMethod == null) {
    errorMessageDialog(
        "Please make sure payment/shipping method is valid", context);
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CustomLoading(),
        );
      },
    );
    await wcApi.postAsync("orders", {
      "payment_method": selectedPaymentMethod.id,
      "payment_method_title": selectedPaymentMethod.title,
      "status": "processing",
      "set_paid": true,
      "date_created": DateTime.now().toString(),
      "customer_id": user.userId,
      "billing": {
        "first_name": selectedshippingAddress!.firstName,
        "last_name": selectedshippingAddress.lastName,
        "address_1": selectedshippingAddress.address1,
        "address_2": selectedshippingAddress.address2,
        "city": selectedshippingAddress.city,
        "postcode": selectedshippingAddress.postcode,
        "country": selectedshippingAddress.country!.name,
        "phone": selectedshippingAddress.phoneNo
      },
      "shipping": {
        "first_name": selectedshippingAddress.firstName,
        "last_name": selectedshippingAddress.lastName,
        "address_1": selectedshippingAddress.address1,
        "address_2": selectedshippingAddress.address2,
        "city": selectedshippingAddress.city,
        "postcode": selectedshippingAddress.postcode,
        "country": selectedshippingAddress.country!.name,
        "phone": selectedshippingAddress.phoneNo
      },
      "line_items": [buyNowCartItem.toJson(coupon, cartProvider)],
    });

    if (context.mounted) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const ThankYouPage(),
      ));
    }
  }
}
