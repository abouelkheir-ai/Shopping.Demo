class Products {
  final int id;
  final String title;
  final double price; 
  final String description;
  final String category;
  final String image;
  final Map<String, dynamic> rating;

  const Products({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"],
        title: json["title"],
        price: (json["price"] as num).toDouble(), // Adjust the type here
        description: json["description"],
        category: json["category"],
        image: json["image"],
        rating: json["rating"],
      );
}
