import 'package:flutter/material.dart';
import 'package:shopping_app/screens/category_products.dart';
import '../models/category_model.dart';

class CategoryCard extends StatelessWidget {
  final Category childCategory;
  const CategoryCard({super.key, required this.childCategory});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CategoryProductsPage(
          category: childCategory,
        ),
      )),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Expanded(
              child: childCategory.image.runtimeType == bool ||
                      childCategory.image == "false"
                  ? Image.asset("assets/images/placeholder.png")
                  : Image.network(childCategory.image!),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(childCategory.name!),
          ],
        ),
      ),
    );
  }
}
