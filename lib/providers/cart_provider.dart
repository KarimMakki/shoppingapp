import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/constants.dart';

import '../models/cart_item_model.dart';

class CartProvider with ChangeNotifier {
  final int _quantity = 1;
  int get quantity => _quantity;
  int _totalPrice = 0;
  int get totalPrice {
    // we use the fold method on the products list. The fold method starts with an initial value of 0 (sum)
    // and iterates through each element in the list
    _totalPrice = selectedCartItems.fold(
        0,
        (sum, cartitem) =>
            sum + int.parse(cartitem.productPrice!) * cartitem.quantity!);
    return _totalPrice;
  }

  Set<CartItem> selectedCartItems = {};

  List<CartItem> cartItemsFromDb = [];

  Future<void> getCartItems() async {
    var user = userbox.get(1);
    DocumentReference userRef = userDatabase.doc(user?.userEmail);
    final DocumentSnapshot documentSnapshot = await userRef.get();
    final data = documentSnapshot.data() as Map<String, dynamic>;
    final cartItemsList = await data['cartItems'];

    if (cartItemsList != null) {
      for (var cartItem in cartItemsList) {
        cartItemsFromDb.add(CartItem.fromFireStoreJson(cartItem));
      }
    }

    notifyListeners();
  }

  Future<void> saveCartItemToDb(CartItem cartItem) async {
    var user = userbox.get(1);
    DocumentReference userRef = userDatabase.doc(user?.userEmail);
    final DocumentSnapshot documentSnapshot = await userRef.get();
    final data = documentSnapshot.data() as Map<String, dynamic>;
    final List<dynamic> cartItemsMap = await data['cartItems'] ?? <dynamic>[];

    cartItemsMap.add(cartItem.toFireStoreJson());
    cartItemsFromDb.add(cartItem);

    await userRef.update({'cartItems': cartItemsMap});
    notifyListeners();
  }

  Future<void> deleteCartItemfromDb(CartItem cartItem) async {
    var user = userbox.get(1);
    DocumentReference userRef = userDatabase.doc(user?.userEmail);
    // Step 1: Retrieve the existing list of cartItems from Firestore
    final DocumentSnapshot documentSnapshot = await userRef.get();
    final data = documentSnapshot.data() as Map<String, dynamic>;
    final List<dynamic> cartItemsMap = data['cartItems'] ?? <dynamic>[];

    // Step 2: Find and remove the cartItem with the given ID from the list
    cartItemsMap.removeWhere((element) => element['id'] == cartItem.id);
    cartItemsFromDb.removeWhere((element) => element.id == cartItem.id);
    selectedCartItems.removeWhere((element) => element.id == cartItem.id);

    // Step 3: Update the Firestore document with the modified list
    await userRef.update({'cartItems': cartItemsMap});
    notifyListeners();
  }

  Future<void> updateQuantityonDb(CartItem cartItem, int editedQuantity) async {
    var user = userbox.get(1);
    DocumentReference userRef = userDatabase.doc(user?.userEmail);
    final DocumentSnapshot documentSnapshot = await userRef.get();
    final data = documentSnapshot.data() as Map<String, dynamic>;
    final List<dynamic> cartItemsMap = data['cartItems'] ?? <dynamic>[];

    int index =
        cartItemsMap.indexWhere((element) => element['id'] == cartItem.id);
    if (index != -1) {
      cartItemsMap[index]['quantity'] = editedQuantity;
      selectedCartItems.clear();
      notifyListeners();
    }

    await userRef.update({"cartItems": cartItemsMap});
  }

  Future<void> updateQuantityinCart(
      int updatedQuantity, CartItem cartItem) async {
    var user = userbox.get(1);
    DocumentReference userRef = userDatabase.doc(user?.userEmail);
    final DocumentSnapshot documentSnapshot = await userRef.get();
    final data = documentSnapshot.data() as Map<String, dynamic>;
    final List<dynamic> cartItemsMap = data['cartItems'] ?? <dynamic>[];

    int index =
        cartItemsMap.indexWhere((element) => element['id'] == cartItem.id);
    if (index != -1) {
      cartItemsMap[index]['quantity'] =
          updatedQuantity + cartItemsMap[index]['quantity'];
      notifyListeners();
    }

    await userRef.update({"cartItems": cartItemsMap});
  }

  Future<void> clearOrderedCartItemData() async {
    var user = userbox.get(1);
    DocumentReference userRef = userDatabase.doc(user?.userEmail);
    final DocumentSnapshot documentSnapshot = await userRef.get();
    final data = documentSnapshot.data() as Map<String, dynamic>;
    List<dynamic> cartItemsMap = data['cartItems'] ?? <dynamic>[];
    List<CartItem> cartItems = cartItemsMap
        .map((cartItem) => CartItem.fromFireStoreJson(cartItem))
        .toList();
    cartItems.removeWhere((cartItem) => selectedCartItems.contains(cartItem));
    cartItemsFromDb
        .removeWhere((cartItem) => selectedCartItems.contains(cartItem));
    selectedCartItems.clear();
    List<dynamic> cartItemsToFireStoreDb =
        cartItems.map((cartItem) => cartItem.toFireStoreJson()).toList();
    await userRef.update({"cartItems": cartItemsToFireStoreDb});
    notifyListeners();
  }

  void addItemtoSelectedCartItems(CartItem cartItem) {
    selectedCartItems.add(cartItem);
    notifyListeners();
  }

  void addAllItemtoSelectedCartItems() {
    selectedCartItems.addAll(cartItemsFromDb);
    notifyListeners();
  }

  void removeItemtoSelectedCartItems(CartItem cartItem) {
    selectedCartItems.remove(cartItem);
    notifyListeners();
  }

  void clearAllItemtoSelectedCartItems() {
    selectedCartItems.clear();
    notifyListeners();
  }
}
