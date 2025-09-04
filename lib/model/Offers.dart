class Offers {
  final int id;
  final double discount;
  final String name;
  final String place;
  final String title;
  final String description;
  final String? image;
  final double oldPrice;
  final double newPrice;

  Offers({
    required this.id,
    required this.discount,
    required this.name,
    required this.place,
    required this.title,
    required this.description,
    required this.image,
    required this.oldPrice,
    required this.newPrice,
  });

  factory Offers.fromJson(Map<String, dynamic> json) {
    return Offers(
      id: json['id'],
      discount: json['discount_rate'] ?? 0.0,
      name: json['name_name_merchant'] ?? 'بدون اسم',
      place: json['name_place'] ?? 'غير معروف',
      title: json['title'] ?? 'غير محدد',
      description: json['description'] ?? 'غير محدد',
      image: json['image'] ?? null,
      oldPrice: json['old_price'] ?? 0.0,
      newPrice: json['new_price'] ?? 0.0,
    );
  }
}
