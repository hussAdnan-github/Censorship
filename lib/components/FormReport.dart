import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/ReportController.dart';
import 'package:get/get.dart';
 
class FormReport extends StatelessWidget {
  const FormReport({super.key});

  @override
  Widget build(BuildContext context) {
    
    final ReportController controller = Get.put(ReportController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('الإبلاغ عن منتج غير شرعي'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.reportFormKey, // ربط المفتاح من الـ Controller
          child: ListView(
            children: [
              // حقل اسم المحل
              TextFormField(
                initialValue: controller.shopName.value, // ربط القيمة الابتدائية بالـ Rx
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                decoration: const InputDecoration(
                  labelText: 'اسم المحل',
                  hintText: 'أدخل اسم المحل',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.store),
                ),
                onChanged: controller.updateShopName, // تحديث الـ RxString عند التغيير
                validator: controller.validateShopName, // استخدام دالة التحقق من الـ Controller
              ),
              const SizedBox(height: 16),

              // حقل اسم المبلغ (اختياري)
              TextFormField(
                initialValue: controller.reporterName.value,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                decoration: const InputDecoration(
                  labelText: 'اسم المبلغ (اختياري)',
                  hintText: 'أدخل اسمك',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                onChanged: controller.updateReporterName,
                // هذا الحقل اختياري، لذا لا يوجد validator
              ),
              const SizedBox(height: 16),

              // حقل نوع البلاغ (Dropdown)
              Obx( // استخدم Obx لمراقبة selectedReportType
                () => DropdownButtonFormField<String>(
                  value: controller.selectedReportType.value,
                  decoration: const InputDecoration(
                    labelText: 'نوع البلاغ',
                    hintText: 'اختر نوع البلاغ',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.category),
                  ),
                  items: controller.reportTypes.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: controller.updateSelectedReportType, // تحديث الـ Rx<String?>
                  validator: controller.validateReportType,
                ),
              ),
              const SizedBox(height: 16),

              // حقل موقع المحل
              TextFormField(
                initialValue: controller.shopLocation.value,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'موقع المحل',
                  hintText: 'أدخل العنوان بالتفصيل أو وصف الموقع',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_on),
                ),
                onChanged: controller.updateShopLocation,
                validator: controller.validateShopLocation,
              ),
              const SizedBox(height: 24),

              // زر إرسال البلاغ
              ElevatedButton.icon(
                onPressed: controller.submitReport, // استدعاء دالة الإرسال من الـ Controller
                icon: const Icon(Icons.send),
                label: const Text(
                  'إرسال البلاغ',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

 