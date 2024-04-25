import 'package:shopping_app/models/variable_attribute_model.dart';

import 'attribute_model.dart';

class ProductVariation {
  String? id;
  String? productID;

  String? regularPrice;
  String? salePrice;
  String? dateOnSaleFrom;
  String? dateOnSaleTo;
  String? stockStatus;
  bool? onSale;
  bool? inStock;
  int? stockQuantity;
  String? featuredImage;
  List<VariableAttribute>? attributeList;
  bool manageStock = false;

  ProductVariation(
      {this.id,
      this.productID,
      this.regularPrice,
      this.salePrice,
      this.dateOnSaleFrom,
      this.dateOnSaleTo,
      this.stockStatus,
      this.onSale,
      this.inStock,
      this.stockQuantity,
      this.featuredImage,
      this.attributeList});

  ProductVariation.fromJson(Map data) {
    id = data['id'].toString();
    productID = data['product_id'].toString();
    regularPrice = data['regular_price'].toString();
    salePrice = data['sale_price'].toString();
    dateOnSaleFrom = data['date_on_sale_from'] is Map
        ? data['date_on_sale_from']['date']
        : data['date_on_sale_from'];
    dateOnSaleTo = data['date_on_sale_to'] is Map
        ? data['date_on_sale_to']['date']
        : data['date_on_sale_to'];
    onSale = data['on_sale'] ?? false;

    inStock = data['in_stock'] ?? data['stock_status'] == 'instock';
    // if (data['manage_stock'] != null) {
    //   if (data['manage_stock'] == 'parent') {
    //     manageStock = inStock ?? false;
    //   } else {
    //     manageStock = data['manage_stock'];
    //   }
    // }

    if (data['feature_image'] != null) {
      featuredImage = data['feature_image'];
    } else if (data['image'] != null) {
      featuredImage = data['image']['src'];
    }

    final attributesData = data['attributes'] as List<dynamic>?;

    stockStatus = data['stock_status'];
    stockQuantity = data['stock_quantity'];
    attributeList = attributesData != null
        ? attributesData
            .map((attributeData) => VariableAttribute.fromJson(attributeData))
            .toList()
        : <VariableAttribute>[];
  }

  Map<String, dynamic> toJson() {
    List<dynamic> attributeListMap = [];

    if (attributeList != null) {
      attributeListMap = attributeList!.map((e) => e.toJson()).toList();
    }
    return {
      "id": id,
      "product_id": productID,
      "regular_price": regularPrice,
      "sale_price": salePrice,
      "date_on_sale_from": dateOnSaleFrom,
      "date_on_sale_to": dateOnSaleTo,
      "stock_status": stockStatus,
      "on_sale": onSale,
      "in_stock": inStock,
      "stock_quantity": stockQuantity,
      "feature_image": featuredImage,
      "attributes_arr": attributeListMap,
      "manage_stock": manageStock
    };
  }
}
