import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shopping_app/services/getProducts.dart';
import 'package:shopping_app/widgets/loading_widget.dart';
import 'package:shopping_app/widgets/productcard.dart';

import '../models/product_model.dart';
import '../screens/product_details.dart';

class RelatedProducts extends StatefulWidget {
  final Product product;
  const RelatedProducts({super.key, required this.product});

  @override
  State<RelatedProducts> createState() => _RelatedProductsState();
}

class _RelatedProductsState extends State<RelatedProducts> {
  final PagingController<int, dynamic> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      getProducts(widget.product.categoryID.toString(), pageKey,
          _pagingController, 6, context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PagedSliverGrid<int, dynamic>(
      pagingController: _pagingController,
      showNewPageProgressIndicatorAsGridChild: false,
      builderDelegate: PagedChildBuilderDelegate(
        newPageProgressIndicatorBuilder: (context) => const Center(
          child: CustomLoading(),
        ),
        itemBuilder: (_, product, index) {
          List<dynamic> imagelinks =
              product.images.map((data) => data.src.toString()).toList();
          return ColoredBox(
            color: const Color.fromARGB(255, 231, 231, 231),
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetails(
                      product: product,
                      images: product.images,
                    ),
                  )),
              child: ProductCard(
                  name: product.name,
                  price: product.price,
                  image: imagelinks[0]),
            ),
          );
        },
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.62),
      addAutomaticKeepAlives: true,
    );
  }
}
