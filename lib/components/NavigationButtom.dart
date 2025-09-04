import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/NavController.dart';
import 'package:flutter_application_1/view/Discount.dart';
import 'package:get/get.dart';

class NavigationButtom extends StatelessWidget {
  const NavigationButtom({super.key});

  @override
  Widget build(BuildContext context) {
    final NavController navController = Get.put(NavController());

    return Scaffold(
      backgroundColor: Colors.grey[100],

      body: Obx(() => navController.screens[navController.selectedIndex.value]),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(Discount());
        },
        backgroundColor: const Color(
          0xFF1976D2,
        ),
        shape: const CircleBorder(),
        child: Image.asset('assets/images/discount.png', width: 45, height: 45),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: Obx(
        () => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), // 🔹 زوايا علوية مدورة
              topRight: Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, -2), // 🔹 ظل من الأعلى
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
    );
  }

  /// 🔹 دالة مساعدة تبني الأيقونة مع ستايل خاص عند التحديد
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
              : Colors.transparent, // خلفية فاتحة عند التحديد
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Image.asset(
          iconPath,
          width: isSelected ? 35 : 28, // 🔹 الأيقونة تكبر عند التحديد
          height: isSelected ? 35 : 28,
        ),
      ),
      label: label,
    );
  }
}
