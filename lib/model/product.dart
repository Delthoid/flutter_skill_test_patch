class Product {
  final int? id;
  final String? title;
  final double? price;
  final String? category;
  final String? description;
  final String? image;

  Product({
    this.id,
    this.title,
    this.price,
    this.category,
    this.description,
    this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int?,
      title: json['title'] as String?,
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      category: json['category'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'category': category,
        'description': description,
        'image': image,
      };
}
