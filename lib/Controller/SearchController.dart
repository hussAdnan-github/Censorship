import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBarController extends GetxController {
  // استخدام RxString لمراقبة التغييرات في النص المدخل
  final searchText = ''.obs;

  // TextEditingController العادي لربطه بالـ TextField
  late TextEditingController textEditingController;

  @override
  void onInit() {
    super.onInit();
    textEditingController = TextEditingController();
    // استمع لتغييرات الـ TextField وقم بتحديث searchText
    textEditingController.addListener(() {
      searchText.value = textEditingController.text;
    });
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }

  // دالة لمسح النص
  void clearSearch() {
    textEditingController.clear();
    searchText.value = ''; // تأكد من تحديث RxString أيضًا
  }

  // يمكنك إضافة دالة للقيام بالبحث الفعلي هنا
  void performSearch(String query) {
    print('Performing search for: $query');
    // هنا يمكنك استدعاء API أو تصفية قائمة بيانات
  }
}