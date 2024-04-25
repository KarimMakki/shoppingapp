import 'package:flutter/material.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/screens/credit_debit_history.dart';
import 'package:shopping_app/widgets/keepPageAlive.dart';

import '../services/wallet_methods.dart';

class WalletHistory extends StatefulWidget {
  const WalletHistory({super.key});

  @override
  State<WalletHistory> createState() => _WalletHistoryState();
}

class _WalletHistoryState extends State<WalletHistory> {
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: const Text("History"),
          backgroundColor: kPrimaryColor,
          bottom: const TabBar(
            labelColor: Colors.white,
            tabs: [
              Tab(
                child: Text(
                  "Credit",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ),
              Tab(
                child: Text(
                  "Debit",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: const TabBarView(children: [
          KeepPageAlive(
              child: CreditDebitHistory(
            isCredit: true,
          )),
          KeepPageAlive(
              child: CreditDebitHistory(
            isCredit: false,
          ))
        ]),
      ),
    );
  }
}
