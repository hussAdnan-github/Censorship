// controller/ReportController.dart
import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FormReportController extends GetxController {
  // Controllers للنصوص
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final merchantController = TextEditingController();
  final contentController = TextEditingController();
  final priceController = TextEditingController();
  final productNameController = TextEditingController();
   var isSubmitting = false.obs; // حالة تحميل عند الإرسال

  var isLoadingM = false.obs;
  Timer? _debounce;

  // Dropdown
  var reportType = RxnInt();
  // FormKey
  final formKey = GlobalKey<FormState>();
  final RxList<String> merchantSuggestions = <String>[].obs;

  // Validation لكل حقل
  String? validateName(String? value) {
    if (value == null || value.isEmpty) return 'الرجاء إدخال اسم مقدم البلاغ';
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال رقم الهاتف';
    }
    // تحقق أن الرقم يحتوي على 9 أرقام فقط
    if (!RegExp(r'^[0-9]{9}$').hasMatch(value)) {
      return 'رقم الهاتف يجب أن يكون 9 أرقام';
    }
    // تحقق أن الرقم يبدأ بالرقم 7
    if (!value.startsWith('7')) {
      return 'رقم الهاتف يجب أن يبدأ بالرقم 7';
    }
    return null; // صالح
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

  // Validation لاسم المنتج
  String? validateProductName(String? value) {
    if (value == null || value.isEmpty) return 'الرجاء إدخال اسم المنتج';
    return null;
  }

  // البحث في API
  void searchMerchant(String query) async {
    if (query.isEmpty) {
      merchantSuggestions.clear();
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      return;
    }

    if (query.length <= 5) {
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

          print(results);
          merchantSuggestions.value = results
              .map<String>(
                (item) => "${item['name_place']} - ${item['name_merchant']}",
              )
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

  void submit(Map<String, dynamic>? productItem) async  {
    if (formKey.currentState!.validate()) {
     final reportData = {
        'name': nameController.text,
        'phone': phoneController.text,
        'type': reportType.value,
        'content': contentController.text,
        "price": priceController.text.isEmpty
            ? null
            : double.tryParse(priceController.text),
        'merchant': 1,
        'product': productItem?['id'],
      };
  try {
        isSubmitting.value = true; // بدء التحميل

        final response = await http.post(
          Uri.parse("https://mclo.pythonanywhere.com/reports/reports/"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reportData),
        );

        if (response.statusCode == 201 || response.statusCode == 200) {
          // نجاح
         Get.snackbar(
       ' reportData.name',
        'تم إرسال البلاغ بنجاح!',
        snackPosition: SnackPosition.BOTTOM,
      );
          print("===== بيانات البلاغ =====");
          print(reportData);
          print("استجابة السيرفر: ${response.body}");
          print("=========================");

          // Get.back(result: reportData);
        } else {
          // خطأ
          print("خطأ ${response.statusCode}: ${response.body}");
          Get.snackbar(
            'خطأ',
            'فشل في إرسال البلاغ. حاول مرة أخرى.',
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
        isSubmitting.value = false; // إيقاف التحميل
      }
    }

     

       
    }
  }
 


// void submit(Map<String, dynamic>? productItem)  {
 

    
      // try {
      //   isLoading.value = true;

      //   final response = await http.post(
      //     Uri.parse("https://mclo.pythonanywhere.com/reports/reports/"),
      //     headers: {"Content-Type": "application/json"},
      //     body: jsonEncode(reportData),
      //   );

      //   if (response.statusCode == 201 || response.statusCode == 200) {
      //     // نجاح
      //     Get.snackbar(
      //       'نجاح',
      //       'تم إرسال البلاغ بنجاح!',
      //       snackPosition: SnackPosition.BOTTOM,
      //       backgroundColor: Colors.green,
      //       colorText: Colors.white,
      //     );

      //     print("===== بيانات البلاغ =====");
      //     print(reportData);
      //     print("استجابة السيرفر: ${response.body}");
      //     print("=========================");

      //     Get.back(result: reportData);
      //   } else {
      //     // خطأ
      //     print("خطأ ${response.statusCode}: ${response.body}");
      //     Get.snackbar(
      //       'خطأ',
      //       'فشل في إرسال البلاغ. حاول مرة أخرى.',
      //       snackPosition: SnackPosition.BOTTOM,
      //       backgroundColor: Colors.red,
      //       colorText: Colors.white,
      //     );
      //   }
      // } catch (e) {
      //   print("خطأ أثناء الاتصال: $e");
      //   Get.snackbar(
      //     'خطأ',
      //     'حدث خطأ في الاتصال بالسيرفر.',
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: Colors.red,
      //     colorText: Colors.white,
      //   );
      // } finally {
      //   isLoading.value = false;
      // }
  //   }

  //   // العودة للشاشة السابقة
  // }