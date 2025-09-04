import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/SearchController.dart';
import 'package:get/get.dart';
 
class Searchbar extends StatelessWidget {
  const Searchbar({super.key});

  @override
  Widget build(BuildContext context) {
   
    final SearchBarController searchController = Get.put(SearchBarController());

    return FractionallySizedBox( // <-- أضف FractionallySizedBox هنا
      widthFactor: 0.8, // سيشغل 80% من العرض المتاح لأبيه
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          controller: searchController.textEditingController,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            hintText: 'ابحث عن منتج أو خدمة...',
            hintStyle: TextStyle(color: Colors.grey[500]),
            prefixIcon: Icon(Icons.search, color: Colors.blue[700], size: 28),
            suffixIcon: Obx(() =>
                searchController.searchText.value.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: Colors.grey[500]),
                        onPressed: () {
                          searchController.clearSearch();
                        },
                      )
                    : const SizedBox.shrink()
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
          onChanged: (value) {
            searchController.performSearch(value);
          },
        ),
      ),
    );
  }
}