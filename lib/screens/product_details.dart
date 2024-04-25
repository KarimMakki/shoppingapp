import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/models/attribute_model.dart';
import 'package:shopping_app/models/image_model.dart';
import 'package:shopping_app/providers/cart_provider.dart';
import 'package:shopping_app/providers/wishlist_provider.dart';
import 'package:shopping_app/services/getReviews.dart';
import 'package:shopping_app/widgets/appbars/productdetails_appbar.dart';
import 'package:shopping_app/widgets/discount_percentage.dart';
import 'package:shopping_app/widgets/loading_widget.dart';
import 'package:shopping_app/widgets/related_products.dart';
import 'package:shopping_app/widgets/review_item.dart';
import 'package:shopping_app/widgets/share_button.dart';
import 'package:shopping_app/widgets/stars_rating.dart';
import 'package:shopping_app/widgets/whatsapp_share_button.dart';
import '../models/product_model.dart';
import '../widgets/bottom_product_page_buttons.dart';
import '../widgets/custom_divider.dart';
import '../widgets/expansion_widget.dart';
import '../widgets/sale_tag.dart';
import '../widgets/tile_button_with_divider.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  final List<Images> images;

  const ProductDetails(
      {super.key, required this.images, required this.product});

  @override
  Widget build(BuildContext context) {
    var user = userbox.get(1);
    return Scaffold(
      bottomSheet: BottomProductButtons(
          productattributes: product.attributes!, product: product),
      appBar: productDetailsAppBar(context),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageSlideshow(
                    height: 430,
                    children: images
                        .map((image) => Image.network(image.src))
                        .toList()),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    SaleTag(product: product),
                    const SizedBox(
                      width: 3,
                    ),
                    Expanded(
                      child: Text(
                        product.name.toString(),
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 11,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "${product.price}" "SDG",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: (product.on_sale ?? false)
                                ? Colors.red[600]
                                : kPrimaryColor),
                      ),
                    ),
                    if (product.on_sale == true)
                      Text("${product.regular_price}" "SDG",
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey[600],
                          )),
                    const SizedBox(
                      width: 5,
                    ),
                    DiscountPercentageBox(
                        regularPrice: product.regular_price,
                        salePrice: product.sale_price,
                        product: product),
                    const SizedBox(
                      height: 18,
                    ),
                    const CustomDivider(),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0.0, horizontal: 4),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: product.ratingCount! > 0
                            ? Colors.amber
                            : Colors.grey[300],
                      ),
                      Text(product.averageRating.toString()),
                      const Spacer(),
                      Consumer<WishlistProvider>(
                        builder: (context, wishlistProvider, child) {
                          return IconButton(
                              onPressed: () {
                                if (!wishlistProvider.products.any(
                                    (productinList) =>
                                        productinList.id == product.id)) {
                                  wishlistProvider.addtoWishlist(
                                      user!.userEmail!, product);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          backgroundColor:
                                              Color.fromARGB(129, 0, 0, 0),
                                          content: Text(
                                            "Added to wishlist successfully!",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )));
                                } else {
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
                                }
                              },
                              icon: Icon(
                                !wishlistProvider.products.any((productad) =>
                                        productad.id == product.id)
                                    ? Icons.favorite_outline
                                    : Icons.favorite,
                                color: !wishlistProvider.products.any(
                                        (productad) =>
                                            productad.id == product.id)
                                    ? kPrimaryColor
                                    : Colors.red,
                              ));
                        },
                      ),
                      ShareIconButton(sharedText: product.name!),
                      WhatsappIconShareButton(sharedText: product.name!)
                    ],
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                TileButtonwithDivider(
                  productattributes: product.attributes,
                  product: product,
                  leadingIcon: Icons.delivery_dining_outlined,
                  content: "Free Delivery on orders above 1000SDG",
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                )),
                            const Text("Delivery Policy")
                          ],
                        );
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 6,
                ),
                TileButtonwithDivider(
                  productattributes: product.attributes,
                  product: product,
                  content: "Payment Methods Information",
                  leadingIcon: Icons.payment,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                )),
                            const Text("Payment methods")
                          ],
                        );
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 6,
                ),
                TileButtonwithDivider(
                  productattributes: product.attributes,
                  product: product,
                  content: "Returns policy",
                  leadingIcon: Icons.settings_backup_restore_sharp,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                )),
                            const Text("Returns Policy")
                          ],
                        );
                      },
                    );
                  },
                ),
                const CustomDivider(),
                const SizedBox(
                  height: 10,
                ),
                TileButtonwithDivider(
                  productattributes: product.attributes,
                  product: product,
                  content: "Platform Coupons",
                  leadingIcon: Icons.all_inbox,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                )),
                            const Text("Coupons")
                          ],
                        );
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 13,
                ),
                ExpansionWidget(
                  collapsedBackgroundColor: Colors.grey[300],
                  initiallyExpanded: false,
                  title: const Text(
                    "Description",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  showDivider: true,
                  childrenPadding: const EdgeInsets.all(6),
                  children: [HtmlWidget(product.description.toString())],
                ),
                const SizedBox(
                  height: 20,
                ),
                const CustomDivider(),
                const SizedBox(
                  height: 15,
                ),
                FutureBuilder(
                  future: getReviews(product.id, context),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                    "Product ratings (${snapshot.data.length})",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                                const Spacer(),
                                const Row(
                                  children: [
                                    Text("View all"),
                                    Icon(Icons.chevron_right)
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: Row(
                                children: [
                                  Text(
                                    product.averageRating.toString(),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  StarsRating(
                                    rating: double.parse(
                                        product.averageRating.toString()),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data.length <= 3
                                  ? snapshot.data.length
                                  : 3,
                              itemBuilder: (context, index) {
                                final review = snapshot.data[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ReviewItem(review: review),
                                );
                              },
                            )
                          ],
                        ),
                      );
                    } else {
                      return const CustomLoading();
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const CustomDivider(),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("You may also like",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
              ],
            ),
          ),
          RelatedProducts(product: product)
        ],
      ),
    );
  }
}
