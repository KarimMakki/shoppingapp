class Images {
  final String src;
  final String name;
  Images({required this.src, required this.name});

  factory Images.fromJson(Map<String, dynamic> data) {
    final src = data['src'];
    if (src is! String) {
      throw FormatException(
          'Invalid JSON: required "src" field of type String in $data');
    }
    final name = data['name'];
    if (name is! String) {
      throw FormatException(
          'Invalid JSON: required "name" field of type String in $data');
    }
    return Images(src: src, name: name);
  }

  Map<String, dynamic> toJson() {
    return {'src': src, "name": name};
  }
}
