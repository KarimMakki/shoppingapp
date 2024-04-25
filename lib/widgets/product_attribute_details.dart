import 'package:flutter/material.dart';

class ProductAttributeDetail extends StatefulWidget {
  final String attributeName;
  final List options;
  final Function(String, String) updateVariationSelection;
  const ProductAttributeDetail(
      {super.key,
      required this.attributeName,
      required this.options,
      required this.updateVariationSelection});

  @override
  State<ProductAttributeDetail> createState() => _ProductAttributeDetailState();
}

class _ProductAttributeDetailState extends State<ProductAttributeDetail> {
  String selectedOption = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(widget.attributeName,
              style:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: widget.options
                .map((option) => InkWell(
                      onTap: () {
                        setState(() {
                          selectedOption = option;
                        });
                        widget.updateVariationSelection(
                            widget.attributeName, selectedOption);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: Colors.grey[400]!),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(17)),
                            color: Colors.transparent,
                          ),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 6),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 17, vertical: 4),
                          child: Text(
                            option,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: selectedOption == option
                                    ? Colors.deepOrange
                                    : Colors.black),
                          )),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
