class ShippingMethod {
  String? id;
  String? title;
  String? description;
  double? cost;
  String? methodId;
  String? methodTitle;
  int? shippingTax;

  ShippingMethod.fromJson(Map<String, dynamic> data) {
    id = data['id'].toString();
    title = data['title'];
    methodId = data['method_id'];
    methodTitle = data['method_title'];
    description = data['method_description'];
    cost = data['settings']['cost'] != null &&
            data['settings']['cost']['value'] != null
        ? double.parse(data['settings']['cost']['value'])
        : 0;
    shippingTax = data["shipping_tax"];
  }
}
