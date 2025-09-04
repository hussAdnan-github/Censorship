import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/AdvertisementController.dart';
import 'package:flutter_application_1/Controller/merchantController.dart';
import 'package:flutter_application_1/components/CardBest.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';  
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Controller/SliderController.dart';

class Best extends StatelessWidget {
  final List<Map<String, String>> sliderItems = [
    {
      'image': 'assets/images/about.png',
      'text': 'تخفيضات مذهلة على الكتب والمستلزمات الدراسية',
    },
    {
      'image': 'assets/images/best-seller.png',
      'text': 'أفضل العروض الحصرية على المنتجات الأكثر مبيعاً الآن!',
    },
    {
      'image': 'assets/images/search-document.png',
      'text': 'خصومات كبرى على جميع الأدوات المكتبية والقرطاسية',
    },
    {
      'image': 'assets/images/qr.png',
      'text': 'امسح الكود واحصل على عرض خاص ومفاجآت حصرية!',
    },
  ];

  Best({super.key});
   Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $urlString';
    }
  }

  @override
  Widget build(BuildContext context) {
    final MerchantController Mrchant = Get.put(MerchantController());
    final AdvertisementController Advertisements = Get.put(
      AdvertisementController(),
    );

    final SliderController sliderController = Get.put(
      SliderController(sliderItems.length),
    );
    final PageController pageController = PageController();

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

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF1976D2)),
              child: Text(
                'القائمة',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('الرئيسية'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            // يمكنك إضافة عناصر أخرى هنا
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'المحلات المميزة',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: const Color(
          0xFF1976D2,
        ), // أزرق أعمق وأكثر حيوية (Material Blue 700)
        centerTitle: true,

        elevation: 0, // إزالة الظل من الـ AppBar

        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.white, size: 34),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),

      body: Column(
        children: [
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
              if (Advertisements.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (Advertisements.errorMessage.isNotEmpty) {
                return Center(
                  child: Text("خطأ: ${Advertisements.errorMessage}"),
                );
              }
              if (Advertisements.advertisement.isEmpty) {
                return const Center(child: Text("لا توجد إعلانات"));
              }

              return Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: Advertisements.advertisement.length,
                      itemBuilder: (context, index) {
                        final ad = Advertisements.advertisement[index];
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
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // أيقونة الواتساب
                                          if (ad.whatsapp != null &&
                                              ad.whatsapp!.isNotEmpty)
                                            Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    Colors.green, // لون الخلفية
                                                borderRadius: BorderRadius.circular(
                                                  50,
                                                ), // لجعل الأيقونة دائرية بالكامل
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    spreadRadius: 1,
                                                    blurRadius: 3,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: IconButton(
                                                icon: const FaIcon(
                                                  FontAwesomeIcons.whatsapp,
                                                  color: Color.fromARGB(
                                                    255,
                                                    255,
                                                    255,
                                                    255,
                                                  ),  
                                                  size: 24,  
                                                ),
                                                onPressed: () =>
                                                    _launchUrl(ad.whatsapp!),
                                              ),
                                            ),

                                          const SizedBox(width: 15),
                                           if (ad.facebook != null &&
                                              ad.facebook!.isNotEmpty)
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xFF1877F2),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    spreadRadius: 1,
                                                    blurRadius: 3,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: IconButton(
                                                icon: const FaIcon(
                                                  FontAwesomeIcons.facebook,
                                                  color: Color.fromARGB(
                                                    255,
                                                    255,
                                                    255,
                                                    255,
                                                  ),  
                                                  size: 24,  
                                                ),
                                                onPressed: () =>
                                                    _launchUrl(ad.facebook!),
                                              ),
                                            ),
                                          const SizedBox(width: 15),
                                           if (ad.instagram != null &&
                                              ad.instagram!.isNotEmpty)
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.pink,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    spreadRadius: 1,
                                                    blurRadius: 3,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: IconButton(
                                                icon: const FaIcon(
                                                  FontAwesomeIcons.instagram,
                                                  color: Color.fromARGB(
                                                    255,
                                                    255,
                                                    255,
                                                    255,
                                                  ),  
                                                  size:
                                                      24,  
                                                ),
                                                onPressed: () =>
                                                    _launchUrl(ad.instagram!),
                                              ),
                                            ),
                                        ],
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
                        children: List.generate(
                          Advertisements.advertisement.length,
                          (index) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: sliderController.currentPage.value == index
                                  ? 24
                                  : 10,
                              height: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color:
                                    sliderController.currentPage.value == index
                                    ? const Color(0xFFE65100)
                                    : Colors.white.withOpacity(0.7),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),

          const SizedBox(height: 25),  

                    Expanded(
            child: Obx(() {
              // حالة التحميل الأولي
              if (Mrchant.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              // حالة وجود خطأ
              if (Mrchant.errorMessage.isNotEmpty) {
                return Center(child: Text("خطأ: ${Mrchant.errorMessage}"));
              }
              // حالة عدم وجود بيانات إطلاقاً
              if (Mrchant.merchants.isEmpty) {
                return const Center(child: Text("لا توجد بيانات"));
              }

              // بناء القائمة مع دعم الـ Pagination
              return ListView.builder(
                // 1. ربط الـ ScrollController
                controller: Mrchant.scrollController, 
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                
                // 2. تعديل عدد العناصر
                // العدد هو عدد التجار + 1 إذا كان هناك المزيد من البيانات (لعرض مؤشر التحميل)
                itemCount: Mrchant.merchants.length + (Mrchant.hasMore.value ? 1 : 0),

                itemBuilder: (context, index) {
                  // 3. التحقق إذا كان هذا هو العنصر الأخير
                  // إذا كان index يساوي طول القائمة، فهذا يعني أنه العنصر الإضافي
                  if (index == Mrchant.merchants.length) {
                    // عرض مؤشر التحميل في الأسفل
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  // بناء عنصر القائمة العادي
                  final merchant = Mrchant.merchants[index];
                  return Cardbest(
                    image: merchant.image,
                    namePlace: merchant.namePlace,
                    nameDepartment: merchant.nameDepartment,
                    nameMerchant: merchant.nameMerchant,
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
 
