class Bulletins {
  final int id;
  final String name;
  final String date;
  final String file;

  Bulletins({
    required this.id,
    required this.name,
    required this.date,
    required this.file,
  }); 

  factory Bulletins.fromJson(Map<String, dynamic> json) {
    return Bulletins(
      id: json['id'],
      name: json['name'] ?? 'بدون اسم',
      date: json['date'] ?? 'غير معروف',
      file: json['file'] ?? 'غير محدد',
    );
  }
}
