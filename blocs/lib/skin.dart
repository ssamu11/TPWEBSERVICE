class Skin {
  final String name;
  final int price;
  final String imageUrl;

  Skin({
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  factory Skin.fromJson(Map<String, dynamic> json) {
    return Skin(
      name: json['name'] as String,
      price: json['price_idr'] as int,
      imageUrl: json['image_url'] as String,
    );
  }
}
