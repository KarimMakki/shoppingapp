import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/services/wallet_methods.dart';

class WalletTransferPage extends StatefulWidget {
  const WalletTransferPage({super.key});

  @override
  State<WalletTransferPage> createState() => _WalletTransferPageState();
}

class _WalletTransferPageState extends State<WalletTransferPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("Transfer to Wallet"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
          height: 500,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: kPrimaryColor,
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.account_balance_wallet,
                        color: kPrimaryColor,
                      ),
                      SizedBox(width: 7),
                      Text(
                        "Transfer to Wallet",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Receiver Email is required";
                      }
                      return null;
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[400]!)),
                        labelText: "Send To",
                        fillColor: Colors.white,
                        filled: true),
                    style: const TextStyle(),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Transfer Amount is required";
                      }
                      return null;
                    },
                    controller: amountController,
                    keyboardType: const TextInputType.numberWithOptions(),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                        labelText: "Amount",
                        fillColor: Colors.white,
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[400]!)),
                        filled: true),
                    style: const TextStyle(),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    controller: noteController,
                    decoration: InputDecoration(
                        labelText: "Note (Optional)",
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[400]!))),
                    style: const TextStyle(),
                  ),
                ),
                const SizedBox(height: 40),
                MaterialButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      performTransaction(
                        currentLoggedinUser!.userEmail!,
                        emailController.text.trim(),
                        noteController.text,
                        double.parse(amountController.text),
                        context,
                      );
                    }
                  },
                  color: kPrimaryColor,
                  minWidth: MediaQuery.of(context).size.width * 0.5,
                  height: 40,
                  child: const Text(
                    "Transfer",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
