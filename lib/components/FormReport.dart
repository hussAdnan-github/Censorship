// view/FormReport.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/FormReportController.dart';
import 'package:get/get.dart';

class FormReport extends StatelessWidget {
  final Map<String, dynamic>? productItem;

  FormReport({Key? key, this.productItem}) : super(key: key);

  final FormReportController controller = Get.put(FormReportController());
  @override
  Widget build(BuildContext context) {
    controller.productNameController.text = productItem?['name_product'] ?? '';

    return Scaffold(
      appBar: AppBar(title: const Text('بلاغ جديد'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              Text(
                'تقديم بلاغ عن: ${productItem?['name_product'] ?? 'منتج غير محدد'}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 20),
              // حقل اسم المنتج
              TextFormField(
                controller: controller.productNameController,
                decoration: const InputDecoration(
                  labelText: 'اسم المنتج',
                  border: OutlineInputBorder(),
                ),
                textDirection: TextDirection.rtl,
                validator: controller.validateProductName,
              ),
              const SizedBox(height: 10),
              // اسم مقدم البلاغ
              TextFormField(
                controller: controller.nameController,
                decoration: const InputDecoration(
                  labelText: 'اسم مقدم البلاغ',
                  border: OutlineInputBorder(),
                ),
                textDirection: TextDirection.rtl,
                validator: controller.validateName,
              ),
              const SizedBox(height: 10),

              // رقم الهاتف
              TextFormField(
                controller: controller.phoneController,
                decoration: const InputDecoration(
                  labelText: 'رقم الهاتف',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                textDirection: TextDirection.rtl,
                validator: controller.validatePhone,
              ),
              const SizedBox(height: 10),

              // نوع البلاغ (Dropdown)
              Obx(
                () => DropdownButtonFormField<int>(
                  decoration: const InputDecoration(
                    labelText: 'نوع البلاغ',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 1, child: Text('غالي')),
                    DropdownMenuItem(value: 2, child: Text('إعلان سعر')),
                    DropdownMenuItem(value: 3, child: Text('فساد')),
                  ],
                  value: controller.reportType.value,
                  onChanged: (value) => controller.reportType.value = value,
                  validator: (value) =>
                      value == null ? 'الرجاء اختيار نوع البلاغ' : null,
                ),
              ),

              const SizedBox(height: 10),

              // حقل اسم التاجر
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: controller.merchantController,
                      decoration: InputDecoration(
                        labelText: 'اسم التاجر',
                        border: const OutlineInputBorder(),
                        suffixIcon: controller.isLoadingM.value
                            ? const Padding(
                                padding: EdgeInsets.all(12),
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              )
                            : const Icon(Icons.store),
                      ),
                      textDirection: TextDirection.rtl,
                      onChanged: controller.searchMerchant,
                      validator: controller.validateMerchant,
                    ),
                    const SizedBox(height: 4),
                    // النتائج تحت الحقل
                    if (controller.merchantSuggestions.isEmpty &&
                        controller.merchantController.text.isNotEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'لا توجد نتائج',
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.merchantSuggestions.length,
                        itemBuilder: (context, index) {
                          final suggestion =
                              controller.merchantSuggestions[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListTile(
                              leading: const Icon(
                                Icons.store,
                                color: Colors.blue,
                              ),
                              title: Text(
                                suggestion,
                                style: const TextStyle(fontSize: 16),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              onTap: () {
                                controller.merchantController.text = suggestion;
                                controller.merchantSuggestions.clear();
                              },
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // السعر المبلغ عنه
              TextFormField(
                controller: controller.priceController,
                decoration: const InputDecoration(
                  labelText: 'السعر المبلغ عنه',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                textDirection: TextDirection.rtl,
                validator: controller.validatePrice,
              ),
              const SizedBox(height: 10),

              // محتوى البلاغ
              TextFormField(
                controller: controller.contentController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'محتوى البلاغ',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                textDirection: TextDirection.rtl,
                validator: controller.validateContent,
              ),
              const SizedBox(height: 20),

              Obx(() {
  if (controller.isSubmitting.value) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
  return ElevatedButton(
    onPressed: () => controller.submit(productItem),
    style: ElevatedButton.styleFrom(
      minimumSize: const Size.fromHeight(50),
    ),
    child: const Text('إرسال البلاغ'),
  );
}),
            ],
          ),
        ),
      ),
    );
  }
}
