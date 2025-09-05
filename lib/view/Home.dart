import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/ScannController.dart';
import 'package:flutter_application_1/Controller/SearchController.dart';
import 'package:flutter_application_1/bulletin_repository.dart';
import 'package:flutter_application_1/components/BarcodeButton.dart';
import 'package:flutter_application_1/components/FeatureCard.dart';
import 'package:flutter_application_1/components/SearchBar.dart'; // Your Searchbar input field
import 'package:flutter_application_1/components/CardresultsSearch.dart'; // Your result card
import 'package:flutter_application_1/view/ScanResultsPage.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchBarController searchBarController = Get.put(
      SearchBarController(),
    );

    final FocusNode appBarSearchFocusNode = FocusNode();

    appBarSearchFocusNode.addListener(() {
      searchBarController.isSearchFocused.value =
          appBarSearchFocusNode.hasFocus;
    });

    return GestureDetector(
      onTap: () {
        // إخفاء لوحة المفاتيح وإلغاء التركيز عند النقر في أي مكان آخر
        if (appBarSearchFocusNode.hasFocus) {
          appBarSearchFocusNode.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.download, color: Colors.white),
              tooltip: 'تحميل البيانات Offline',
              onPressed: () async {
                // هنا نضع دالة تحميل البيانات وحفظها في SQLite
                final repository = BulletinRepository();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('جاري تحميل البيانات...')),
                );

                try {
                  final data = await repository.getBulletins();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('تم حفظ ${data.length} سجلات بنجاح!'),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('حدث خطأ: $e')));
                }
              },
            ),
          ],
          automaticallyImplyLeading: false,
          toolbarHeight: 70,
          backgroundColor: const Color(0xFF1976D2),
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20),
            child: Searchbar(searchFocusNode: appBarSearchFocusNode),
          ),
          centerTitle: true,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu, color: Colors.white, size: 34),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                  // إلغاء تركيز حقل البحث عند فتح القائمة الجانبية
                  if (appBarSearchFocusNode.hasFocus) {
                    appBarSearchFocusNode.unfocus();
                  }
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ),

        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Color(0xFF1976D2)),
                child: Text(
                  'القائمة',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('الرئيسية'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),

        body: Obx(() {
          final bool shouldShowSearchResults =
              searchBarController.isSearchFocused.value &&
              searchBarController.searchText.value.length > 2;

          if (shouldShowSearchResults) {
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
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      // نص توضيحي أصغر
                      const Text(
                        "يتم العثور على نتائج لهذا المنتج",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
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
                    print('Search result tapped: ${item['name_product']}');
                    appBarSearchFocusNode
                        .unfocus(); // إلغاء التركيز عند اختيار نتيجة
                  },
                );
              },
            );
          } else {
            // عرض محتوى الصفحة الرئيسية الافتراضي
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'مرحباً بك!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                    Text(
                      'ساهم في حماية المستهلك بالإبلاغ عن المخالفات.',
                      style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 20),
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
                      icon: Icons.add_business, // Changed icon for variety
                      title: 'خدمة غير مطابقة',
                      description:
                          'الإبلاغ عن الخدمات التي لا تتوافق مع المعايير المعلن عنها.',
                      color: const Color.fromARGB(255, 225, 200, 230),
                      iconColor: const Color.fromARGB(255, 115, 56, 142),
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: ScanBarcodeButton(
                        onScanCompleted: (code) async {
                          // من الأفضل استخدام Get.find إذا كنت متأكدًا من أن الـ Controller موجود بالفعل
                          final scannController = Get.put(ScannController());

                          // الانتقال إلى صفحة النتائج فورًا
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ScanResultsPage(scannedCode: code),
                            ),
                          );
                          // تنفيذ البحث في الخلفية
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
