class Category {
  final String name;
  final String description;
  final String picture;

  Category({this.picture, this.name, this.description});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'] as String,
      description: json['description'] as String,
      picture: json['picture'] as String,
    );
  }
}

