class Merchant {
  final int id;
  final String? image;
  final String namePlace;
  final String nameDepartment;
  final String nameMerchant;

  Merchant({
    required this.id,
    required this.image,
    required this.namePlace,
    required this.nameDepartment,
    required this.nameMerchant,
  }); 

  factory Merchant.fromJson(Map<String, dynamic> json) {
    return Merchant(  
      id: json['id'],
      image:json['image'] ?? null,
      namePlace: json['name_place'] ?? 'بدون اسم',
      nameDepartment: json['name_department'] ?? 'غير معروف',
      nameMerchant: json['name_name_merchant'] ?? 'غير محدد',
    );
  }

}
