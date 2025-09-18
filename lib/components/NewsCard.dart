import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';

class NewsCard extends StatelessWidget {
  final String title;
  final String date;
  final String pdfUrl;

  const NewsCard({
    super.key,
    required this.title,
    required this.date,
    required this.pdfUrl,
  });
  Future<void> _downloadPdf(BuildContext context) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final filePath = "${dir.path}/${title.replaceAll(' ', '_')}.pdf";
      Dio dio = Dio();
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                title: const Text(
                  "جارٍ تنزيل الملف...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    SizedBox(height: 16),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "الرجاء الانتظار حتى يكتمل التنزيل",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
      await dio.download(pdfUrl, filePath);
      Navigator.of(context).pop();
      await OpenFilex.open(filePath);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("تم تنزيل الملف بنجاح!")));
    } catch (e) {
      Navigator.of(context).pop(); // إغلاق أي Dialog مفتوح
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("فشل التنزيل: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF1180DB), Color(0xFF76B3E6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            InkWell(
              onTap: pdfUrl.isEmpty
                  ? null
                  : () => _downloadPdf(
                      context,
                    ), // تعطيل الضغط إذا كان pdfUrl فارغ
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: pdfUrl.isEmpty
                      ? Colors.grey.withOpacity(0.4) // لون للـ disabled
                      : const Color.fromARGB(255, 72, 255, 0).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.download,
                  color: pdfUrl.isEmpty ? Colors.grey[300] : Colors.white,
                  size: 28,
                ),
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Directionality(
                textDirection: TextDirection.rtl,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      date,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 24),

            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: const Icon(
                Icons.article_outlined,
                color: Colors.white,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
