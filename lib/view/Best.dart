import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/AdvertisementController.dart';
import 'package:flutter_application_1/Controller/GenericPaginationController.dart';
import 'package:flutter_application_1/Controller/NavController.dart';
import 'package:flutter_application_1/Controller/UpdateController.dart';
import 'package:flutter_application_1/Service/serviceApi.dart';
import 'package:flutter_application_1/bulletin_repository.dart';
import 'package:flutter_application_1/components/CardBest.dart';
import 'package:flutter_application_1/model/Merchant.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Controller/SliderController.dart';

class Best extends StatelessWidget {
  Best({super.key});

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $urlString';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Updatecontroller updateController = Get.put(Updatecontroller());
            final navController = Get.find<NavController>();

    final merchantsController = Get.put(
      GenericPaginationController<Merchant>(
        fetchFunction: ({page}) => ApiService.fetchMerchants(page: page),
      ),
    );

    final AdvertisementController advertisements = Get.put(
      AdvertisementController(),
    );

    final SliderController sliderController = Get.put(SliderController(0));
    final PageController pageController = PageController();

    ever(advertisements.advertisement, (_) {
      sliderController.updateLength(advertisements.advertisement.length);
    });

    ever(sliderController.currentPage, (int page) {
      if (pageController.hasClients && pageController.page!.round() != page) {
        pageController.animateToPage(
          page,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
    });

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
                  // إلغاء تركيز حقل البحث عند فتح القائمة الجانبية
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ],
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        backgroundColor: const Color(0xFF1976D2),
        elevation: 0,
        shape: const RoundedRectangleBorder(
         ),
        title: Text(
          "أفضـل أسـعار المـحـلات",
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
            // إذا المؤشر أكبر من 0، نرجع خطوة واحدة
            if (navController.selectedIndex.value > 0) {
              navController.changeIndex(navController.selectedIndex.value - 1);
            }
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

   
   body: Column(
        children: [
          // سلايدر الإعلانات
          Container(
            height: 320,
            decoration: BoxDecoration(
              color: const Color(0xFF1976D2),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Obx(() {
              if (advertisements.isLoading.value) {
                return const Text("");
              }
              if (advertisements.errorMessage.isNotEmpty) {
                return Center(child: Text(""));
              }
              if (advertisements.advertisement.isEmpty) {
                return const Center(child: Text("لا توجد إعلانات"));
              }

              final ads = advertisements.advertisement;

              return Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: ads.length,
                      itemBuilder: (context, index) {
                        final ad = ads[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10,
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 8,
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (ad.image != null && ad.image!.isNotEmpty)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      ad.image!,
                                      height: 180,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return const Icon(
                                              Icons.broken_image,
                                              size: 100,
                                              color: Colors.grey,
                                            );
                                          },
                                    ),
                                  ),
                                const SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (ad.web != null && ad.web.isNotEmpty)
                                        _buildSocialIcon(
                                          color: Colors.blue, // لون مميز للويب
                                          icon: FontAwesomeIcons
                                              .globe, // أيقونة الإنترنت / المتصفح
                                          url: ad.web,
                                        ),
                                      const SizedBox(width: 15),
                                      if (ad.whatsapp != null &&
                                          ad.whatsapp.isNotEmpty)
                                        _buildSocialIcon(
                                          color: Colors.green,
                                          icon: FontAwesomeIcons.whatsapp,
                                          url: ad.whatsapp,
                                        ),
                                      const SizedBox(width: 15),
                                      if (ad.facebook != null &&
                                          ad.facebook.isNotEmpty)
                                        _buildSocialIcon(
                                          color: const Color(0xFF1877F2),
                                          icon: FontAwesomeIcons.facebook,
                                          url: ad.facebook,
                                        ),
                                      const SizedBox(width: 15),
                                      if (ad.instagram != null &&
                                          ad.instagram.isNotEmpty)
                                        _buildSocialIcon(
                                          color: Colors.pink,
                                          icon: FontAwesomeIcons.instagram,
                                          url: ad.instagram,
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      onPageChanged: (index) {
                        sliderController.currentPage.value = index;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(sliderController.length.value, (
                          index,
                        ) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: sliderController.currentPage.value == index
                                ? 24
                                : 10,
                            height: 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: sliderController.currentPage.value == index
                                  ? const Color(0xFFE65100)
                                  : Colors.white.withOpacity(0.7),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),

          const SizedBox(height: 25),

          // قائمة المحلات
          Expanded(
            child: Obx(() {
              if (advertisements.isLoading.value) {
               
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
              if (advertisements.errorMessage.isNotEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // وجه تعبيري معبر
                        const Text("😵‍💫", style: TextStyle(fontSize: 80)),
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
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (merchantsController.items.isEmpty) {
                return const Center(child: Text("لا توجد بيانات"));
              }

              return RefreshIndicator(
                   onRefresh: () async {
          await merchantsController.fetchInitial(); // تحديث البيانات عند السحب
        },
                child: ListView.builder(
                  controller: merchantsController.scrollController,
                  itemCount:
                      merchantsController.items.length +
                      (merchantsController.hasMore.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == merchantsController.items.length) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                
                    final merchant = merchantsController.items[index];
                    return Cardbest(
                      image: merchant.image,
                      namePlace: merchant.namePlace,
                      nameDepartment: merchant.nameDepartment,
                      nameMerchant: merchant.nameMerchant,
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon({
    required Color color,
    required IconData icon,
    required String url,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: FaIcon(icon, color: Colors.white, size: 24),
        onPressed: () => _launchUrl(url),
      ),
    );
  }
}
