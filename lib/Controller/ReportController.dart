import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportController extends GetxController {
  // GlobalKey للتحكم في حالة الفورم والتحقق من صحته
  final GlobalKey<FormState> reportFormKey = GlobalKey<FormState>();

  // RxStrings لمراقبة قيم حقول النص والقائمة المنسدلة
  // نستخدم .obs لجعلها قابلة للمراقبة (reactive)
  final shopName = ''.obs;
  final reporterName = ''.obs; // اختياري
  final shopLocation = ''.obs;
  final selectedReportType = Rx<String?>(null); // يمكن أن تكون null في البداية

  // خيارات القائمة المنسدلة
  final List<String> reportTypes = [
    'منتج مقلد',
    'منتج منتهي الصلاحية',
    'منتج غير مرخص',
    'آخر (يرجى التحديد)',
  ];

  // دالة لتحديث قيمة اسم المحل
  void updateShopName(String value) {
    shopName.value = value;
  }

  // دالة لتحديث قيمة اسم المبلغ
  void updateReporterName(String value) {
    reporterName.value = value;
  }

  // دالة لتحديث قيمة موقع المحل
  void updateShopLocation(String value) {
    shopLocation.value = value;
  }

  // دالة لتحديث قيمة نوع البلاغ
  void updateSelectedReportType(String? value) {
    selectedReportType.value = value;
  }

  // دوال التحقق من صحة المدخلات (Validation)
  String? validateShopName(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال اسم المحل';
    }
    return null;
  }

  String? validateShopLocation(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال موقع المحل';
    }
    return null;
  }

  String? validateReportType(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء اختيار نوع البلاغ';
    }
    return null;
  }

  // دالة لإرسال البلاغ
  void submitReport() {
    if (reportFormKey.currentState!.validate()) {
      // إذا كانت جميع الحقول صالحة
      Get.snackbar(
        'جاري الإرسال',
        'جاري إرسال البلاغ...',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blueAccent,
        colorText: Colors.white,
      );

      // هنا يمكنك جمع البيانات من الـ RxValues
      print('اسم المحل: ${shopName.value}');
      print('اسم المبلغ: ${reporterName.value}');
      print('نوع البلاغ: ${selectedReportType.value ?? "لم يتم الاختيار"}');
      print('موقع المحل: ${shopLocation.value}');

      // محاكاة إرسال البيانات (يمكنك استبدالها باستدعاء API)
      Future.delayed(const Duration(seconds: 2), () {
        // بعد الإرسال، يمكنك مسح الحقول أو إظهار رسالة نجاح
        // مسح الحقول
        shopName.value = '';
        reporterName.value = '';
        shopLocation.value = '';
        selectedReportType.value = null;

        // قد تحتاج إلى إعادة ضبط حقول النص يدويًا إذا لم تكن مرتبطة بـ TextEditingController في الـ TextField
        // لكن بما أننا سنستخدم onChanged، لن نحتاج إلى TextEditingController بشكل مباشر
        // ولكننا سنقوم بتصفير الـ RxValues

        Get.snackbar(
          'نجاح',
          'تم إرسال البلاغ بنجاح!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      });
    }
  }
}