class ShippingZone {
  int? id;
  String? name;
  int? order;

  ShippingZone.fromJson(Map<String, dynamic> data) {
    id = data["id"];
    name = data["name"];
    order = data["order"];
  }
}
