import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/ScannController.dart';
import 'package:flutter_application_1/components/CardresultsSearch.dart';
import 'package:get/get.dart';

class ScanResultsPage extends StatelessWidget {
  final String scannedCode;
  const ScanResultsPage({super.key, required this.scannedCode});

  @override
  Widget build(BuildContext context) {
    final scannController = Get.find<ScannController>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: scannedCode == "-1"
            ? const Text('لم تلقط الكاميرا اي رمــز')
            : Text('نتائج البحث عن: $scannedCode'),
      ),
      body: Obx(() {
        if (scannController.isLoading.value) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // إيموجي مرتبط بالأسعار والمنتجات
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(seconds: 1),
                  builder: (context, double value, child) {
                    return Transform.translate(
                      offset: Offset(
                        0,
                        -10 * (value - 0.5).abs() * 2,
                      ), // حركة صعود وهبوط
                      child: const Text(
                        "💵🛒", // نقود + عربة تسوق
                        style: TextStyle(fontSize: 60),
                      ),
                    );
                  },
                  onEnd: () {
                    // يمكن تحويل هذا إلى StatefulWidget لتكرار الحركة تلقائياً
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  "جارٍ تحميل ...",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 34, 49, 255),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        } else if (scannController.resultsSanner.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // إيموجي معبر عن عدم وجود بيانات
                  const Text(
                    "📭", // صندوق بريد فارغ
                    style: TextStyle(fontSize: 80),
                  ),
                  const SizedBox(height: 20),
                  // عنوان واضح
                  const Text(
                    "لا توجد بيانات",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  // نص توضيحي أصغر
                  const Text(
                    " لم يتم العثور على نتائج لهذا الكود",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: scannController.resultsSanner.length,
            itemBuilder: (context, index) {
              final result = scannController.resultsSanner[index];
              return Cardresultssearch(
                item: result,
                onTap: () {
                  print('Scan result tapped: ${result['name_product']}');
                },
              );
            },
          );
        }
      }),
    );
  }
}
