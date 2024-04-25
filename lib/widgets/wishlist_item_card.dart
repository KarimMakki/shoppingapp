import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/wishlist_provider.dart';
import 'package:shopping_app/screens/product_details.dart';

import '../constants.dart';
import '../models/product_model.dart';

class WishlistItemCard extends StatelessWidget {
  final Product product;
  const WishlistItemCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // List<dynamic> imagelinks =
    //     product.images!.map((data) => data.src.toString()).toList();
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            ProductDetails(images: product.images!, product: product),
      )),
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
                      height: 230,
                      width: 230,
                      child: FadeInImage.assetNetwork(
                        image: product.mainImagesrc!,
                        placeholder: "assets/images/placeholder.png",
                        fadeInDuration: const Duration(milliseconds: 10),
                      )),
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
                            icon: Icon(
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
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  product.name!,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Row(
                  children: [
                    Text(
                      product.price!,
                      style: const TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                      textAlign: TextAlign.right,
                    ),
                    const Text(
                      "SDG",
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
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
