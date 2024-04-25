import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shopping_app/models/user_model.dart';
import 'package:shopping_app/models/wallet_model.dart';
import 'package:shopping_app/services/wallet_methods.dart';
import 'package:shopping_app/widgets/loading_widget.dart';

class WalletSliverAppBar extends StatefulWidget {
  final UserModel user;
  const WalletSliverAppBar({super.key, required this.user});

  @override
  State<WalletSliverAppBar> createState() => _WalletSliverAppBarState();
}

class _WalletSliverAppBarState extends State<WalletSliverAppBar> {
  late final getwalletbalance =
      getWalletBalance(context, widget.user.userEmail!);
  @override
  void initState() {
    getwalletbalance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: Padding(
        padding: const EdgeInsets.only(top: 5.0, left: 10),
        child: Row(
          children: [
            BackButton(),
            const Text(
              "My Wallet",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.info))
          ],
        ),
      ),
      leadingWidth: MediaQuery.of(context).size.width,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: FutureBuilder(
            future: getwalletbalance,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Wallet wallet = snapshot.data;
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 40),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                "${wallet.currency}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                              Text(
                                "${wallet.balance}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }
              return const Padding(
                padding: EdgeInsets.only(right: 18.0, bottom: 30),
                child: SpinKitThreeBounce(
                  color: Colors.white,
                  size: 22,
                ),
              );
            },
          )),
    );
  }
}
