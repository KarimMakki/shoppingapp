import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/models/wallet_transaction_model.dart';
import 'package:shopping_app/screens/wallet_history.dart';
import 'package:shopping_app/screens/wallet_topup.dart';
import 'package:shopping_app/screens/wallet_transaction_tile.dart';
import 'package:shopping_app/screens/wallet_transfer.dart';
import 'package:shopping_app/services/wallet_methods.dart';
import 'package:shopping_app/widgets/appbars/walletpage_sliver_appbar.dart';
import 'package:shopping_app/widgets/custom_divider.dart';
import 'package:shopping_app/widgets/loading_widget.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final user = userbox.get(1);
  late final getWalletTransactions =
      getWalletTransaction(context, user!.userEmail!);
  late final getwalletbalance = getWalletBalance(context, user!.userEmail!);
  @override
  void initState() {
    getWalletTransactions;
    getwalletbalance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          WalletSliverAppBar(
            user: user!,
          ),
          SliverToBoxAdapter(
            child: Transform(
              transform: Matrix4.translationValues(0, -18, 0),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Container(
                  padding: const EdgeInsets.only(top: 10),
                  height: 120,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey, // Shadow color
                        offset: Offset(0, 2), // Shadow position (x, y)
                        blurRadius: 5, // Spread of the shadow
                        spreadRadius: 0, // Extent of the shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(context,
                              screen: const WalletTopupPage(),
                              withNavBar: false);
                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.control_point_duplicate_sharp,
                              size: 35,
                              color: kPrimaryColor,
                            ),
                            Text(
                              "Top up",
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(context,
                              screen: const WalletTransferPage(),
                              withNavBar: false);
                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.published_with_changes_rounded,
                              size: 35,
                              color: kPrimaryColor,
                            ),
                            Text(
                              "Transfer",
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const WalletHistory(),
                          ));
                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.history,
                              size: 35,
                              color: kPrimaryColor,
                            ),
                            Text(
                              "History",
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.only(top: 5),
            sliver: SliverToBoxAdapter(
              child: CustomDivider(),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 11.0, left: 13, bottom: 5),
              child: Text(
                "Last Transactions",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          FutureBuilder(
            future: getWalletTransactions,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SliverList.builder(
                  itemCount:
                      snapshot.data.length > 5 ? 5 : snapshot.data.length,
                  itemBuilder: (context, index) {
                    WalletTransaction walletTransaction = snapshot.data[index];
                    return TransactionTile(
                        walletTransaction: walletTransaction);
                  },
                );
              }
              return const SliverToBoxAdapter(
                child: CustomLoading(),
              );
            },
          )
        ],
      ),
    );
  }
}
