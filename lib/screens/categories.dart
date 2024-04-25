import 'package:flutter/material.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/models/category_model.dart';
import 'package:shopping_app/services/getCategories.dart';
import 'package:shopping_app/widgets/appbars/categoriespage_appbar.dart';
import 'package:shopping_app/widgets/categorycard.dart';
import 'package:shopping_app/widgets/keepPageAlive.dart';
import 'package:shopping_app/widgets/loading_widget.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage>
    with AutomaticKeepAliveClientMixin {
  late Future _getParentCategories = getParentCategories(context);
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: categoriesAppBar(context),
      body: FutureBuilder(
        future: _getParentCategories,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Row(
              children: [
                SizedBox(
                  width: 150,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        Category category = snapshot.data[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = index;
                              _pageController.jumpToPage(index);
                            });
                          },
                          child: Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(
                                  milliseconds: 200,
                                ),
                                height: _selectedIndex == index ? 50 : 0,
                                width: 4,
                                color: kPrimaryColor,
                              ),
                              Expanded(
                                  child: AnimatedContainer(
                                duration: const Duration(milliseconds: 100),
                                alignment: Alignment.center,
                                height: 50,
                                color: _selectedIndex == index
                                    ? kPrimaryColor.withOpacity(0.2)
                                    : Colors.white,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(category.name!
                                      .toUpperCase()
                                      .replaceAll("&AMP;", "&")),
                                ),
                              ))
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 7,
                        );
                      },
                      itemCount: snapshot.data.length),
                ),
                Expanded(
                    child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    for (var categories in snapshot.data)
                      KeepPageAlive(
                        child: FutureBuilder(
                          future: getChildCategories(categories.id, context),
                          builder: (context, childsnapshot) {
                            if (childsnapshot.hasData) {
                              return GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemCount: childsnapshot.data.length,
                                itemBuilder: (context, index) {
                                  Category childCategory =
                                      childsnapshot.data[index];
                                  return CategoryCard(
                                    childCategory: childCategory,
                                  );
                                },
                              );
                            }
                            return const CustomLoading();
                          },
                        ),
                      )
                    // Text(categories["id"].toString()),
                  ],
                ))
              ],
            );
          } else {
            return const Center(
              child: CustomLoading(),
            );
          }
        },
      ),
    );
  }
}
