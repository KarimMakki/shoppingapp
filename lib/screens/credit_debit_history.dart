import 'package:flutter/material.dart';
import 'package:shopping_app/screens/wallet_transaction_tile.dart';

import '../constants.dart';
import '../models/wallet_transaction_model.dart';
import '../services/wallet_methods.dart';
import '../widgets/loading_widget.dart';

class CreditDebitHistory extends StatefulWidget {
  final bool isCredit;
  const CreditDebitHistory({super.key, required this.isCredit});

  @override
  State<CreditDebitHistory> createState() => _CreditDebitHistoryState();
}

class _CreditDebitHistoryState extends State<CreditDebitHistory> {
  final user = userbox.get(1);
  late final getWalletTransactions =
      getWalletTransaction(context, user!.userEmail!);
  @override
  void initState() {
    getWalletTransactions;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getWalletTransactions,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              WalletTransaction walletTransaction = snapshot.data[index];
              if (walletTransaction.isCredit == widget.isCredit) {
                WalletTransaction debitWallet = walletTransaction;
                return TransactionTile(walletTransaction: debitWallet);
              }
              return const SizedBox();
            },
          );
        }
        return const Center(child: CustomLoading());
      },
    );
  }
}
