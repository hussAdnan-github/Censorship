import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/AdvertisementController.dart';
import 'package:flutter_application_1/Controller/GenericPaginationController.dart';
import 'package:flutter_application_1/Service/serviceApi.dart';
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

      appBar: AppBar(
        title: const Text(
          'المحلات المميزة',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: const Color(0xFF1976D2),
        centerTitle: true,
        elevation: 0,
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
                return const Center(child: CircularProgressIndicator());
              }
              if (advertisements.errorMessage.isNotEmpty) {
                return Center(
                  child: Text("خطأ: ${advertisements.errorMessage}"),
                );
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
              if (merchantsController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (merchantsController.errorMessage.isNotEmpty) {
                return Center(
                  child: Text("خطأ: ${merchantsController.errorMessage}"),
                );
              }
              if (merchantsController.items.isEmpty) {
                return const Center(child: Text("لا توجد بيانات"));
              }

              return ListView.builder(
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
