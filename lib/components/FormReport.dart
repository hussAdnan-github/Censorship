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

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text(
            'بلاغ جديد',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 2,
          backgroundColor: Colors.blue,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: ListView(
              children: [
                Text(
                  'تقديم بلاغ عن: ${productItem?['name_product'] ?? 'منتج غير محدد'}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 20),

                // اسم المنتج
                _buildTextField(
                  controller: controller.productNameController,
                  label: 'اسم المنتج',
                  icon: Icons.shopping_bag_rounded,
                  validator: controller.validateProductName,
                ),
                const SizedBox(height: 15),

                // اسم مقدم البلاغ
                _buildTextField(
                  controller: controller.nameController,
                  label: 'اسم مقدم البلاغ',
                  icon: Icons.person,
                  validator: controller.validateName,
                ),
                const SizedBox(height: 15),

                // رقم الهاتف
                _buildTextField(
                  controller: controller.phoneController,
                  label: 'رقم الهاتف',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: controller.validatePhone,
                ),
                const SizedBox(height: 15),

                // نوع البلاغ
                Obx(
                  () => Directionality(
                    textDirection: TextDirection.rtl,
                    child: DropdownButtonFormField<int>(
                      decoration: _inputDecoration(
                        label: 'نوع البلاغ',
                        icon: Icons.report,
                      ),
                      items: const [
                        DropdownMenuItem(value: 1, child: Align(
                              alignment: Alignment.centerRight,

                          child: Text('غالي'))),
                        DropdownMenuItem(value: 2, child: Align(
                              alignment: Alignment.centerRight,

                          child: Text('إعلان سعر'))),
                        DropdownMenuItem(value: 3, child: Align(
                              alignment: Alignment.centerRight,

                          child: Text('فساد'))),
                      ],
                      value: controller.reportType.value,
                      onChanged: (value) => controller.reportType.value = value,
                      validator: (value) =>
                          value == null ? 'الرجاء اختيار نوع البلاغ' : null,
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // اسم التاجر مع الاقتراحات
                // Obx(() => _merchantField()),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: controller.nameStoreController,
                  label: 'أسـم المـحل ( المسجل في الوحة )',
                  icon: Icons.store,
                  keyboardType: TextInputType.text,
                  validator: controller.validatenameStore,
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: controller.locationController,
                  label: 'مـوقع المـحل ( العنوان كاملا )',
                  icon: Icons.store,
                  keyboardType: TextInputType.text,
                  validator: controller.validatelocation,
                ),
                const SizedBox(height: 15),

                // السعر المبلغ عنه
                _buildTextField(
                  controller: controller.priceController,
                  label: 'السعر المبلغ عنه',
                  icon: Icons.attach_money,
                  keyboardType: TextInputType.number,
                  validator: controller.validatePrice,
                ),
                const SizedBox(height: 15),

                // محتوى البلاغ
                TextFormField(
                  controller: controller.contentController,
                  maxLines: 5,
                  decoration: _inputDecoration(
                    label: 'محتوى البلاغ',
                    icon: Icons.message,
                    alignTop: true,
                  ),
                  validator: controller.validateContent,
                ),
                const SizedBox(height: 25),

                // زر الإرسال
                Obx(() {
                  if (controller.isSubmitting.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ElevatedButton.icon(
                    onPressed: () => controller.submit(productItem),
                    icon: const Icon(Icons.send, size: 26, color: Colors.white),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        'إرسال البلاغ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 5,
                      shadowColor: Colors.deepPurple.withOpacity(0.4),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      decoration: _inputDecoration(label: label, icon: icon),
      validator: validator,
      keyboardType: keyboardType,
      textDirection: TextDirection.rtl,
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
    bool alignTop = false,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.blue),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(
        vertical: alignTop ? 16 : 12,
        horizontal: 16,
      ),
    );
  }

  Widget _merchantField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller.merchantController,
          enabled: false,
          decoration: InputDecoration(
            labelText: 'اسم التاجر',
            prefixIcon: const Icon(Icons.store, color: Colors.blue),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: controller.isLoadingM.value
                ? const Padding(
                    padding: EdgeInsets.all(12),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : null,
          ),
          textDirection: TextDirection.rtl,
          onChanged: controller.searchMerchant,
          validator: controller.validateMerchant,
        ),
        const SizedBox(height: 6),
        Obx(() {
          final inputText = controller.merchantController.text.trim();

          // نتحقق هل النص المكتوب يطابق أي اسم من الداتا الراجعة من الـ API
          final hasMatch = controller.merchantResults.any(
            (merchant) => merchant['name'] == inputText,
          );

          if (controller.merchantSuggestions.isEmpty &&
              inputText.isNotEmpty &&
              controller.selectedMerchantId.value == null &&
              !hasMatch) {
            return const Text(
              'لا توجد نتائج',
              style: TextStyle(color: Colors.red, fontSize: 14),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.merchantSuggestions.length,
            itemBuilder: (context, index) {
              final suggestion = controller.merchantSuggestions[index];
              final merchantId = controller.merchantResults[index]['id'];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                shadowColor: Colors.deepPurple.withOpacity(0.3),
                child: ListTile(
                  leading: const Icon(Icons.store, color: Colors.blue),
                  title: Text(
                    suggestion,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  onTap: () {
                    controller.merchantController.text = suggestion;
                    controller.selectedMerchantId.value = merchantId;
                    controller.merchantSuggestions.clear();
                  },
                ),
              );
            },
          );
        }),
      ],
    );
  }
}
