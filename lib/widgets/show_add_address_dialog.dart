import 'package:flutter/material.dart';
import 'package:shopping_app/screens/choose_address.dart';

void showAddAddressDialog(BuildContext context) {
  return WidgetsBinding.instance.addPostFrameCallback(
    (timeStamp) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Your currently have no address'),
          content: const Text('Please add an address to use it for your order'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const ChooseAddressPage(),
                )); // Close the dialog
              },
              child: const Text('Select an Address'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Back'),
            ),
          ],
        );
      },
    ),
  );
}
