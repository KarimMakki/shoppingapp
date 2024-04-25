import 'package:flutter/material.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/models/category_model.dart';
import 'package:shopping_app/widgets/get_data_error_snackbar.dart';

import '../widgets/error_message_dialog.dart';

int maxRetries = 3; // Maximum number of retry attempts
int retryDelaySeconds = 3;
Future getParentCategories(BuildContext context) async {
  for (int retryCount = 0; retryCount < maxRetries; retryCount++) {
    try {
      var responselist = await wcApi
          .getAsync("products/categories?lang=en&parent=0&per_page=30");
      List categoriesList =
          responselist.map((data) => Category.fromJson(data)).toList();
      return categoriesList;
    } catch (e) {
      if (retryCount < maxRetries - 1) {
        print('Retrying in $retryDelaySeconds seconds...');
        await Future.delayed(Duration(seconds: retryDelaySeconds));
      }
      if (retryCount == maxRetries - 1) {
        SnackBarError.show(context, "error showing data", () => null);
      }
    }
  } // Delay between retries in seconds
}

Future getChildCategories(int parentID, BuildContext context) async {
  for (int retryCount = 0; retryCount < maxRetries; retryCount++) {
    try {
      var responselist =
          await wcApi.getAsync("products/categories?lang=en&parent=$parentID");
      List childCategoriesList =
          responselist.map((data) => Category.fromJson(data)).toList();
      return childCategoriesList;
    } catch (e) {
      if (retryCount < maxRetries - 1) {
        print('Retrying in $retryDelaySeconds seconds...');
        await Future.delayed(Duration(seconds: retryDelaySeconds));
      }
      if (retryCount == maxRetries - 1) {
        SnackBarError.show(context, "Error showing data", () => null);
      }
    }
  }
}
