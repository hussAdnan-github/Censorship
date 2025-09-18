import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/NavController.dart';
import 'package:flutter_application_1/Controller/ScannController.dart';
import 'package:flutter_application_1/Controller/SearchController.dart';
import 'package:flutter_application_1/Controller/UpdateController.dart';
import 'package:flutter_application_1/bulletin_repository.dart';
import 'package:flutter_application_1/components/BarcodeButton.dart';
import 'package:flutter_application_1/components/FeatureCard.dart';
import 'package:flutter_application_1/components/SearchBar.dart';
import 'package:flutter_application_1/components/CardresultsSearch.dart';
import 'package:flutter_application_1/view/ScanResultsPage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchBarController searchBarController = Get.put(
      SearchBarController(),
    );

    final Updatecontroller updateController = Get.put(Updatecontroller());

    final FocusNode appBarSearchFocusNode = FocusNode();
    appBarSearchFocusNode.addListener(() {
      searchBarController.isSearchFocused.value =
          appBarSearchFocusNode.hasFocus;
    });

    // دالة مساعدة لتحديد إذا كان تابلت أو موبايل
    bool isTablet(BuildContext context) {
      return MediaQuery.of(context).size.width > 600;
    }

    return GestureDetector(
      onTap: () {
        if (appBarSearchFocusNode.hasFocus) {
          appBarSearchFocusNode.unfocus();
        }
      },
      child: Scaffold(
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
                  tooltip: MaterialLocalizations.of(
                    context,
                  ).openAppDrawerTooltip,
                );
              },
            ),
          ],
          automaticallyImplyLeading: false,
          toolbarHeight: isTablet(context) ? 90 : 80,
          backgroundColor: const Color(0xFF1976D2),
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
          title: Padding(
            padding: EdgeInsets.symmetric(
              vertical: isTablet(context) ? 25.0 : 15.0,
              horizontal: isTablet(context) ? 40.0 : 10.0,
            ),
            child: Searchbar(searchFocusNode: appBarSearchFocusNode),
          ),
          centerTitle: true,
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
          final bool shouldShowSearchResults =
              searchBarController.isSearchFocused.value &&
              searchBarController.searchText.value.length > 2;

          if (shouldShowSearchResults) {
            // نتائج البحث
            if (searchBarController.isLoading.value) {
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
            final res = searchBarController.resultsSearch;
            if (res.isEmpty) {
              return const Center(
                child: Text(
                  style: TextStyle(fontSize: 32),
                  "📭 لا توجد بيانات",
                ),
              );
            }
            return ListView.builder(
              itemCount: res.length,
              itemBuilder: (context, index) {
                final item = res[index];
                return Cardresultssearch(
                  item: item,
                  onTap: () {
                    appBarSearchFocusNode.unfocus();
                  },
                );
              },
            );
          } else {
            // الصفحة الرئيسية
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet(context) ? 40 : 20,
                  vertical: isTablet(context) ? 30 : 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'مرحباً بك!',
                      style: TextStyle(
                        fontSize: isTablet(context) ? 36 : 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                    Text(
                      'ساهم في حماية المستهلك بالإبلاغ عن المخالفات.',
                      style: TextStyle(
                        fontSize: isTablet(context) ? 22 : 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // لو تابلت نخليها Grid بدل قائمة
                    LayoutBuilder(
                      builder: (context, constraints) {
                        if (isTablet(context)) {
                          return GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            childAspectRatio: 3,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            children: [
                              Featurecard(
                                icon: Icons.store_mall_directory,
                                title: 'بلاغ عن محل',
                                description:
                                    'قدّم بلاغ عن أي محل يبيع بسعر مبالغ فيه أو منتجات مخالفة.',
                                color: Colors.orange.shade100,
                                iconColor: Colors.orange.shade700,
                              ),
                              Featurecard(
                                icon: Icons.warning,
                                title: 'منتجات منتهية الصلاحية',
                                description:
                                    'أبلغ عن المنتجات المنتهية الصلاحية أو التالفة لحماية المستهلك.',
                                color: Colors.red.shade100,
                                iconColor: Colors.red.shade700,
                              ),
                              Featurecard(
                                icon: Icons.receipt_long,
                                title: 'ارتفاع غير مبرر بالأسعار',
                                description:
                                    'ساعدنا في مراقبة الأسعار عبر الإبلاغ عن أي زيادات غير مبررة.',
                                color: Colors.green.shade100,
                                iconColor: Colors.green.shade700,
                              ),
                              Featurecard(
                                icon: Icons.add_business,
                                title: 'خدمة غير مطابقة',
                                description:
                                    'الإبلاغ عن الخدمات التي لا تتوافق مع المعايير المعلن عنها.',
                                color: const Color.fromARGB(255, 225, 200, 230),
                                iconColor: const Color.fromARGB(
                                  255,
                                  115,
                                  56,
                                  142,
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              Featurecard(
                                icon: Icons.store_mall_directory,
                                title: 'بلاغ عن محل',
                                description:
                                    'قدّم بلاغ عن أي محل يبيع بسعر مبالغ فيه أو منتجات مخالفة.',
                                color: Colors.orange.shade100,
                                iconColor: Colors.orange.shade700,
                              ),
                              const SizedBox(height: 10),
                              Featurecard(
                                icon: Icons.warning,
                                title: 'منتجات منتهية الصلاحية',
                                description:
                                    'أبلغ عن المنتجات المنتهية الصلاحية أو التالفة لحماية المستهلك.',
                                color: Colors.red.shade100,
                                iconColor: Colors.red.shade700,
                              ),
                              const SizedBox(height: 10),
                              Featurecard(
                                icon: Icons.receipt_long,
                                title: 'ارتفاع غير مبرر بالأسعار',
                                description:
                                    'ساعدنا في مراقبة الأسعار عبر الإبلاغ عن أي زيادات غير مبررة.',
                                color: Colors.green.shade100,
                                iconColor: Colors.green.shade700,
                              ),
                              const SizedBox(height: 10),
                              Featurecard(
                                icon: Icons.add_business,
                                title: 'خدمة غير مطابقة',
                                description:
                                    'الإبلاغ عن الخدمات التي لا تتوافق مع المعايير المعلن عنها.',
                                color: const Color.fromARGB(255, 225, 200, 230),
                                iconColor: const Color.fromARGB(
                                  255,
                                  115,
                                  56,
                                  142,
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),

                    const SizedBox(height: 32),
                    Center(
                      child: ScanBarcodeButton(
                        onScanCompleted: (code) async {
                          final scannController = Get.put(ScannController());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ScanResultsPage(scannedCode: code),
                            ),
                          );
                          await scannController.performSearchFromScan(code);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
