import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/models/attribute_model.dart';
import 'package:shopping_app/models/image_model.dart';
import 'package:shopping_app/models/product_variation_model.dart';
import '../models/product_model.dart';

class WishlistProvider with ChangeNotifier {
  List<Product> products = [];

  int get wishlistCount => products.length;

  Future<void> getWishlist() async {
    var user = userbox.get(1);
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');

    // Fetch the user document
    DocumentSnapshot userSnapshot =
        await userCollection.doc(user!.userEmail).get();

    // Fetch the subcollection 'wishlist'
    QuerySnapshot postsSnapshot =
        await userSnapshot.reference.collection('wishlist').get();
    List<Attribute> productAttributes = [];
    List<Images> productImages = [];
    List<ProductVariation> variationProducts = [];
    // Directly add subcollection documents to the 'wishlist'
    if (products.isEmpty) {
      for (var doc in postsSnapshot.docs) {
        for (var attribute in doc['attributes']) {
          productAttributes.add(Attribute.fromJson(attribute));
        }
        for (var image in doc['images']) {
          productImages.add(Images.fromJson(image));
        }
        for (var variation in doc['product_variations']) {
          variationProducts.add(ProductVariation.fromJson(variation));
        }
        products.add(Product(
            id: doc['id'],
            name: doc['name'],
            type: doc['type'],
            price: doc['price'],
            mainImagesrc: doc['main_image'],
            attributes: productAttributes,
            averageRating: doc['averageRating'],
            images: productImages,
            ratingCount: doc['ratingCount'],
            variationProducts: variationProducts));
      }
    }

    notifyListeners();
  }

  Future<void> saveWishlistItemToUser(Product product) async {
    DocumentReference userDatabaseRef = FirebaseFirestore.instance
        .collection('users')
        .doc(currentLoggedinUser!.userEmail);
    CollectionReference wishlistRef = userDatabaseRef.collection('wishlist');
    await wishlistRef.doc(product.id.toString()).set(product.toFireStoreJson());

    //     .then((docRef) {
    //   print('Custom object saved with ID: ${docRef}');
    // }).catchError((error) {
    //   print('Error saving custom object: $error');
    // });
  }

  void addtoWishlist(String userEmail, Product product) async {
    final isExist = products.indexWhere((item) => item.id == product.id) != -1;
    if (!isExist) {
      await saveWishlistItemToUser(product);
      products.add(product);
      notifyListeners();
    }
  }

  Future<void> deleteWishlistItemFromUser(Product product) async {
    DocumentReference userDatabaseRef = FirebaseFirestore.instance
        .collection('users')
        .doc(currentLoggedinUser!.userEmail);
    CollectionReference wishlistRef = userDatabaseRef.collection('wishlist');
    wishlistRef.doc(product.id.toString()).delete();
  }

  void removefromWishlist(Product product) async {
    products.removeWhere((productinList) => productinList.id == product.id);
    await deleteWishlistItemFromUser(product);
    notifyListeners();
  }

  void clearWishlist() {
    products.clear();
    notifyListeners();
  }
}
