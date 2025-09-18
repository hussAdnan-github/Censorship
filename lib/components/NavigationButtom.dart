import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/NavController.dart';
import 'package:flutter_application_1/view/Discount.dart';
import 'package:get/get.dart';

class NavigationButtom extends StatelessWidget {
  const NavigationButtom({super.key});

  Future<bool> _onWillPop() async {
    return await Get.dialog(
          AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Center(
              child: Text(
                '😄 تأكيد',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            content: const Text(
              'هل أنت متأكد من الخروج من التطبيق؟',
              style: TextStyle(fontSize: 18),
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(result: false),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  '❌ لا',
                  style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () => Get.back(result: true),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  '✅ نعم',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final NavController navController = Get.put(NavController());
    navController.isFabPressed.value = false; // للتحكم في الزر العائم

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.grey[100],

        // ✅ AnimatedSwitcher للانتقال بين الشاشات بسلاسة
        body: Obx(
          () => AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, animation) =>
                FadeTransition(opacity: animation, child: child),
            child: navController.screens[navController.selectedIndex.value],
          ),
        ),

        // ✅ FloatingActionButton مع أنيميشن
        floatingActionButton: GestureDetector(
          onTapDown: (_) => navController.isFabPressed.value = true,
          onTapUp: (_) {
            navController.isFabPressed.value = false;
            Get.to(() => const Discount(),
                transition: Transition.downToUp,
                duration: const Duration(milliseconds: 600));
          },
          child: Obx(
            () => AnimatedScale(
              duration: const Duration(milliseconds: 200),
              scale: navController.isFabPressed.value ? 0.85 : 1.0,
              child: FloatingActionButton(
                backgroundColor: const Color(0xFF1976D2),
                shape: const CircleBorder(),
                onPressed: null, // نستخدم GestureDetector بداله
                child: Image.asset('assets/images/discount.png',
                    width: 45, height: 45),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        // ✅ BottomNavigationBar مع أنيميشن للأيقونات
        bottomNavigationBar: Obx(
          () => Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                elevation: 0,
                currentIndex: 3 - navController.selectedIndex.value,
                onTap: (index) {
                  navController.changeIndex(3 - index);
                },
                selectedItemColor: const Color(0xFF0A2D4D),
                unselectedItemColor: Colors.grey,
                showUnselectedLabels: true,
                items: [
                  _buildNavItem(
                    iconPath: 'assets/images/about.png',
                    label: 'عنـــا',
                    isSelected: (3 - navController.selectedIndex.value) == 0,
                  ),
                  _buildNavItem(
                    iconPath: 'assets/images/best-seller.png',
                    label: 'الأفضــل',
                    isSelected: (3 - navController.selectedIndex.value) == 1,
                  ),
                  _buildNavItem(
                    iconPath: 'assets/images/search-document.png',
                    label: 'نشـــرة',
                    isSelected: (3 - navController.selectedIndex.value) == 2,
                  ),
                  _buildNavItem(
                    iconPath: 'assets/images/qr.png',
                    label: 'مســح',
                    isSelected: (3 - navController.selectedIndex.value) == 3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required String iconPath,
    required String label,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected
              ? const Color.fromARGB(144, 25, 118, 210)
              : Colors.transparent,
          boxShadow: isSelected
              ? [
                  const BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: AnimatedScale(
          duration: const Duration(milliseconds: 300),
          scale: isSelected ? 1.2 : 1.0,
          child: Image.asset(
            iconPath,
            width: 28,
            height: 28,
          ),
        ),
      ),
      label: label,
    );
  }
}
