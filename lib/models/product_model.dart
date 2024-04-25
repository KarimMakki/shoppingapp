import 'package:flutter/material.dart';
import 'package:shopping_app/models/attribute_model.dart';
import 'package:shopping_app/models/product_variation_model.dart';

import 'category_model.dart';
import 'image_model.dart';

class Product {
  int id;
  String? name;
  String? permalink;
  String? type;
  String? status;
  String? description;
  String? short_description;
  bool? featured;
  String? price;
  String? regular_price;
  String? sale_price;
  bool? on_sale;
  bool? manage_stock;
  int? ratingCount;
  String? averageRating;
  String? categoryID;
  List<Category>? categories;
  List<Images>? images;
  List<Attribute>? attributes;
  List<ProductVariation>? variationProducts;
  String? mainImagesrc;

  Product(
      {required this.id,
      required this.name,
      this.permalink,
      required this.type,
      this.status,
      this.description,
      this.short_description,
      this.featured,
      required this.price,
      this.regular_price,
      this.sale_price,
      this.on_sale,
      this.manage_stock,
      this.ratingCount,
      this.averageRating,
      this.categories,
      this.images,
      this.attributes,
      this.categoryID,
      this.variationProducts,
      this.mainImagesrc});

  factory Product.fromJson(Map<String, dynamic> data) {
    final id = data['id'];
    if (id is! int) {
      throw FormatException(
          'Invalid JSON: required "id" field of type int in $data');
    }
    final name = data['name'];
    if (name is! String) {
      throw FormatException(
          'Invalid JSON: required "name" field of type String in $data');
    }
    final type = data['type'];
    if (type is! String) {
      throw FormatException(
          'Invalid JSON: required "type" field of type String in $data');
    }
    final permalink = data['permalink'];
    if (permalink is! String) {
      throw FormatException(
          'Invalid JSON: required "permalink" field of type String in $data');
    }
    final status = data['status'];
    if (status is! String) {
      throw FormatException(
          'Invalid JSON: required "status" field of type String in $data');
    }
    final description = data['description'];
    if (description is! String) {
      throw FormatException(
          'Invalid JSON: required "description" field of type String in $data');
    }
    final short_description = data['short_description'];
    if (short_description is! String) {
      throw FormatException(
          'Invalid JSON: required "short_description" field of type String in $data');
    }
    final featured = data['featured'];
    if (featured is! bool) {
      throw FormatException(
          'Invalid JSON: required "featured" field of type String in $data');
    }
    final price = data['price'].toString();
    if (price is! String) {
      throw FormatException(
          'Invalid JSON: required "price" field of type String in $data');
    }
    final regular_price = data['regular_price'].toString();
    if (regular_price is! String) {
      throw FormatException(
          'Invalid JSON: required "regular_price" field of type String in $data');
    }
    final sale_price = data['sale_price'].toString();
    if (sale_price is! String) {
      throw FormatException(
          'Invalid JSON: required "sale_price" field of type String in $data');
    }
    final on_sale = data['on_sale'];
    if (on_sale is! bool) {
      throw FormatException(
          'Invalid JSON: required "on_sale" field of type String in $data');
    }
    final manage_stock = data['manage_stock'];
    if (manage_stock is! bool) {
      throw FormatException(
          'Invalid JSON: required "manage_stock" field of type String in $data');
    }
    final ratingCount = data['rating_count'];
    if (ratingCount is! int) {
      throw FormatException(
          'Invalid JSON: required "ratingCount" field of type int in $data');
    }
    final averageRating = data['average_rating'];
    if (averageRating is! String) {
      throw FormatException(
          'Invalid JSON: required "averageRating" field of type String in $data');
    }

    final imagesData = data['images'] as List<dynamic>?;
    final attributesData = data['attributes'] as List<dynamic>?;
    final categoriesData = data['categories'] as List<dynamic>?;
    final categoryID =
        data['categories'] != null && data['categories'].length > 0
            ? data['categories'][0]['id'].toString()
            : '0';
    List<ProductVariation> variationProducts = [];
    if (type == 'variable' && data['product_variations'] != null) {
      for (var item in data['product_variations']) {
        variationProducts.add(ProductVariation.fromJson(item));
      }
    }

    return Product(
        id: id,
        name: name,
        permalink: permalink,
        type: type,
        status: status,
        description: description,
        short_description: short_description,
        featured: featured,
        price: price,
        regular_price: regular_price,
        sale_price: sale_price,
        on_sale: on_sale,
        manage_stock: manage_stock,
        ratingCount: ratingCount,
        averageRating: averageRating,
        categoryID: categoryID,
        images: imagesData != null
            ? imagesData
                .map((imageData) =>
                    Images.fromJson(imageData as Map<String, dynamic>))
                .toList()
            : <Images>[],
        attributes: attributesData != null
            ? attributesData
                .map((attributeData) =>
                    Attribute.fromJson(attributeData as Map<String, dynamic>))
                .toList()
            : <Attribute>[],
        categories: categoriesData != null
            ? categoriesData
                .map((categoryData) =>
                    Category.fromJson(categoryData as Map<String, dynamic>))
                .toList()
            : <Category>[],
        variationProducts: variationProducts);
  }

  factory Product.fromFireStoreJson(Map<String, dynamic> data) {
    List<Images> imagesTemp = [];
    List<Attribute> attributesTemp = [];
    List<ProductVariation> variationProductsTemp = [];
    if (data['images'] != null) {
      data["images"].map((e) => imagesTemp.add((Images.fromJson(e)))).toList();
    }
    if (data["attributes"] != null) {
      data["attributes"]
          .map((e) => attributesTemp.add(Attribute.fromJson(e)))
          .toList();
    }
    if (data["product_variations"] != null) {
      data["product_variations"]
          .map((e) => variationProductsTemp.add(ProductVariation.fromJson(e)))
          .toList();
    }
    return Product(
        id: data["id"],
        name: data["name"],
        type: data["type"],
        price: data["price"],
        categoryID: data["categoryID"],
        mainImagesrc: data["main_image"],
        images: imagesTemp,
        attributes: attributesTemp,
        variationProducts: variationProductsTemp,
        ratingCount: data["ratingCount"],
        averageRating: data["averageRating"]);
  }

  Map<String, dynamic> toFireStoreJson() {
    List<dynamic> imagesMap = [];
    List<dynamic> attributesMap = [];
    List<dynamic> variationsMap = [];
    if (images != null) {
      imagesMap = images!.map((e) => e.toJson()).toList();
    }
    if (attributes != null) {
      attributesMap = attributes!.map((e) => e.toJson()).toList();
    }
    if (variationProducts != null) {
      variationsMap = variationProducts!.map((e) => e.toJson()).toList();
    }
    return {
      "id": id,
      "name": name,
      "type": type,
      "price": price,
      "categoryID": categoryID,
      "regular_price": regular_price,
      "sale_price": sale_price,
      "main_image": images?[0].src,
      "images": imagesMap,
      "attributes": attributesMap,
      "ratingCount": ratingCount,
      "averageRating": averageRating,
      "product_variations": variationsMap
    };
  }

  factory Product.fromProductWalletJson(Map<String, dynamic> data) {
    final id = data['id'];
    if (id is! int) {
      throw FormatException(
          'Invalid JSON: required "id" field of type int in $data');
    }
    final name = data['name'];
    if (name is! String) {
      throw FormatException(
          'Invalid JSON: required "name" field of type String in $data');
    }
    final type = data['status'];
    if (type is! String) {
      throw FormatException(
          'Invalid JSON: required "type" field of type String in $data');
    }

    final status = data['status'];
    if (status is! String) {
      throw FormatException(
          'Invalid JSON: required "status" field of type String in $data');
    }
    final description = data['description'];
    if (description is! String) {
      throw FormatException(
          'Invalid JSON: required "description" field of type String in $data');
    }
    final short_description = data['short_description'];
    if (short_description is! String) {
      throw FormatException(
          'Invalid JSON: required "short_description" field of type String in $data');
    }
    final featured = data['featured'];
    if (featured is! bool) {
      throw FormatException(
          'Invalid JSON: required "featured" field of type String in $data');
    }
    final price = data['price'];
    if (price is! String) {
      throw FormatException(
          'Invalid JSON: required "price" field of type String in $data');
    }
    final regular_price = data['regular_price'];
    if (regular_price is! String) {
      throw FormatException(
          'Invalid JSON: required "regular_price" field of type String in $data');
    }
    final sale_price = data['sale_price'];
    if (sale_price is! String) {
      throw FormatException(
          'Invalid JSON: required "sale_price" field of type String in $data');
    }

    final manage_stock = data['manage_stock'];
    if (manage_stock is! bool) {
      throw FormatException(
          'Invalid JSON: required "manage_stock" field of type String in $data');
    }

    final averageRating = data['average_rating'];
    if (averageRating is! String) {
      throw FormatException(
          'Invalid JSON: required "averageRating" field of type String in $data');
    }

    final imagesData = data['images'] as List<dynamic>?;
    final attributesData = data['attributes'] as List<dynamic>?;
    final categoriesData = data['categories'] as List<dynamic>?;
    final categoryID =
        data['categories'] != null && data['categories'].length > 0
            ? data['categories'][0]['id'].toString()
            : '0';
    List<ProductVariation> variationProducts = [];
    if (type == 'variable' && data['product_variations'] != null) {
      for (var item in data['product_variations']) {
        variationProducts.add(ProductVariation.fromJson(item));
      }
    }

    return Product(
        id: id,
        name: name,
        type: type,
        status: status,
        description: description,
        short_description: short_description,
        featured: featured,
        price: price,
        regular_price: regular_price,
        sale_price: sale_price,
        manage_stock: manage_stock,
        averageRating: averageRating,
        categoryID: categoryID,
        images: imagesData != null
            ? imagesData
                .map((imageData) =>
                    Images.fromJson(imageData as Map<String, dynamic>))
                .toList()
            : <Images>[],
        attributes: attributesData != null
            ? attributesData
                .map((attributeData) =>
                    Attribute.fromJson(attributeData as Map<String, dynamic>))
                .toList()
            : <Attribute>[],
        categories: categoriesData != null
            ? categoriesData
                .map((categoryData) =>
                    Category.fromJson(categoryData as Map<String, dynamic>))
                .toList()
            : <Category>[],
        variationProducts: variationProducts);
  }

  bool get isVariableProduct => type == 'variable';

  bool get isSimpleProduct => type == 'simple';

  bool get isGroupedProduct => type == 'grouped';
}
