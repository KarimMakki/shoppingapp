import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shopping_app/screens/product_details.dart';
import 'package:shopping_app/services/getProducts.dart';
import 'package:shopping_app/services/getReviews.dart';
import 'package:shopping_app/widgets/circlecategoryimage.dart';
import 'package:shopping_app/widgets/multipleitemsbanner.dart';
import 'package:shopping_app/widgets/productcard.dart';
import '../../models/category_model.dart';
import '../../widgets/bannerslider.dart';
import '../../widgets/loading_widget.dart';

class All extends StatefulWidget {
  const All({super.key});

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> with AutomaticKeepAliveClientMixin<All> {
  final controller = ScrollController();
  final PagingController<int, dynamic> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      getProducts("1285", pageKey, _pagingController, 10, context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
        child: CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
            child: MultipleItemsBanner(
          aspectRatio: 6.0,
          imgList: [
            'assets/images/small_banner.webp',
            'assets/images/small_banner.webp',
            'assets/images/small_banner.webp',
            'assets/images/small_banner.webp',
            'assets/images/small_banner.webp',
            'assets/images/small_banner.webp'
          ],
        )),
        SliverToBoxAdapter(
          child: Image.asset("assets/images/banner.jpeg"),
        ),
        SliverToBoxAdapter(
            child: BannerSlider(
          indicatorBottomPadding: 6,
          imglist: [
            Image.asset("assets/images/image1.webp"),
            Image.asset("assets/images/image2.webp"),
            Image.asset("assets/images/image3.webp")
          ],
        )),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 10,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleCategory(
                  text: "Women",
                  backgroundColor: Colors.grey,
                  image: "assets/images/lenzo-coloured-simple.png",
                  onTap: () {},
                ),
                CircleCategory(
                  text: "Hoodies & SweatShirts",
                  backgroundColor: Colors.grey,
                  image: "assets/images/lenzo-coloured-simple.png",
                  onTap: () {},
                ),
                CircleCategory(
                  text: "Women",
                  backgroundColor: Colors.grey,
                  image: "assets/images/lenzo-coloured-simple.png",
                  onTap: () {},
                ),
                CircleCategory(
                  text: "Hoodies & SweatShirts",
                  backgroundColor: Colors.grey,
                  image: "assets/images/lenzo-coloured-simple.png",
                  onTap: () {},
                ),
                CircleCategory(
                  text: "Hoodies & SweatShirts",
                  backgroundColor: Colors.grey,
                  image: "assets/images/lenzo-coloured-simple.png",
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleCategory(
                  text: "Women",
                  backgroundColor: Colors.grey,
                  image: "assets/images/lenzo-coloured-simple.png",
                  onTap: () {},
                ),
                CircleCategory(
                  text: "Hoodies & SweatShirts",
                  backgroundColor: Colors.grey,
                  image: "assets/images/lenzo-coloured-simple.png",
                  onTap: () {},
                ),
                CircleCategory(
                  text: "Women",
                  backgroundColor: Colors.grey,
                  image: "assets/images/lenzo-coloured-simple.png",
                  onTap: () {},
                ),
                CircleCategory(
                  text: "Hoodies & SweatShirts",
                  backgroundColor: Colors.grey,
                  image: "assets/images/lenzo-coloured-simple.png",
                  onTap: () {},
                ),
                CircleCategory(
                  text: "Hoodies & SweatShirts",
                  backgroundColor: Colors.grey,
                  image: "assets/images/lenzo-coloured-simple.png",
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleCategory(
                  text: "Women",
                  backgroundColor: Colors.grey,
                  image: "assets/images/lenzo-coloured-simple.png",
                  onTap: () {},
                ),
                CircleCategory(
                  text: "Hoodies & SweatShirts",
                  backgroundColor: Colors.grey,
                  image: "assets/images/lenzo-coloured-simple.png",
                  onTap: () {},
                ),
                CircleCategory(
                  text: "Women",
                  backgroundColor: Colors.grey,
                  image: "assets/images/lenzo-coloured-simple.png",
                  onTap: () {},
                ),
                CircleCategory(
                  text: "Hoodies & SweatShirts",
                  backgroundColor: Colors.grey,
                  image: "assets/images/lenzo-coloured-simple.png",
                  onTap: () {},
                ),
                CircleCategory(
                  text: "Hoodies & SweatShirts",
                  backgroundColor: Colors.grey,
                  image: "assets/images/lenzo-coloured-simple.png",
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 12,
          ),
        ),
        SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Image.asset("assets/images/square-banner-1.webp")),
              Expanded(
                  child: Image.asset("assets/images/square-banner-2.webp")),
              Expanded(child: Image.asset("assets/images/square-banner-3.webp"))
            ],
          ),
        ),
        const SliverToBoxAdapter(
          child: MultipleItemsBanner(aspectRatio: 2.6, imgList: [
            "assets/images/Artboard 1 copy 2.png",
            "assets/images/Artboard 1 copy 3.png",
            "assets/images/Artboard 1 copy 4.png",
            "assets/images/Artboard 1 copy 5.png",
            "assets/images/Artboard 1 copy 6.png",
            "assets/images/Artboard 1 copy 7.png"
          ]),
        ),
        SliverToBoxAdapter(
          child: BannerSlider(indicatorBottomPadding: 20, imglist: [
            Image.asset("assets/images/testbanner-1.png"),
            Image.asset("assets/images/testbanner-2.png"),
            Image.asset("assets/images/testbanner-1.png"),
          ]),
        ),
        PagedSliverGrid<int, dynamic>(
            showNewPageProgressIndicatorAsGridChild: false,
            addAutomaticKeepAlives: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.62),
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate(
              newPageProgressIndicatorBuilder: (context) =>
                  const Center(child: CustomLoading()),
              itemBuilder: (_, product, index) {
                List<dynamic> imagelinks =
                    product.images.map((data) => data.src.toString()).toList();
                return ColoredBox(
                  color: const Color.fromARGB(255, 237, 237, 237),
                  child: GestureDetector(
                    onTap: () =>
                        PersistentNavBarNavigator.pushNewScreen(context,
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
            )),
      ],
    ));
  }
}
