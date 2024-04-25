import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:shopping_app/widgets/stars_rating.dart';

import '../models/review_model.dart';

class ReviewItem extends StatelessWidget {
  final Review review;
  const ReviewItem({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Color.fromARGB(255, 232, 232, 232),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(review.reviewer.toString()),
            const SizedBox(
              height: 2,
            ),
            StarsRating(
              rating: review.rating,
              size: 18,
            ),
            const SizedBox(
              height: 8,
            ),
            HtmlWidget(
              review.review.toString(),
              textStyle: TextStyle(fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
