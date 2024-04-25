class PaymentMethod {
  String? id;
  String? title;
  String? description;
  bool? enabled;

  PaymentMethod({this.id, this.title, this.description, this.enabled});

  factory PaymentMethod.fromJson(Map<String, dynamic> data) {
    return PaymentMethod(
        id: data["id"],
        title: data["title"],
        description: data["description"],
        enabled: data["enabled"]);
  }

  Map<String, dynamic> toFireStoreJson() => {
        "id": id,
        "title": title,
        "description": description,
        "enabled": enabled
      };
}
