//  import 'package:flutter/material.dart';
// import 'package:flutter_application_1/components/FormReport.dart';
 
// class Cardresultssearch extends StatelessWidget {
//   final Map<String, dynamic> item;
//   final VoidCallback? onTap; // Optional tap handler for the card itself

//   const Cardresultssearch({
//     Key? key,
//     required this.item,
//     this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       child: InkWell(
//         onTap: onTap, // Tap on the card body itself
//         borderRadius: BorderRadius.circular(10),
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 '${item['name_day'] ?? 'لا يوجد يوم'} - ${item['name_product'] ?? 'لا يوجد منتج'}',
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blueAccent,
//                 ),
//                 textDirection: TextDirection.rtl,
//               ),
//               const Divider(height: 10, thickness: 1),
//               _buildInfoRow(
//                   'التاريخ', item['name_date_day'] ?? 'غير متوفر'),
//               _buildInfoRow('الوحدة', item['name_unit'] ?? 'غير متوفر'),
//               _buildPriceRow('السعر القديم', item['old_price']),
//               _buildPriceRow('السعر الجديد', item['new_price']),
//               if (item['note'] != null && item['note'] != '')
//                 _buildInfoRow('ملاحظة', item['note']),

//               const SizedBox(height: 10), // Space before the button

//               // The "Report" button
//               Align(
//                 alignment: Alignment.bottomRight, // Align to right for Arabic UI
//                 child: ElevatedButton.icon(
//                   onPressed: () {
//                     print("object");
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => FormReport(productItem: item),
//                       ),
//                     );
//                   },
//                   icon: const Icon(Icons.report_problem_outlined, size: 20),
//                   label: const Text('بلاغ'),
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.white, backgroundColor: Colors.red, // Text and icon color
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoRow(String label, String? value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Flexible( // Use Flexible to prevent overflow if text is long
//             child: Text(
//               value ?? 'غير متوفر',
//               style: const TextStyle(fontSize: 14),
//               textDirection: TextDirection.rtl,
//               overflow: TextOverflow.ellipsis, // Add ellipsis for long text
//             ),
//           ),
//           const SizedBox(width: 8),
//           Text(
//             '$label:',
//             style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
//             textDirection: TextDirection.rtl,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPriceRow(String label, dynamic priceValue) {
//     String priceText = 'غير متوفر';
//     Color priceColor = Colors.black;

//     if (priceValue != null) {
//       if (priceValue is num) {
//         priceText = priceValue.toStringAsFixed(2);
//       } else {
//         priceText = priceValue.toString();
//       }

//       if (label == 'السعر القديم') {
//         priceColor = Colors.red[600]!;
//       } else if (label == 'السعر الجديد') {
//         priceColor = Colors.green[600]!;
//       }
//     }

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Text(
//             priceText,
//             style: TextStyle(
//                 fontSize: 14, fontWeight: FontWeight.bold, color: priceColor),
//             textDirection: TextDirection.rtl,
//           ),
//           const SizedBox(width: 8),
//           Text(
//             '$label:',
//             style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
//             textDirection: TextDirection.rtl,
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/FormReport.dart';

class Cardresultssearch extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback? onTap;

  const Cardresultssearch({
    Key? key,
    required this.item,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // A unique tag for the Hero animation, ensuring a smooth transition
    final heroTag = item['id'] != null ? 'item_card_${item['id']}' : 'item_card_${item['name_product']}';

    return Hero(
      tag: heroTag,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 6,
        shadowColor: Colors.blueGrey.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Section 1: Product Name and Day (Prominent at the top)
                Text(
                  item['name_product'] ?? 'لا يوجد منتج',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1976D2),
                  ),
                  textDirection: TextDirection.rtl,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(height: 4),
                Text(
                  '${item['name_day'] ?? 'لا يوجد يوم'}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                const Divider(height: 20, thickness: 1),

                // Section 2: Prices (Side-by-side for comparison)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute space
                    children: [
                      _buildPriceColumn(
                        label: 'السعر الجديد',
                        priceValue: item['new_price'],
                        color: Colors.green.shade700!,
                        isNew: true,
                      ),
                      _buildPriceColumn(
                        label: 'السعر القديم',
                        priceValue: item['old_price'],
                        color: Colors.red.shade700!,
                        isNew: false,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),

                // Section 3: General Information (Grouped together with icons)
                _buildInfoRow(
                    Icons.calendar_today, 'التاريخ', item['name_date_day'] ?? 'غير متوفر'),
                const SizedBox(height: 5),
                _buildInfoRow(
                    Icons.straighten, 'الوحدة', item['name_unit'] ?? 'غير متوفر'),
                if (item['note'] != null && item['note'] != '')
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: _buildInfoRow(Icons.notes, 'ملاحظة', item['note']),
                  ),

                const SizedBox(height: 20),

                // Section 4: The Report Button (Aligned to the bottom-left for action)
                Align(
                  alignment: Alignment.bottomLeft, // Align to left for a more dynamic look
                  child: ElevatedButton.icon(
                    onPressed: () {
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
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String? value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Text(
            value ?? 'غير متوفر',
            style: const TextStyle(fontSize: 14, color: Colors.black87),
            textDirection: TextDirection.rtl,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$label:',
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black54),
          textDirection: TextDirection.rtl,
        ),
        const SizedBox(width: 5),
        Icon(icon, size: 16, color: Colors.black45),
      ],
    );
  }

  Widget _buildPriceColumn({
    required String label,
    required dynamic priceValue,
    required Color color,
    required bool isNew,
  }) {
    String priceText = 'غير متوفر';
    if (priceValue is num) {
      priceText = priceValue.toStringAsFixed(2);
    } else if (priceValue != null) {
      priceText = priceValue.toString();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
            fontWeight: FontWeight.w600,
          ),
          textDirection: TextDirection.rtl,
        ),
        Text(
          priceText,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
            decoration: isNew ? TextDecoration.none : TextDecoration.lineThrough,
            decorationColor: Colors.red,
          ),
          textDirection: TextDirection.rtl,
        ),
      ],
    );
  }
}
