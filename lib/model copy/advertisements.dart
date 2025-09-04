class Advertisement {
  final int id;
  final String? image;
  final String whatsapp;
  final String facebook;
  final String instagram;

  Advertisement({
    required this.id,
    required this.image,
    required this.whatsapp,
    required this.facebook,
    required this.instagram,
  });
  factory Advertisement.fromJson(Map<String, dynamic> json) {
    return Advertisement( 
      id: json['id'],
      image:json['image'] ??  'بدون اسم',
      whatsapp: json['link_whatsapp'] ?? 'بدون اسم',
      facebook: json['link_facebook'] ?? 'بدون اسم',
      instagram: json['link_instagram'] ?? 'غير معروف',
     );
  }

  get name => null;
}
