import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/models/cart_item_model.dart';
import 'package:shopping_app/models/product_model.dart';
import 'package:shopping_app/screens/wallet_checkout.dart';
import 'package:shopping_app/services/wallet_methods.dart';
import 'package:shopping_app/widgets/loading_widget.dart';

class WalletTopupPage extends StatefulWidget {
  const WalletTopupPage({super.key});

  @override
  State<WalletTopupPage> createState() => _WalletTopupPageState();
}

class _WalletTopupPageState extends State<WalletTopupPage> {
  TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("Top up"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Enter an amount",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 35,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.2),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: amountController,
                      keyboardType: const TextInputType.numberWithOptions(),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  const Text(
                    "SDG",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            MaterialButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CustomLoading();
                  },
                );
                Product walletproduct = await getWalletProduct(
                    context, int.parse(amountController.text));
                CartItem walletproductCartItem = CartItem(
                    product: walletproduct,
                    productName: walletproduct.name,
                    productPrice: walletproduct.price,
                    quantity: 1,
                    productImage:
                        "https://lenzo.online/wp-content/uploads/2023/07/sg-11134201-22110-41qv18m1j9jv4b.jpeg",
                    id: walletproduct.id.toString());
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WalletCheckout(
                    buyNowCartItem: walletproductCartItem,
                  ),
                ));
              },
              color: kPrimaryColor,
              minWidth: MediaQuery.of(context).size.width * 0.5,
              child: const Text(
                "Top Up",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
