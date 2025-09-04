// view/FormReport.dart
import 'package:flutter/material.dart';

class FormReport extends StatelessWidget {
  // You might pass data to the report form, e.g., the product item
  final Map<String, dynamic>? productItem;

  const FormReport({Key? key, this.productItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('بلاغ جديد'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'تقديم بلاغ عن: ${productItem?['name_product'] ?? 'منتج غير محدد'}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 20),
            // Here you would add your form fields
            // Example:
            const TextField(
              decoration: InputDecoration(
                labelText: 'موضوع البلاغ',
                border: OutlineInputBorder(),
              ),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 10),
            const TextField(
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'تفاصيل البلاغ',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic to submit the report
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم إرسال البلاغ بنجاح!')),
                );
                Navigator.of(context).pop(); // Go back after submitting
              },
              child: const Text('إرسال البلاغ'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50), // Make button full width
              ),
            ),
          ],
        ),
      ),
    );
  }
}