import 'package:flutter/material.dart';
import 'package:shopping_app/constants.dart';

void errorMessageDialog(String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
        title: const Icon(
          Icons.info_outline,
          color: kPrimaryColor,
          size: 30,
        ),
      );
    },
  );
}
