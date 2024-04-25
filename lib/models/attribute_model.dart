class Attribute {
  int? id;
  String? name;
  int? position;
  bool? isVisible;
  bool? isVariation;
  List<dynamic>? options;

  Attribute(
      {this.id,
      this.name,
      this.position,
      this.isVisible,
      this.isVariation,
      this.options});

  factory Attribute.fromJson(Map<String, dynamic> data) {
    final id = data['id'];
    if (id is! int) {
      throw FormatException(
          'Invalid JSON: required "id" field of type int in $data');
    }
    final name = data['name'];
    if (name is! String) {
      throw FormatException(
          'Invalid JSON: required "name" field of type String in $data');
    }
    final position = data['position'];
    if (position is! int) {
      throw FormatException(
          'Invalid JSON: required "position" field of type int in $data');
    }
    final isVisible = data['visible'];
    if (isVisible is! bool) {
      throw FormatException(
          'Invalid JSON: required "visible" field of type bool in $data');
    }
    final isVariation = data['variation'];
    if (isVariation is! bool) {
      throw FormatException(
          'Invalid JSON: required "variation" field of type bool in $data');
    }
    final options = data['options'];
    if (options is! List<dynamic>) {
      throw FormatException(
          'Invalid JSON: required "options" field of type List<dynamic> in $data');
    }
    return Attribute(
        id: id,
        name: name,
        position: position,
        isVisible: isVisible,
        isVariation: isVariation,
        options: options);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'position': position,
      'visible': isVisible,
      'variation': isVariation,
      'options': options
    };
  }
}
