import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/models/wallet_transaction_model.dart';
import 'package:shopping_app/widgets/custom_divider.dart';

class TransactionTile extends StatelessWidget {
  final WalletTransaction walletTransaction;
  const TransactionTile({super.key, required this.walletTransaction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.account_balance_wallet_outlined,
              color: kPrimaryColor,
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Transaction ID: ${walletTransaction.transactionID}',
                  style: TextStyle(fontSize: 13),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  "${walletTransaction.type}",
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  DateFormat('yyyy-MM-dd').format(walletTransaction.date),
                  style: TextStyle(fontSize: 13),
                )
              ],
            ),
            trailing: Text(
              walletTransaction.isCredit
                  ? "+${walletTransaction.amount}SDG"
                  : "-${walletTransaction.amount}SDG",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: walletTransaction.isCredit
                      ? const Color.fromARGB(255, 16, 163, 21)
                      : Colors.black),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          const CustomDivider()
        ],
      ),
    );
  }
}
