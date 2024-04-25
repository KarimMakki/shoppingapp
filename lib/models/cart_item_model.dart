import 'package:shopping_app/models/product_model.dart';
import 'package:shopping_app/models/product_variation_model.dart';
import 'package:shopping_app/providers/cart_provider.dart';

import 'coupon_model.dart';

class CartItem {
  String? id;
  ProductVariation? variation;
  Product? product;
  String? productName;
  String? productPrice;
  int? quantity;
  String? productImage;
  String? productVariant;
  CartItem({
    this.product,
    this.variation,
    this.productVariant,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.productImage,
    required this.id,
  });

  // Override the == operator to compare two CustomClass objects for equality
  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is CartItem && id == other.id);

  // Override the hashCode method
  @override
  int get hashCode => id.hashCode;

  String get getTotal => (quantity! * double.parse(productPrice!)).toString();

  factory CartItem.fromFireStoreJson(Map<String, dynamic> data) {
    return CartItem(
        productName: data['name'],
        productPrice: data['price'],
        quantity: data['quantity'],
        productImage: data['image'],
        id: data['id'],
        productVariant: data['productVariant']);
  }

  factory CartItem.fromJson(Map<String, dynamic> data) {
    return CartItem(
        id: data["variation_id"]?.toString() ?? data["product_id"]?.toString(),
        productName: data["name"],
        productPrice: data["price"].toStringAsFixed(2),
        quantity: int.tryParse("${data["quantity"]}") ?? 0,
        product: Product.fromJson(data["product_data"]),
        productImage: data["image"]["src"],
        productVariant:
            data["meta_data"].map((map) => map["display_value"]).join('-'));
  }

  Map<String, dynamic> toFireStoreJson() => {
        "id": id,
        "name": productName,
        "price": productPrice,
        "quantity": quantity,
        "image": productImage,
        "productVariant": productVariant
      };

  Map<String, dynamic> toJson([Coupon? coupon, CartProvider? cartProvider]) {
    String portionofDiscount = "";
    List itemswithHigheramount = [];

    if (coupon != null && cartProvider!.selectedCartItems.isNotEmpty) {
      portionofDiscount =
          (coupon.amount! / cartProvider.selectedCartItems.length).toString();
      for (var item in cartProvider.selectedCartItems) {
        if (double.parse(item.getTotal) >= double.parse(portionofDiscount)) {
          itemswithHigheramount.add(item);
        }
      }
    }
    if (coupon != null) {
      int itemswithHigheramountLength =
          itemswithHigheramount.isNotEmpty ? itemswithHigheramount.length : 1;
      portionofDiscount =
          (coupon.amount! / itemswithHigheramountLength).toString();
    }
    return {
      "product_id": id,
      "name": productName,
      "quantity": quantity,
      "featuredImage": productImage,
      "total": coupon == null
          ? getTotal
          : double.parse(portionofDiscount) <= double.parse(getTotal)
              ? (double.parse(getTotal) - double.parse(portionofDiscount))
                  .toStringAsFixed(2)
              : getTotal
    };
  }
}
