import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/ScannController.dart';
import 'package:flutter_application_1/Controller/SearchController.dart';
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
          automaticallyImplyLeading: false,
          toolbarHeight: 70,
          backgroundColor: const Color(0xFF1976D2),
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 20.0 , bottom: 20),
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
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }

             final res = searchBarController.resultsSearch;
            if (res.isEmpty) {
              return const Center(child: Text('لا توجد نتائج'));
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
