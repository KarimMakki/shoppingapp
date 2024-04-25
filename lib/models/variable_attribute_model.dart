class VariableAttribute {
  String? name;
  String? attributeSlug;
  String? attributeName;

  VariableAttribute({this.name, this.attributeSlug, this.attributeName});

  factory VariableAttribute.fromJson(Map<String, dynamic> data) {
    final name = data['name'];
    if (name is! String) {
      throw FormatException(
          'Invalid JSON: required "name" field of type String in $data');
    }
    final attributeSlug = data['slug'];
    if (attributeSlug is! String) {
      throw FormatException(
          'Invalid JSON: required "attributeSlug" field of type String in $data');
    }
    final attributeName = data['option'];
    if (attributeName is! String) {
      throw FormatException(
          'Invalid JSON: required "attributeSlug" field of type String in $data');
    }
    return VariableAttribute(
        name: name, attributeSlug: attributeSlug, attributeName: attributeName);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "slug": attributeSlug,
      "attribute_name": attributeName
    };
  }
}
