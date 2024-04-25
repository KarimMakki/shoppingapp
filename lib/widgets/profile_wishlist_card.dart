import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/screens/product_details.dart';
import '../constants.dart';
import '../models/product_model.dart';
import '../providers/wishlist_provider.dart';

class ProfileWishlistCard extends StatelessWidget {
  const ProfileWishlistCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => PersistentNavBarNavigator.pushNewScreen(context,
          screen: ProductDetails(images: product.images!, product: product),
          withNavBar: false),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          margin: const EdgeInsets.all(0),
          color: Colors.white,
          elevation: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                      height: 120,
                      width: 120,
                      child: product.mainImagesrc != null
                          ? FadeInImage.assetNetwork(
                              image: product.mainImagesrc!,
                              placeholder: "assets/images/placeholder.png",
                              fadeInDuration: const Duration(milliseconds: 10),
                            )
                          : Image.asset("assets/images/placeholder.png")),
                  Positioned(
                    bottom:
                        20, // Adjust the values to position the icon as desired
                    right: 16,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(195, 255, 255,
                            255), // Background color of the rounded container
                        shape: BoxShape
                            .circle, // Use BoxShape.rectangle for rectangular background
                      ),
                      child: Consumer<WishlistProvider>(
                        builder: (context, wishlistProvider, child) {
                          return IconButton(
                            onPressed: () {
                              wishlistProvider.removefromWishlist(product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor:
                                          Color.fromARGB(129, 0, 0, 0),
                                      content: Text(
                                        "Removed from wishlist successfully!",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )));
                            },
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 22,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, top: 5),
                child: Row(
                  children: [
                    Text(
                      product.price!,
                      style: const TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                      textAlign: TextAlign.right,
                    ),
                    const Text(
                      "SDG",
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
