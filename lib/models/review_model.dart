class Review {
  int? id;
  // int? productId;
  String? reviewer;
  String? reviewerEmail;
  String? review;
  double? rating;
  bool verified;
  Review(
      {this.id,
      // this.productId,
      this.reviewer,
      this.reviewerEmail,
      this.review,
      this.rating,
      required this.verified});

  factory Review.fromJson(Map<String, dynamic> data) {
    final id = data['id'];
    if (id is! int) {
      throw FormatException(
          'Invalid JSON: required "id" field of type int in $data');
    }
    // final productId = data['product_id'];
    // if (productId is! int) {
    //   throw FormatException(
    //       'Invalid JSON: required "productId" field of type int in $data');
    // }
    final reviewer = data['name'];
    if (reviewer is! String) {
      throw FormatException(
          'Invalid JSON: required "reviewer" field of type String in $data');
    }
    final reviewerEmail = data['email'];
    if (reviewerEmail is! String) {
      throw FormatException(
          'Invalid JSON: required "reviewerEmail" field of type String in $data');
    }
    final review = data['review'];
    if (review is! String) {
      throw FormatException(
          'Invalid JSON: required "review" field of type String in $data');
    }
    final rating = double.parse(data['rating'].toString());
    final verified = data['verified'] ?? false;

    return Review(
        id: id,
        // productId: productId,
        reviewer: reviewer,
        reviewerEmail: reviewerEmail,
        review: review,
        rating: rating,
        verified: verified);
  }
}
