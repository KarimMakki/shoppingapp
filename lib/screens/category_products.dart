import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shopping_app/screens/product_details.dart';
import 'package:shopping_app/services/getProducts.dart';
import 'package:shopping_app/widgets/keepPageAlive.dart';
import '../models/category_model.dart';
import '../widgets/appbars/categoryproducts_appbar.dart';
import '../widgets/loading_widget.dart';
import '../widgets/productcard.dart';

class CategoryProductsPage extends StatefulWidget {
  final Category category;
  const CategoryProductsPage({super.key, required this.category});

  @override
  State<CategoryProductsPage> createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  final controller = ScrollController();
  final PagingController<int, dynamic> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      getProducts(widget.category.id.toString(), pageKey, _pagingController, 10,
          context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: categoryproductsAppBar(context),
      body: PagedGridView<int, dynamic>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          firstPageProgressIndicatorBuilder: (context) => const Center(
            child: CustomLoading(),
          ),
          newPageProgressIndicatorBuilder: (context) =>
              const Center(child: CustomLoading()),
          itemBuilder: (context, product, index) {
            List<dynamic> imagelinks =
                product!.images!.map((data) => data.src.toString()).toList();
            return ColoredBox(
              color: const Color.fromARGB(255, 237, 237, 237),
              child: GestureDetector(
                onTap: () => PersistentNavBarNavigator.pushNewScreen(context,
                    screen: ProductDetails(
                      product: product,
                      images: product.images,
                    ),
                    withNavBar: false),
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
      ),
    );
  }
}
