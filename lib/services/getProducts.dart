import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/models/product_model.dart';
import 'package:shopping_app/widgets/get_data_error_snackbar.dart';

Future<void> getProducts(
    String categoryID,
    int pageKey,
    PagingController pagingController,
    int numberOfPostsPerRequest,
    BuildContext context) async {
  // int _numberOfPostsPerRequest = 10;

  var responselist = await wcApi.getAsync(
      "products?category=$categoryID&lang=en&page=$pageKey&limit=$numberOfPostsPerRequest");
  List productsList =
      responselist.map((data) => Product.fromJson(data)).toList();
  final isLastPage = productsList.length < numberOfPostsPerRequest;
  if (isLastPage) {
    pagingController.appendLastPage(productsList);
  } else {
    final nextPagekey = pageKey + 1;
    pagingController.appendPage(productsList, nextPagekey);
  }
}
