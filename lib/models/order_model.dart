import 'package:shopping_app/models/cart_item_model.dart';
import 'package:shopping_app/models/coupon_model.dart';
import 'package:shopping_app/models/shipping_address_model.dart';

class Order {
  String? id;
  String? parentId;
  String? customerId;
  String? status;
  String? currency;
  String? shippingTotal;
  String? total;
  DateTime? createdAt;
  DateTime? dateModified;
  ShippingAddress? billing;
  ShippingAddress? shipping;
  String? paymentMethod;
  String? paymentMethodTitle;
  String? customerNote;
  List<CartItem>? lineItems = [];
  List<Coupon>? couponLines;

  Order(
      {this.id,
      this.parentId,
      this.customerId,
      this.status,
      this.currency,
      this.shippingTotal,
      this.total,
      this.createdAt,
      this.dateModified,
      this.billing,
      this.shipping,
      this.paymentMethod,
      this.paymentMethodTitle,
      this.customerNote,
      this.lineItems,
      this.couponLines});

  factory Order.fromJson(Map<String, dynamic> data) {
    List<CartItem> lineitemstemp = [];
    data["line_items"]
        .map((e) => lineitemstemp.add((CartItem.fromJson(e))))
        .toList();
    List<dynamic> couponlinesmap = data["coupon_lines"];
    List<Coupon> couponlinesTemp = [];
    for (var coupon in couponlinesmap) {
      couponlinesTemp.add(Coupon.fromOrderJson(coupon));
    }

    return Order(
        id: data["id"].toString(),
        parentId: data["parent_id"].toString(),
        customerId: data["customer_id"].toString(),
        status: data["status"],
        currency: data["currency"],
        shippingTotal: data["shipping_total"],
        total: data["total"],
        createdAt: data["date_created"] != null
            ? DateTime.parse(data["date_created"])
            : DateTime.now(),
        dateModified: data["date_modified"] != null
            ? DateTime.parse(data["date_modified"])
            : DateTime.now(),
        billing: ShippingAddress.fromJson(data["billing"]),
        shipping: ShippingAddress.fromJson(data["shipping"]),
        paymentMethod: data["payment_method"],
        paymentMethodTitle: data["payment_method_title"],
        customerNote: data["customer_note"],
        lineItems: lineitemstemp,
        couponLines: couponlinesTemp);
  }
}
