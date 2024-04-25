import 'package:flutter/material.dart';
import 'package:shopping_app/models/coupon_model.dart';
import 'package:shopping_app/widgets/get_data_error_snackbar.dart';
import '../constants.dart';

Future getCoupons(BuildContext context) async {
  int maxRetries = 3; // Maximum number of retry attempts
  int retryDelaySeconds = 3; // Delay between retries in seconds
  for (int retryCount = 0; retryCount < maxRetries; retryCount++) {
    try {
      var responselist = await wcApi.getAsync("coupons");
      List couponsList =
          responselist.map((data) => Coupon.fromJson(data)).toList();
      return couponsList;
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
