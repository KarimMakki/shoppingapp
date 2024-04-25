import 'package:flutter/material.dart';
import 'package:shopping_app/constants.dart';

import '../models/review_model.dart';
import '../widgets/get_data_error_snackbar.dart';

Future getReviews(int productID, BuildContext context) async {
  int maxRetries = 3; // Maximum number of retry attempts
  int retryDelaySeconds = 3; // Delay between retries in seconds
  for (int retryCount = 0; retryCount < maxRetries; retryCount++) {
    try {
      var responselist = await wcApi.getAsync("products/$productID/reviews");
      List reviewList =
          responselist.map((data) => Review.fromJson(data)).toList();
      return reviewList;
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
