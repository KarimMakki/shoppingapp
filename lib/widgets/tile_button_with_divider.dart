import 'package:flutter/material.dart';
import 'package:shopping_app/constants.dart';
import '../models/attribute_model.dart';
import '../models/product_model.dart';

class TileButtonwithDivider extends StatelessWidget {
  const TileButtonwithDivider(
      {super.key,
      this.productattributes,
      this.product,
      required this.content,
      required this.leadingIcon,
      required this.onTap});

  final List<Attribute>? productattributes;
  final Product? product;
  final String content;
  final IconData leadingIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  leadingIcon,
                  color: kPrimaryColor,
                ),
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.73,
                  child: Text(
                    content,
                    style: const TextStyle(fontSize: 15, height: 1.4),
                    softWrap: true,
                    maxLines: 3,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.chevron_right_outlined)
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        Divider(
          indent: 40,
          endIndent: 15,
          height: 3,
          thickness: 1,
          color: Colors.grey[300],
        ),
      ],
    );
  }
}
