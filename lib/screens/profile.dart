import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/providers/wishlist_provider.dart';
import 'package:shopping_app/screens/all_addresses.dart';
import 'package:shopping_app/screens/authentication/login.dart';
import 'package:shopping_app/screens/coupons.dart';
import 'package:shopping_app/screens/orders.dart';
import 'package:shopping_app/screens/wallet.dart';
import 'package:shopping_app/screens/wishlist.dart';
import 'package:shopping_app/widgets/custom_divider.dart';
import 'package:shopping_app/widgets/tile_button_with_divider.dart';
import '../widgets/appbars/profilepage_sliver_appbar.dart';
import '../widgets/profile_wishlist_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var user = userbox.get(1);
    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          const ProfileSliverAppBar(),
          const SliverPadding(padding: EdgeInsets.symmetric(vertical: 8)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            PersistentNavBarNavigator.pushNewScreen(context,
                                screen: const CouponsPage(), withNavBar: false);
                          },
                          icon: Image.asset(
                            "assets/images/iconscoupon.png",
                            scale: 3,
                          )),
                      const Text("Coupons")
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            PersistentNavBarNavigator.pushNewScreen(context,
                                screen: const WalletPage(), withNavBar: false);
                          },
                          icon: const Icon(
                            Icons.account_balance_wallet_outlined,
                            size: 27,
                          )),
                      const Text(
                        "Wallet",
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            "assets/images/points_icon.png",
                            scale: 1.7,
                          )),
                      const Text("Points")
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            "assets/images/discount_icon.png",
                            scale: 2.5,
                          )),
                      const Text("Promotions")
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          const SliverToBoxAdapter(
            child: CustomDivider(),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  const Icon(Icons.checklist),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    "My Orders",
                    style: TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      if (user != null) {
                        PersistentNavBarNavigator.pushNewScreen(context,
                            screen: const OrdersPage(), withNavBar: false);
                      } else {
                        PersistentNavBarNavigator.pushNewScreen(context,
                            screen: const LoginPage(), withNavBar: false);
                      }
                    },
                    child: const Row(
                      children: [
                        Text(
                          "View all Orders",
                          style: TextStyle(fontSize: 13),
                        ),
                        Icon(
                          Icons.chevron_right,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: CustomDivider(),
          ),
          Consumer<WishlistProvider>(
            builder: (context, wishlistProvider, child) {
              if (wishlistProvider.products.isNotEmpty) {
                return SliverToBoxAdapter(
                    child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15.0, left: 7, bottom: 5),
                      child: Row(
                        children: [
                          const Icon(Icons.favorite_outline),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            "My Wishlist",
                            style: TextStyle(fontSize: 16),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () =>
                                PersistentNavBarNavigator.pushNewScreen(context,
                                    screen: const WishListPage(),
                                    withNavBar: false),
                            child: const Row(
                              children: [
                                Text(
                                  "View all Wishlist",
                                  style: TextStyle(fontSize: 13),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  size: 18,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.17,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: wishlistProvider.products.length,
                          itemBuilder: (context, index) {
                            final product = wishlistProvider.products[index];
                            return ProfileWishlistCard(product: product);
                          },
                        )),
                  ],
                ));
              }
              return const SliverPadding(
                padding: EdgeInsets.all(0),
              );
            },
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TileButtonwithDivider(
                  content: "My Addresses",
                  leadingIcon: Icons.pin_drop_outlined,
                  onTap: () {
                    if (user != null) {
                      PersistentNavBarNavigator.pushNewScreen(context,
                          screen: const AllAddressesPage(), withNavBar: false);
                    } else {
                      PersistentNavBarNavigator.pushNewScreen(context,
                          screen: const LoginPage(), withNavBar: false);
                    }
                  }),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TileButtonwithDivider(
                  content: "Coupons",
                  leadingIcon: Icons.tag,
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(context,
                        screen: const CouponsPage(), withNavBar: false);
                  }),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TileButtonwithDivider(
                  content: "My Wallet",
                  leadingIcon: Icons.account_balance_wallet_outlined,
                  onTap: () {
                    if (user != null) {
                      PersistentNavBarNavigator.pushNewScreen(context,
                          screen: const WalletPage(), withNavBar: false);
                    } else {
                      PersistentNavBarNavigator.pushNewScreen(context,
                          screen: const LoginPage(), withNavBar: false);
                    }
                  }),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TileButtonwithDivider(
                  content: "Account Settings",
                  leadingIcon: Icons.person,
                  onTap: () {}),
            ),
          ),
        ],
      ),
    );
  }
}
