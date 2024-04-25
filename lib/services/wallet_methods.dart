import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/models/wallet_transaction_model.dart';
import 'package:shopping_app/screens/transfer_successful.dart';
import 'package:shopping_app/services/wordpress_auth_methods.dart';
import 'package:shopping_app/widgets/error_message_dialog.dart';

import '../models/product_model.dart';
import '../models/wallet_model.dart';
import '../widgets/get_data_error_snackbar.dart';
import '../widgets/loading_widget.dart';

int maxRetries = 3;
int retryDelaySeconds = 3;
final Dio dio = Dio();
Future getWalletTransaction(BuildContext context, String userEmail) async {
  for (int retryCount = 0; retryCount < maxRetries; retryCount++) {
    try {
      final response = await dio.get(
        '${baseUrl}wp-json/wc/v3/wallet',
        queryParameters: {'email': userEmail},
        options: Options(
          headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('$consumerKey:$consumerSecret'))}',
          },
        ),
      );
      if (response.statusCode == 200) {
        List<dynamic> transactionsMap = response.data;
        List transactionsList = transactionsMap
            .map((data) => WalletTransaction.fromJson(data))
            .toList();

        return transactionsList;
      }
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

Future getWalletBalance(BuildContext context, String userEmail) async {
  for (int retryCount = 0; retryCount < maxRetries; retryCount++) {
    try {
      final response = await dio.get(
        '${baseUrl}wp-json/wc/v3/wallet/balance',
        queryParameters: {'email': userEmail},
        options: Options(
          headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('$consumerKey:$consumerSecret'))}',
          },
        ),
      );
      if (response.statusCode == 200) {
        Wallet walletDetails = Wallet.fromJson(response.data);
        return walletDetails;
      }
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

Future performTransaction(String senderEmail, String receiverEmail, String note,
    double amount, BuildContext context) async {
  showDialog(
    context: context,
    builder: (context) {
      return const Center(
        child: CustomLoading(),
      );
    },
  );
  bool doesUserExist =
      await WordpressAuthMethods().checkUserExistence(receiverEmail);
  Wallet senderWallet = await getWalletBalance(context, senderEmail) as Wallet;
  if (double.parse(senderWallet.balance!) >= amount) {
    if (doesUserExist) {
      final senderResponse = await dio.post(
        '${baseUrl}wp-json/wc/v3/wallet',
        data: {
          "email": senderEmail,
          "type": "debit",
          "amount": amount,
          "note": note
        },
        options: Options(
          headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('$consumerKey:$consumerSecret'))}',
          },
        ),
      );
      if (senderResponse.statusCode == 200) {
        final receiverResponse = await dio.post(
          '${baseUrl}wp-json/wc/v3/wallet',
          data: {"email": receiverEmail, "type": "credit", "amount": amount},
          options: Options(
            headers: {
              'Authorization':
                  'Basic ${base64Encode(utf8.encode('$consumerKey:$consumerSecret'))}',
            },
          ),
        );
        if (receiverResponse.statusCode == 200) {
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => TransferSuccessfulPage(
              receiver: receiverEmail,
              amount: amount,
              note: note,
            ),
          ));
        }
      } else {
        Navigator.of(context, rootNavigator: true).pop();
        errorMessageDialog("Error occurred, please try again later", context);
      }
    } else {
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
        errorMessageDialog("Receiver User doesn't Exist!", context);
      }
    }
  } else {
    if (context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
      errorMessageDialog("Wallet balance insufficient!", context);
    }
  }
}

Future getWalletProduct(BuildContext context, int amount) async {
  final response = await dio.get(
    '${baseUrl}wp-json/wc-product-api/v1/walletproduct',
  );
  if (response.statusCode == 200) {
    Product walletProduct = Product.fromProductWalletJson(response.data);
    walletProduct.price = amount.toString();
    return walletProduct;
  }
}
