import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/SearchController.dart';
 
import 'package:get/get.dart';

class Searchbar extends StatefulWidget {
 
  final FocusNode searchFocusNode;
  const Searchbar({super.key, required this.searchFocusNode});

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
 
  @override
  Widget build(BuildContext context) {
    final SearchBarController searchController = Get.put(SearchBarController());

 
    return FractionallySizedBox(
      widthFactor: 0.8,
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
          textAlign: TextAlign.right,
          controller: searchController.textEditingController,
          focusNode: widget.searchFocusNode, // Use the passed FocusNode
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            hintText: 'ابحث عن منتج',
            hintStyle: TextStyle(color: Colors.grey[500]),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.blue[700],
              size: 28,
            ),
            suffixIcon: Obx(
              () => searchController.searchText.value.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear, color: Colors.grey[500]),
                      onPressed: () {
                        searchController.clearSearch();
                        // No need to unfocus here, Home will manage that
                      },
                    )
                  : const SizedBox.shrink(),
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