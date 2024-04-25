import 'package:flutter/material.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/models/payment_method_model.dart';
import 'package:shopping_app/widgets/get_data_error_snackbar.dart';

Future getPaymentMethods(BuildContext context) async {
  int maxRetries = 3; // Maximum number of retry attempts
  int retryDelaySeconds = 3; // Delay between retries in seconds
  for (int retryCount = 0; retryCount < maxRetries; retryCount++) {
    try {
      final response = await wcApi.getAsync('payment_gateways?lang=en');
      final List<Map<String, dynamic>> paymentmethods =
          response.cast<Map<String, dynamic>>();
      List<PaymentMethod> paymentMethodslist =
          paymentmethods.map((e) => PaymentMethod.fromJson(e)).toList();
      return paymentMethodslist;
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
