// controller/ReportController.dart
import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FormReportController extends GetxController {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final merchantController = TextEditingController();
  final contentController = TextEditingController();
  final priceController = TextEditingController();
  final productNameController = TextEditingController();
  final nameStoreController = TextEditingController();
  final locationController = TextEditingController();
  var isSubmitting = false.obs;

  var isLoadingM = false.obs;
  Timer? _debounce;

  var reportType = RxnInt();

  final formKey = GlobalKey<FormState>();
  var merchantResults = <Map<String, dynamic>>[].obs;
  final RxList<String> merchantSuggestions = <String>[].obs;
  var selectedMerchantId = RxnInt(); // id التاجر المحدد

  String? validateName(String? value) {
    if (value == null || value.isEmpty) return 'الرجاء إدخال اسم مقدم البلاغ';
    return null;
  }

  String? validatenameStore(String? value) {
    if (value == null || value.isEmpty)
      return 'الرجاء إدخال أسـم المـحل ( المسجل في الوحة )';
    return null;
  }

  String? validatelocation(String? value) {
    if (value == null || value.isEmpty) return 'مـوقع المـحل ( العنوان كاملا )';
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال رقم الهاتف';
    }

    if (!RegExp(r'^[0-9]{9}$').hasMatch(value)) {
      return 'رقم الهاتف يجب أن يكون 9 أرقام';
    }

    if (!value.startsWith('7')) {
      return 'رقم الهاتف يجب أن يبدأ بالرقم 7';
    }
    return null;
  }

  String? validateMerchant(String? value) {
    if (value == null || value.isEmpty) return 'الرجاء إدخال اسم التاجر';
    return null;
  }

  String? validateContent(String? value) {
    if (value == null || value.isEmpty) return 'الرجاء إدخال محتوى البلاغ';
    return null;
  }

  String? validatePrice(String? value) {
    if (value == null || value.isEmpty) return null; // السعر اختياري
    if (double.tryParse(value) == null) return 'الرجاء إدخال رقم صالح';
    return null;
  }

  String? validateReportType(String? value) {
    if (value == null || value.isEmpty) return 'الرجاء اختيار نوع البلاغ';
    return null;
  }

  String? validateProductName(String? value) {
    if (value == null || value.isEmpty) return 'الرجاء إدخال اسم المنتج';
    return null;
  }

  void searchMerchant(String query) async {
    if (query.isEmpty) {
      merchantSuggestions.clear();
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      return;
    }

    if (query.length <= 3) {
      merchantSuggestions.clear();
      return;
    }

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      isLoadingM.value = true;
      final url =
          'https://mclo.pythonanywhere.com/merchants/merchants/?search=$query';

      try {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonData = jsonDecode(response.body);
          final List results = jsonData['data']['results'];

          merchantResults.value = results.map<Map<String, dynamic>>((item) {
            return {
              'id': item['id'], // id التاجر
              'display':
                  "${item['name_place']} - ${item['name_merchant']}", // الاسم المعروض
            };
          }).toList();
          merchantSuggestions.value = merchantResults
              .map<String>((item) => item['display']!)
              .toList();
        } else {
          merchantSuggestions.clear();
        }
      } catch (e) {
        print('Error fetching search results: $e');
        merchantSuggestions.clear();
      } finally {
        isLoadingM.value = false;
      }
    });
  }

  void submit(Map<String, dynamic>? productItem) async {
     if (!formKey.currentState!.validate()) {
    // هنا يوقف ويرجع للمستخدم رسالة تنبيه
    Get.defaultDialog(
      title: "تنبيه",
      middleText: "الرجاء التأكد من ملء جميع الحقول المطلوبة.",
      textConfirm: "حسناً",
      confirmTextColor: Colors.white,
      onConfirm: () => Get.back(),
    );
    return;
  }
    if (formKey.currentState!.validate()) {
      final reportData = {
        'name': nameController.text,
        'phone': phoneController.text,
        'type': reportType.value,
        'name_merchant': nameStoreController.text,
        'place_merchant': locationController.text,
        'content': contentController.text,
        "price": priceController.text.isEmpty
            ? null
            : double.tryParse(priceController.text),
        'merchant': null, // selectedMerchantId.value,  الأسم التجاري
        'product': productItem?['id'],
      };
      print(reportData);
      try {
        isSubmitting.value = true;

        final response = await http.post(
          Uri.parse("https://mclo.pythonanywhere.com/reports/reports/"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reportData),
        );

        if (response.statusCode == 201 || response.statusCode == 200) {
          nameController.clear();
          phoneController.clear();
          merchantController.clear();
          contentController.clear();
          priceController.clear();
          productNameController.clear();
          nameStoreController.clear();
          locationController.clear();
          reportType.value = null;
          selectedMerchantId.value = null;
          Get.snackbar(
            'شكرا لتعاونكم',
            'تم إرسال البلاغ بنجاح!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          );
          Future.delayed(const Duration(seconds: 4), () {
            Get.offNamed('/home');
          });
        } else {
          final errorData = jsonDecode(response.body);

          Get.snackbar(
            'خطأ',
            'فشل في إرسال ${errorData['errors']['merchant']}.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } catch (e) {
        print("خطأ أثناء الاتصال: $e");
        Get.snackbar(
          'خطأ',
          'حدث خطأ في الاتصال بالسيرفر.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isSubmitting.value = false;
      }
    }
  }
}
