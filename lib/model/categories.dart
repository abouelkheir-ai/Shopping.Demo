class Categories {
  final String categoryTitles;
  const Categories({required this.categoryTitles});

  factory Categories.fromJson(String json) {
    return Categories(categoryTitles: json);
  }
}
