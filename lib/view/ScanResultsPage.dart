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
          return const Center(child: CircularProgressIndicator());
        } else if (scannController.resultsSanner.isEmpty) {
          return const Center(
            child: Text('لم يتم العثور على نتائج لهذا الكود.'),
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