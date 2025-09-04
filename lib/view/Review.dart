import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/BulletinsController.dart';
import 'package:flutter_application_1/components/NewsCard.dart';
import 'package:get/get.dart';

class Review extends StatelessWidget {
  const Review({super.key});

  @override
  Widget build(BuildContext context) {
    
    final BulletinsController Bulletins = Get.put(BulletinsController());

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'نشرة الاسعار ',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1976D2),
      ),
      body: Column(
        children: [
           
          Expanded(
            child: Obx(() {

              if (Bulletins.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (Bulletins.errorMessage.isNotEmpty) {
                return Center(child: Text("خطأ: ${Bulletins.errorMessage}"));
              }
              if (Bulletins.bulletins.isEmpty) {
                return const Center(child: Text("لا توجد بيانات"));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(10),
                 itemCount: Bulletins.bulletins.length,
                itemBuilder: (context, index) {
                  final bulletin = Bulletins.bulletins[index];
                  return NewsCard(
                     title: bulletin.name,
                    date: bulletin.date,
                    pdfUrl: bulletin.file,
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
