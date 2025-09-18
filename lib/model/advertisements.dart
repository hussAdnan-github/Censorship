class Advertisement {
  final int id;
  final String web;
  final String whatsapp;
  final String facebook;
  final String instagram;
  final String? image;

  Advertisement({ 
    required this.id,
    required this.web,
    required this.whatsapp,
    required this.facebook,
    required this.instagram,
    required this.image,
  });
  factory Advertisement.fromJson(Map<String, dynamic> json) {
    return Advertisement(
      id: json['id'],
      web: json['link_web'] ?? 'بدون اسم',
      whatsapp: json['link_whatsapp'] ?? 'بدون اسم',
      facebook: json['link_facebook'] ?? 'بدون اسم',
      instagram: json['link_instagram'] ?? 'غير معروف',
      image: json['image'] ?? 'بدون اسم',
    );
  }

  get name => null;
}
