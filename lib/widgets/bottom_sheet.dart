import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/screens/checkout.dart';
import 'package:shopping_app/widgets/product_attribute_details.dart';
import 'package:shopping_app/widgets/quantity_selection_button.dart';
import '../constants.dart';
import '../models/attribute_model.dart';
import '../models/cart_item_model.dart';
import '../models/product_model.dart';
import '../models/product_variation_model.dart';
import '../providers/cart_provider.dart';

class ProductDetailsBottomSheet extends StatefulWidget {
  final List<Attribute> productattributes;
  final Product product;
  final bool isBuyNow;
  const ProductDetailsBottomSheet(
      {super.key,
      required this.product,
      required this.productattributes,
      required this.isBuyNow});

  @override
  State<ProductDetailsBottomSheet> createState() =>
      _ProductDetailsBottomSheetState();
}

class _ProductDetailsBottomSheetState extends State<ProductDetailsBottomSheet> {
  List<ProductVariation> productvariationsList = [];
  // a map that have the key as the attributes names joined together in a string
  // and the values is the variations of the product
  late Map<String, ProductVariation> variationsMap = productvariationsList
      .fold<Map<String, ProductVariation>>({}, (map, variation) {
    String key = variation.attributeList!
        .map((variableAttribute) => variableAttribute.attributeName)
        .join("-");
    map[key] = variation;
    return map;
  });

  String? selectedColor;
  String? selectedSize;
  ProductVariation? variantDetail;
  int quantity = 1;
  int updatedQuantity = 1;

  void updateVariationSelection(String valueType, String value) {
    if (valueType.toLowerCase() == "color") {
      selectedColor = value;
    } else {
      selectedSize = value;
    }
    if (widget.productattributes.length >= 2 &&
        selectedSize != null &&
        selectedColor != null) {
      String mapKey = "$selectedColor-$selectedSize";
      ProductVariation selectedVariantDetail = variationsMap[mapKey]!;
      variantDetail = selectedVariantDetail;
      setState(() {});
    }

    if (widget.productattributes.length <= 1) {
      String mapKey = selectedColor != null
          ? selectedColor.toString()
          : selectedSize.toString();
      ProductVariation selectedVariantDetail =
          variationsMap[mapKey.toLowerCase()]!;
      variantDetail = selectedVariantDetail;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    for (var variations in widget.product.variationProducts!) {
      productvariationsList.add(variations);
    }
    List<dynamic> imagelinks = widget.product.images!
        .map(
          (image) => image.src.toString(),
        )
        .toList();
    String productVariant = variantDetail?.attributeList != null
        ? variantDetail!.attributeList!
            .map(
              (e) => e.attributeName,
            )
            .join("-")
        : "";

    late CartItem cartItem = CartItem(
        productName: widget.product.name,
        productPrice: widget.product.price,
        quantity: quantity,
        productImage: imagelinks[0],
        variation: variantDetail,
        product: widget.product,
        id: variantDetail?.id ?? widget.product.id.toString(),
        productVariant: productVariant);

    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: SizedBox(
                      height: 150,
                      width: 150,
                      child: FadeInImage.assetNetwork(
                        image: variantDetail?.featuredImage ?? imagelinks[0],
                        placeholder: "assets/images/placeholder.png",
                        fadeInDuration: const Duration(milliseconds: 10),
                      )),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          heightFactor: 1.5,
                          child: IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 18,
                              ))),
                      Text(
                        "${widget.product.name}",
                        maxLines: 2,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          if (selectedColor != null)
                            Text(
                              "Color: $selectedColor",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          if (selectedSize != null)
                            Text(
                              "- Size: $selectedSize",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${widget.product.price}" "SDG",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: kPrimaryColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            for (var attribute in widget.productattributes)
              if (widget.product.isVariableProduct)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: ProductAttributeDetail(
                    attributeName: attribute.name.toString(),
                    options: attribute.options!,
                    updateVariationSelection: updateVariationSelection,
                  ),
                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Quantity",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                const Spacer(),
                QuantityButton(
                  onChanged: (value) {
                    quantity = value;
                    updatedQuantity = value;
                  },
                ),
                const Divider(),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                variantDetail?.stockQuantity != null
                    ? "Stock Quantity: ${variantDetail!.stockQuantity}"
                    : "",
                style: const TextStyle(color: Colors.red),
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.042,
                child: MaterialButton(
                  onPressed: () {
                    if (widget.isBuyNow == false) {
                      if (!cartProvider.cartItemsFromDb.contains(cartItem)) {
                        cartProvider.saveCartItemToDb(cartItem);
                      } else {
                        cartProvider.updateQuantityinCart(
                            updatedQuantity, cartItem);
                      }

                      showDialog(
                        context: context,
                        builder: (dialogContext) {
                          Future.delayed(const Duration(seconds: 1), () {
                            Navigator.of(context).pop();
                          });

                          return const Center(
                            child: AlertDialog(
                              backgroundColor: Color.fromARGB(154, 0, 0, 0),
                              title: Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                size: 35,
                              ),
                              content: Text(
                                "Added to cart successfully!",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckoutPage(
                              buyNowCartItem: cartItem,
                            ),
                          ));
                    }
                  },
                  color:
                      widget.isBuyNow == false ? kPrimaryColor : Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.add_shopping_cart,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        widget.isBuyNow == false ? "Add to Cart" : "Buy Now",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.028,
            )
          ],
        );
      },
    );
  }
}
