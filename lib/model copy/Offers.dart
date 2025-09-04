class Offers {
  final int id;
  final double? discount;
  final double oldPrice;
  final double newPrice;
  final String name;
  final String place;
  final String title;
  final String description;

  Offers({
    required this.id,
    required this.discount,
    required this.oldPrice,
    required this.newPrice,
    required this.name,
    required this.place,
    required this.title,
    required this.description,
   
  });
  
  factory Offers.fromJson(Map<String, dynamic> json) {

    return Offers(  
      id: json['id'],
      discount:json['discount_rate'] ?? 0.0,
      oldPrice:json['old_price'] ?? 0.0,
      newPrice:json['new_price'] ?? 0.0,
      name: json['name_name_merchant'] ?? 'بدون اسم',
      place: json['name_place'] ?? 'غير معروف',
      title: json['title'] ?? 'غير محدد',
      description: json['description'] ?? 'غير محدد',
    );
  }

}
