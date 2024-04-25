import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/models/shipping_address_model.dart';

class ShippingAddressesProvider with ChangeNotifier {
  List<ShippingAddress> shippingAddresses = [];
  String? selectedShippingAddressFirstName;
  ShippingAddress? selectedshippingAddress;
  void storeSelectedShippingAddress(String value) async {
    var user = userbox.get(1);
    DocumentReference userRef = userDatabase.doc(user?.userEmail);
    selectedshippingAddress =
        shippingAddresses.firstWhere((element) => element.firstName == value);

    await userRef.set(
        {"selectedShippingAddress": selectedshippingAddress!.toFireStoreJson()},
        SetOptions(merge: true));

    notifyListeners();
  }

  void selectingaddress(String value) {
    selectedShippingAddressFirstName = value;
    notifyListeners();
  }

  Future<void> saveShippingAddresstoDb(ShippingAddress shippingAddress) async {
    var user = userbox.get(1);
    DocumentReference userRef = userDatabase.doc(user?.userEmail);
    final DocumentSnapshot documentSnapshot = await userRef.get();
    final data = documentSnapshot.data() as Map<String, dynamic>;
    final List<dynamic> shippingAddressesMap =
        await data['shippingAddresses'] ?? <dynamic>[];

    shippingAddressesMap.add(shippingAddress.toFireStoreJson());
    shippingAddresses.add(shippingAddress);

    await userRef.update({'shippingAddresses': shippingAddressesMap});
    notifyListeners();
  }

  Future<void> getShippingAddresses() async {
    var user = userbox.get(1);
    DocumentReference userRef = userDatabase.doc(user?.userEmail);
    final DocumentSnapshot documentSnapshot = await userRef.get();
    final data = documentSnapshot.data() as Map<String, dynamic>;
    final shippingAddressesList = await data['shippingAddresses'];

    if (shippingAddressesList != null) {
      for (var shippingAddress in shippingAddressesList) {
        shippingAddresses
            .add(ShippingAddress.fromFireStoreJson(shippingAddress));
      }
    }
    if (data['selectedShippingAddress'] != null) {
      selectedshippingAddress =
          ShippingAddress.fromFireStoreJson(data['selectedShippingAddress']);
    }

    notifyListeners();
  }

  Future<void> updateShippingAddress(ShippingAddress currentShippingAddress,
      ShippingAddress updatedShippingAddress) async {
    var user = userbox.get(1);
    DocumentReference userRef = userDatabase.doc(user?.userEmail);
    final DocumentSnapshot documentSnapshot = await userRef.get();
    final data = documentSnapshot.data() as Map<String, dynamic>;
    List<dynamic> shippingAddressesList =
        await data['shippingAddresses'] ?? <dynamic>[];
    int index = shippingAddressesList.indexWhere(
        (element) => element['firstName'] == currentShippingAddress.firstName);
    if (index != -1) {
      shippingAddressesList[index] = updatedShippingAddress.toFireStoreJson();
      notifyListeners();
    }
    await userRef.update({'shippingAddresses': shippingAddressesList});
  }

  Future<void> deleteShippingAddressFromDb(
      ShippingAddress shippingAddress) async {
    var user = userbox.get(1);
    DocumentReference userRef = userDatabase.doc(user?.userEmail);
    final DocumentSnapshot documentSnapshot = await userRef.get();
    final data = documentSnapshot.data() as Map<String, dynamic>;
    final shippingAddressesList = await data['shippingAddresses'];
    if (shippingAddressesList != null) {
      if (shippingAddress.firstName == selectedshippingAddress?.firstName) {
        selectedshippingAddress = null;
        await userRef.set({
          "selectedShippingAddress": selectedshippingAddress?.toFireStoreJson()
        }, SetOptions(merge: true));
      }
      shippingAddressesList.removeWhere(
          (element) => element['firstName'] == shippingAddress.firstName);
      shippingAddresses.removeWhere(
          (element) => element.firstName == shippingAddress.firstName);
    }

    await userRef.update({'shippingAddresses': shippingAddressesList});
    notifyListeners();
  }
}
