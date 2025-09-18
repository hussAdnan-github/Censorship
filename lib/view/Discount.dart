import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/GenericPaginationController.dart';
import 'package:flutter_application_1/Controller/NavController.dart';
import 'package:flutter_application_1/Controller/UpdateController.dart';
import 'package:flutter_application_1/Service/serviceApi.dart';
import 'package:flutter_application_1/bulletin_repository.dart';
import 'package:flutter_application_1/components/DiscountCard.dart';
import 'package:flutter_application_1/components/NavigationButtom.dart';
import 'package:flutter_application_1/model/Offers.dart';
import 'package:flutter_application_1/view/Home.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Discount extends StatelessWidget {
  const Discount({super.key});

  @override
  Widget build(BuildContext context) {
    // Updatecontroller
    final Updatecontroller updateController = Get.put(Updatecontroller());
    final navController = Get.find<NavController>();

    final offersController = Get.put(
      GenericPaginationController<Offers>(
        fetchFunction: ({page}) => ApiService.fetchOffers(page: page),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.blue[50],

      appBar: AppBar(
        actions: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu, color: Colors.white, size: 34),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        backgroundColor: const Color(0xFF1976D2),
        elevation: 0,
        shape: const RoundedRectangleBorder(),
        title: const Text(
          "عروض مميزة",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_circle_left,
            color: Colors.white,
            size: 40,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),

      endDrawer: Drawer(
        child: Directionality(
          textDirection: TextDirection.rtl, // اجعل المحتوى من اليمين لليسار
          child: Obx(() {
            final results = updateController.updates;
            return Column(
              children: [
                // المحتوى القابل للتمرير
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        decoration: const BoxDecoration(
                          color: Color(0xFF1976D2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(height: 16),
                            Text(
                              'مكتب وزارة الصناعة و التجارة بساحل حضرموت',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.home),
                        title: const Text('الرئيسية'),
                        onTap: () {
                          final navController = Get.find<NavController>();
                          navController.changeIndex(0);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.download),
                        title: const Text('تحميل البيانات بدون انترنت'),
                        onTap: () async {
                          Navigator.of(context).pop();
                          final repository = BulletinRepository();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('جاري تحميل البيانات...'),
                            ),
                          );
                          try {
                            final data = await repository.getBulletins();
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: 60,
                                        ),
                                        const SizedBox(height: 15),
                                        const Text(
                                          "تم الحفظ بنجاح 🎉",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          "يمكنك استخدام التطبيق حتى بدون انترنت 🌐❌",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text(
                                            "حسناً",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } catch (e) {
                           showDialog(
  context: context,
  builder: (context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 70),
            const SizedBox(height: 15),
            const Text(
              "حدث خطأ ❌",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "تأكد من تشغيل الإنترنت أو أعد المحاولة لاحقاً.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "حسناً",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  },
);

                          }
                        },
                      ),
                      if (results.isNotEmpty)
                        ListTile(
                          leading: const Icon(
                            Icons.refresh,
                            color: Colors.blue,
                          ),
                          title: const Text('تحديث التطبيق'),
                          onTap: () async {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('جاري فتح الرابط...'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            final Uri url = Uri.parse(
                              updateController.appUrl.value,
                            );
                            if (!await launchUrl(
                              url,
                              mode: LaunchMode.externalApplication,
                            )) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('تعذر فتح الرابط'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                        ),
                    ],
                  ),
                ),

                // 👇 الصورة مثبتة أسفل الـ Drawer
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      10,
                    ), // 👈 هنا تحدد نصف القطر
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),

      body: Obx(() {
        if (offersController.isLoading.value &&
            offersController.items.isEmpty) {
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

        if (offersController.errorMessage.isNotEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text("😵‍💫", style: TextStyle(fontSize: 80)),
                  SizedBox(height: 20),
                  Text(
                    "لا يوجد اتصال بالإنترنت",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "تحقق من اتصالك وحاول لاحقًا",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        if (offersController.items.isEmpty) {
          return const Center(child: Text("لا توجد عروض حالياً"));
        }

        // ✅ صفحة العروض مع الهيدر
        return Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                // gradient: LinearGradient(
                //   colors: [Colors.blue.shade800, Colors.blue.shade400],
                //   begin: Alignment.topRight,
                //   end: Alignment.bottomLeft,
                // ),
                color: const Color(0xFF1976D2),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "🔥 عروض رائعة في انتظارك 🔥",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "وفر على منتجاتك المفضلة مع خصومات تصل حتى %70",
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      OverlayEntry? overlayEntry;

                      overlayEntry = OverlayEntry(
                        builder: (context) => Positioned(
                          bottom: 100,
                          left: MediaQuery.of(context).size.width / 2 - 30,
                          child: TweenAnimationBuilder<double>(
                            tween: Tween(begin: 1, end: 0),
                            duration: const Duration(seconds: 1),
                            builder: (context, value, child) {
                              return Transform.translate(
                                offset: Offset(0, -200 * (1 - value)),
                                child: Opacity(opacity: value, child: child),
                              );
                            },
                            child: const Icon(
                              Icons.local_offer, // أيقونة العرض 🎫
                              size: 60,
                              color: Colors.orangeAccent,
                            ),
                          ),
                        ),
                      );

                      Overlay.of(context).insert(overlayEntry!);

                      Future.delayed(const Duration(seconds: 1), () {
                        overlayEntry?.remove();
                      });
                    },
                    icon: const Icon(Icons.local_offer, color: Colors.white),
                    label: const Text(
                      "شاهد العروض الآن",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // باقي العروض
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await offersController
                      .fetchInitial(); // تحديث البيانات عند السحب
                },
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 16,
                  ),
                  itemCount: offersController.items.length,
                  itemBuilder: (context, index) {
                    final offer = offersController.items[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: DiscountCard(
                        imageUrl: offer.image ?? 'assets/images/discount.png',
                        storeName: offer.name,
                        location: offer.place,
                        description: offer.description,
                        date: offer.date,
                        discountPercent: offer.discount.toInt(),
                        oldPrice: offer.oldPrice,
                        newPrice: offer.newPrice,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
