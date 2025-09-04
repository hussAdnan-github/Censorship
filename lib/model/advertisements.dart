class Advertisement {
  final int id;
  final String whatsapp;
  final String facebook;
  final String instagram;
  final String? image;

  Advertisement({
    required this.id,
    required this.whatsapp,
    required this.facebook,
    required this.instagram,
    required this.image,
  });
  factory Advertisement.fromJson(Map<String, dynamic> json) {
    return Advertisement(
      id: json['id'],
      whatsapp: json['link_whatsapp'] ?? 'بدون اسم',
      facebook: json['link_facebook'] ?? 'بدون اسم',
      instagram: json['link_instagram'] ?? 'غير معروف',
      image: json['image'] ?? 'بدون اسم',
    );
  }

  get name => null;
}
