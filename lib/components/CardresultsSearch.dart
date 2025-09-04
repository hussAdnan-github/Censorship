 import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/FormReport.dart';
 
class Cardresultssearch extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback? onTap; // Optional tap handler for the card itself

  const Cardresultssearch({
    Key? key,
    required this.item,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: onTap, // Tap on the card body itself
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${item['name_day'] ?? 'لا يوجد يوم'} - ${item['name_product'] ?? 'لا يوجد منتج'}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
                textDirection: TextDirection.rtl,
              ),
              const Divider(height: 10, thickness: 1),
              _buildInfoRow(
                  'التاريخ', item['name_date_day'] ?? 'غير متوفر'),
              _buildInfoRow('الوحدة', item['name_unit'] ?? 'غير متوفر'),
              _buildPriceRow('السعر القديم', item['old_price']),
              _buildPriceRow('السعر الجديد', item['new_price']),
              if (item['note'] != null && item['note'] != '')
                _buildInfoRow('ملاحظة', item['note']),

              const SizedBox(height: 10), // Space before the button

              // The "Report" button
              Align(
                alignment: Alignment.bottomRight, // Align to right for Arabic UI
                child: ElevatedButton.icon(
                  onPressed: () {
                    print("object");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FormReport(productItem: item),
                      ),
                    );
                  },
                  icon: const Icon(Icons.report_problem_outlined, size: 20),
                  label: const Text('بلاغ'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.red, // Text and icon color
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible( // Use Flexible to prevent overflow if text is long
            child: Text(
              value ?? 'غير متوفر',
              style: const TextStyle(fontSize: 14),
              textDirection: TextDirection.rtl,
              overflow: TextOverflow.ellipsis, // Add ellipsis for long text
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, dynamic priceValue) {
    String priceText = 'غير متوفر';
    Color priceColor = Colors.black;

    if (priceValue != null) {
      if (priceValue is num) {
        priceText = priceValue.toStringAsFixed(2);
      } else {
        priceText = priceValue.toString();
      }

      if (label == 'السعر القديم') {
        priceColor = Colors.red[600]!;
      } else if (label == 'السعر الجديد') {
        priceColor = Colors.green[600]!;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            priceText,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: priceColor),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(width: 8),
          Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }
}