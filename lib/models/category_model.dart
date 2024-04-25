class Category {
  int? id;
  String? name;
  int? parent;
  int? totalProducts;
  bool? hasChildren;
  String? image;
  String? display;

  Category(
      {this.id,
      this.name,
      this.parent,
      this.totalProducts,
      this.hasChildren,
      this.image,
      this.display});

  factory Category.fromJson(Map<String, dynamic> data) {
    final id = data['id'];
    // if (id is! int) {
    //   throw FormatException(
    //       'Invalid JSON: required "id" field of type int in $data');
    // }
    final name = data['name'];
    // if (name is! String) {
    //   throw FormatException(
    //       'Invalid JSON: required "name" field of type String in $data');
    // }
    final parent = data['parent'];
    // if (parent is! int) {
    //   throw FormatException(
    //       'Invalid JSON: required "parent" field of type int in $data');
    // }
    final totalProducts = data['count'];
    // if (totalProducts is! int) {
    //   throw FormatException(
    //       'Invalid JSON: required "parent" field of type int in $data');
    // }
    final hasChildren = data['has_children'];
    // if (hasChildren is! bool) {
    //   throw FormatException(
    //       'Invalid JSON: required "hasChildren" field of type bool in $data');
    // }
    final imagesData = data['image'] as Map<String, dynamic>?;

    final image = imagesData == null ? "false" : imagesData['src'].toString();
    // if (image is! String) {
    //   throw FormatException(
    //       'Invalid JSON: required "hasChildren" field of type bool in $data');
    // }
    final display = data['display'];

    return Category(
        id: id,
        name: name,
        parent: parent,
        totalProducts: totalProducts,
        hasChildren: hasChildren,
        image: image,
        display: display);
  }
}
