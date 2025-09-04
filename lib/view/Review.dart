import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/GenericPaginationController.dart';
import 'package:flutter_application_1/Service/serviceApi.dart';
import 'package:flutter_application_1/components/NewsCard.dart';
import 'package:flutter_application_1/model/Bulletins.dart';
import 'package:get/get.dart';

class Review extends StatelessWidget {
  const Review({super.key});

  @override
  Widget build(BuildContext context) {
    final bulletinsController = Get.put(
      GenericPaginationController<Bulletins>(
        fetchFunction: ({page}) => ApiService.fetchBulletins(page: page),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'نشرة الأسعار',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1976D2),
      ),
      body: Obx(() {
        if (bulletinsController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (bulletinsController.errorMessage.isNotEmpty) {
          return Center(
            child: Text("خطأ: ${bulletinsController.errorMessage}"),
          );
        }
        if (bulletinsController.items.isEmpty) {
          return const Center(child: Text("لا توجد بيانات"));
        }

        return ListView.builder(
          controller: bulletinsController.scrollController, // 👈 ربط ScrollController
          padding: const EdgeInsets.all(10),
          itemCount: bulletinsController.items.length +
              (bulletinsController.hasMore.value ? 1 : 0), // 👈 إضافة عنصر Loader
          itemBuilder: (context, index) {
            if (index == bulletinsController.items.length) {
              // 👈 مؤشر التحميل أسفل القائمة
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            final bulletin = bulletinsController.items[index];
            return NewsCard(
              title: bulletin.name,
              date: bulletin.date,
              pdfUrl: bulletin.file,
            );
          },
        );
      }),
    );
  }
}
