// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/Controller/AdvertisementController.dart';
// import 'package:flutter_application_1/Controller/merchantController.dart';
// import 'package:flutter_application_1/components/CardBest.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import '../Controller/SliderController.dart';

// class Best extends StatelessWidget {
//   Best({super.key});

//   Future<void> _launchUrl(String urlString) async {
//     if (urlString.isEmpty) return; // لا تفعل شيئًا إذا كان الرابط فارغًا

//     final Uri url = Uri.parse(urlString);
//     try {
//       if (await launchUrl(url, mode: LaunchMode.externalApplication)) {
//         Get.snackbar(
//           'نجاح',
//           'تم فتح الرابط بنجاح',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//         );
//       } else {
//         Get.snackbar(
//           'خطأ',
//           'لا يمكن فتح الرابط: ${url.toString()}',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//       }
//     } catch (e) {
//       Get.snackbar(
//         'خطأ',
//         'حدث خطأ غير متوقع: ${e.toString()}',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final MerchantController Mrchant = Get.put(MerchantController());
//     final AdvertisementController Advertisements = Get.put(
//       AdvertisementController(),
//     );

//     final SliderController sliderController = Get.put(SliderController(0));
//     final PageController pageController = PageController();

//     ever(sliderController.currentPage, (int page) {
//       if (pageController.hasClients && pageController.page!.round() != page) {
//         pageController.animateToPage(
//           page,
//           duration: const Duration(milliseconds: 500),
//           curve: Curves.ease,
//         );
//       }
//     });

//     return Scaffold(
//       backgroundColor: Colors.blue[50],
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             const DrawerHeader(
//               decoration: BoxDecoration(color: Color(0xFF1976D2)),
//               child: Text(
//                 'القائمة',
//                 style: TextStyle(color: Colors.white, fontSize: 22),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.home),
//               title: const Text('الرئيسية'),
//               onTap: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         ),
//       ),
//       appBar: AppBar(
//         title: const Text(
//           'المحلات المميزة',
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 22,
//           ),
//         ),
//         backgroundColor: const Color(0xFF1976D2),
//         centerTitle: true,
//         elevation: 0,
//         leading: Builder(
//           builder: (BuildContext context) {
//             return IconButton(
//               icon: const Icon(Icons.menu, color: Colors.white, size: 34),
//               onPressed: () {
//                 Scaffold.of(context).openDrawer();
//               },
//               tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
//             );
//           },
//         ),
//       ),
//       body: Column(
//         children: [
//           Container(
//             height: 320,
//             decoration: BoxDecoration(
//               color: const Color(0xFF1976D2),
//               borderRadius: const BorderRadius.vertical(
//                 bottom: Radius.circular(30),
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   spreadRadius: 2,
//                   blurRadius: 5,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Obx(() {
//               if (Advertisements.isLoading.value) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//               if (Advertisements.errorMessage.isNotEmpty) {
//                 return Center(
//                   child: Text("خطأ: ${Advertisements.errorMessage}"),
//                 );
//               }
//               if (Advertisements.advertisement.isEmpty) {
//                 return const Center(child: Text("لا توجد إعلانات"));
//               }
//               sliderController.length.value = Advertisements.advertisement.length;

//               return Column(
//                 children: [
//                   Expanded(
//                     child: PageView.builder(
//                       controller: pageController,
//                       itemCount: Advertisements.advertisement.length,
//                       itemBuilder: (context, index) {
//                         final ad = Advertisements.advertisement[index];
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 20.0,
//                             vertical: 10,
//                           ),
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             elevation: 8,
//                             color: Colors.white,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 if (ad.image != null && ad.image!.isNotEmpty)
//                                   ClipRRect(
//                                     borderRadius: BorderRadius.circular(15),
//                                     child: Image.network(
//                                       ad.image!,
//                                       height: 180,
//                                       width: double.infinity,
//                                       fit: BoxFit.cover,
//                                       errorBuilder: (context, error, stackTrace) {
//                                         return const Icon(
//                                           Icons.broken_image,
//                                           size: 100,
//                                           color: Colors.grey,
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 const SizedBox(height: 15),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 15.0,
//                                   ),
//                                   child: Column(
//                                     children: [
//                                       Text(
//                                         "إعلان ${ad.id}",
//                                         style: const TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.w800,
//                                           color: Color(0xFF1976D2),
//                                           height: 1.3,
//                                         ),
//                                         textAlign: TextAlign.center,
//                                       ),
//                                       const SizedBox(height: 10),
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment.center,
//                                         children: [
//                                           if (ad.whatsapp != null && ad.whatsapp!.isNotEmpty)
//                                             Container(
//                                               decoration: BoxDecoration(
//                                                 color: Colors.white,
//                                                 borderRadius: BorderRadius.circular(50),
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                     color: Colors.black.withOpacity(0.1),
//                                                     spreadRadius: 1,
//                                                     blurRadius: 3,
//                                                     offset: const Offset(0, 2),
//                                                   ),
//                                                 ],
//                                               ),
//                                               child: IconButton(
//                                                 icon: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green, size: 24),
//                                                 onPressed: () => _launchUrl(ad.whatsapp!),
//                                               ),
//                                             ),
//                                           const SizedBox(width: 15),
//                                           if (ad.facebook != null && ad.facebook!.isNotEmpty)
//                                             Container(
//                                               decoration: BoxDecoration(
//                                                 color: Colors.white,
//                                                 borderRadius: BorderRadius.circular(50),
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                     color: Colors.black.withOpacity(0.1),
//                                                     spreadRadius: 1,
//                                                     blurRadius: 3,
//                                                     offset: const Offset(0, 2),
//                                                   ),
//                                                 ],
//                                               ),
//                                               child: IconButton(
//                                                 icon: const FaIcon(FontAwesomeIcons.facebook, color: Color(0xFF1877F2), size: 24),
//                                                 onPressed: () => _launchUrl(ad.facebook!),
//                                               ),
//                                             ),
//                                           const SizedBox(width: 15),
//                                           if (ad.instagram != null && ad.instagram!.isNotEmpty)
//                                             Container(
//                                               decoration: BoxDecoration(
//                                                 color: Colors.white,
//                                                 borderRadius: BorderRadius.circular(50),
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                     color: Colors.black.withOpacity(0.1),
//                                                     spreadRadius: 1,
//                                                     blurRadius: 3,
//                                                     offset: const Offset(0, 2),
//                                                   ),
//                                                 ],
//                                               ),
//                                               child: IconButton(
//                                                 icon: const FaIcon(FontAwesomeIcons.instagram, color: Colors.pink, size: 24),
//                                                 onPressed: () => _launchUrl(ad.instagram!),
//                                               ),
//                                             ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                       onPageChanged: (index) {
//                         sliderController.currentPage.value = index;
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 10.0),
//                     child: Obx(
//                       () => Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: List.generate(
//                           Advertisements.advertisement.length,
//                           (index) {
//                             return AnimatedContainer(
//                               duration: const Duration(milliseconds: 300),
//                               margin: const EdgeInsets.symmetric(horizontal: 4),
//                               width: sliderController.currentPage.value == index ? 24 : 10,
//                               height: 10,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5),
//                                 color: sliderController.currentPage.value == index
//                                     ? const Color(0xFFE65100)
//                                     : Colors.white.withOpacity(0.7),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             }),
//           ),
//           const SizedBox(height: 25),
//           Expanded(
//             child: Obx(() {
//               if (Mrchant.isLoading.value) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//               if (Mrchant.errorMessage.isNotEmpty) {
//                 return Center(child: Text("خطأ: ${Mrchant.errorMessage}"));
//               }
//               if (Mrchant.merchants.isEmpty) {
//                 return const Center(child: Text("لا توجد بيانات"));
//               }
//               return ListView.builder(
//                 padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                 itemCount: Mrchant.merchants.length,
//                 itemBuilder: (context, index) {
//                   final merchant = Mrchant.merchants[index];
//                   return Cardbest(
//                     image: merchant.image,
//                     namePlace: merchant.namePlace,
//                     nameDepartment: merchant.nameDepartment,
//                     nameMerchant: merchant.nameMerchant,
//                   );
//                 },
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }



//  // IconButton(
//             //   icon: const Icon(Icons.download, color: Colors.white),
//             //   tooltip: 'تحميل البيانات Offline',
//             //   onPressed: () async {
//             //     // هنا نضع دالة تحميل البيانات وحفظها في SQLite
//             //     final repository = BulletinRepository();
//             //     ScaffoldMessenger.of(context).showSnackBar(
//             //       const SnackBar(content: Text('جاري تحميل البيانات...')),
//             //     );

//             //     try {
//             //       final data = await repository.getBulletins();
//             //       ScaffoldMessenger.of(context).showSnackBar(
//             //         SnackBar(
//             //           content: Text('تم حفظ ${data.length} سجلات بنجاح!'),
//             //         ),
//             //       );
//             //     } catch (e) {
//             //       ScaffoldMessenger.of(
//             //         context,
//             //       ).showSnackBar(SnackBar(content: Text('حدث خطأ: $e')));
//             //     }
//             //   },
//             // ),