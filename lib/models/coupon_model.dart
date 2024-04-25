class Coupon {
  String? id;
  String? code;
  double? amount;
  String? description;
  String? discountType;
  DateTime? dateExpires;
  double? minimumAmount;
  double? maximumAmount;
  int? usageCount;
  bool? individualUse;
  int? usageLimit;
  int? usageLimitPerUser;
  bool? freeShipping;
  bool? excludeSaleItems;
  List<String>? usedBy;

  Coupon(
      {required this.id,
      required this.code,
      required this.amount,
      this.description,
      this.discountType,
      this.dateExpires,
      this.minimumAmount,
      this.maximumAmount,
      this.usageCount,
      this.individualUse,
      this.usageLimit,
      this.usageLimitPerUser,
      this.freeShipping,
      this.excludeSaleItems,
      this.usedBy});

  /// Check whether the coupon is expired.
  /// If dateExpires is null, the coupon is never expired (return false).
  bool get isExpired => !(dateExpires?.isAfter(DateTime.now()) ?? true);

// To Check the coupon discount type whether it's a fixed cart, percent or fixed product discount
/////////////////
  bool get isFixedCartDiscount => discountType == 'fixed_cart';

  bool get isFixedProductDiscount => discountType == 'fixed_product';

  bool get isPercentageDiscount => discountType == 'percent';
////////////////////

  factory Coupon.fromJson(Map<String, dynamic> data) {
    List<String> usedBy = [];
    if (data['used_by'] != null) {
      data['used_by'].forEach((e) {
        usedBy.add(e.toString());
      });
    }
    return Coupon(
        id: data["id"]?.toString(),
        code: data["code"],
        amount: double.parse(data["amount"].toString()),
        description: data["description"],
        discountType: data["discount_type"],
        dateExpires: data["date_expires"] != null
            ? DateTime.parse(data["date_expires"])
            : null,
        minimumAmount: data["minimum_amount"] != null
            ? double.parse(data["minimum_amount"].toString())
            : 0.0,
        maximumAmount: data["maximum_amount"] != null
            ? double.parse(data["maximum_amount"].toString())
            : 0.0,
        usageCount: data["usage_count"],
        individualUse: data["individual_use"],
        usageLimit: data["usage_limit"],
        usageLimitPerUser: data["usage_limit_per_user"],
        freeShipping: data["free_shipping"] ?? false,
        excludeSaleItems: data['exclude_sale_items'] ?? false,
        usedBy: usedBy);
  }

  factory Coupon.fromFirestoreJson(Map<String, dynamic> data) {
    List<String> usedBy = [];
    if (data['used_by'] != null) {
      data['used_by'].forEach((e) {
        usedBy.add(e.toString());
      });
    }
    return Coupon(
        id: data["id"]?.toString(),
        code: data["code"],
        amount: double.parse(data["amount"].toString()),
        description: data["description"],
        discountType: data["discount_type"],
        dateExpires: data["date_expires"] != null
            ? DateTime.parse(data["date_expires"].toString())
            : null,
        minimumAmount: data["minimum_amount"] != null
            ? double.parse(data["minimum_amount"].toString())
            : 0.0,
        maximumAmount: data["maximum_amount"] != null
            ? double.parse(data["maximum_amount"].toString())
            : 0.0,
        usageCount: data["usage_count"],
        individualUse: data["individual_use"],
        usageLimit: data["usage_limit"],
        usageLimitPerUser: data["usage_limit_per_user"],
        freeShipping: data["free_shipping"] ?? false,
        excludeSaleItems: data['exclude_sale_items'] ?? false,
        usedBy: usedBy);
  }

  Map<String, dynamic> toFireStoreJson() => {
        "id": id,
        "code": code,
        "amount": amount,
        "description": description,
        "discount_type": discountType,
        "date_expires": dateExpires.toString(),
        "minimum_amount": minimumAmount,
        "maximum_amount": maximumAmount,
        "usage_count": usageCount,
        "individual_use": individualUse,
        "usage_limit": usageLimit,
        "usage_limit_per_user": usageLimitPerUser,
        "free_shipping": freeShipping,
        "exclude_sale_items": excludeSaleItems,
        "usedBy": usedBy
      };

  factory Coupon.fromOrderJson(Map<String, dynamic> data) {
    return Coupon(
        id: data["id"].toString(),
        code: data["code"],
        amount: double.parse(data["discount"]));
  }
}
