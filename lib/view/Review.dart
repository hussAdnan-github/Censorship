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
              }

        if (bulletinsController.errorMessage.isNotEmpty) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // وجه تعبيري معبر
          const Text(
            "😵‍💫",
            style: TextStyle(fontSize: 80),
          ),
          const SizedBox(height: 20),
          // عنوان واضح
          const Text(
            "لا يوجد اتصال بالإنترنت",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          // نص توضيحي أصغر
          const Text(
            "تحقق من اتصالك وحاول لاحقًا",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}


        if (bulletinsController.items.isEmpty) {
          return const Center(child: Text("لا توجد بيانات"));
        }

        return ListView.builder(
          controller: bulletinsController.scrollController,
          padding: const EdgeInsets.all(10),
          itemCount: bulletinsController.items.length +
              (bulletinsController.hasMore.value ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == bulletinsController.items.length) {
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
