import 'package:flutter/material.dart';

class DiscountCard extends StatelessWidget {
  final String imageUrl;
  final String storeName;
  final String location;
  final String description;
  final int discountPercent;
  final String date;
  final String oldPrice;
  final String newPrice;
  final VoidCallback? onTap;

  const DiscountCard({
    super.key,
    required this.imageUrl,
    required this.storeName,
    required this.location,
    required this.description,
    required this.discountPercent,
    required this.date,
    required this.oldPrice,
    required this.newPrice,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      elevation: 4,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: theme.cardColor,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // صورة مع شارة الخصم
                Stack(
                  children: [
                    imageUrl == null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'assets/images/shope.png',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              imageUrl.toString(),
                              width: double.infinity,
                              height: 160,
                              fit: BoxFit.cover,
                            ),
                          ),

                    // شارة الخصم
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '$discountPercent%',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.15),
                              Colors.black.withOpacity(0.35),
                            ],
                            stops: const [0.5, 0.8, 1],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // المحتوى النصي
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // اسم المحل
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            storeName,
                            maxLines: 1,

                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Colors.blue
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  location,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.textTheme.bodyMedium?.color
                                        ?.withOpacity(0.75),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(Icons.location_on_outlined, size: 18 ,color: Colors.blue),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  date.substring(0, 10),
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.textTheme.bodyMedium?.color
                                        ?.withOpacity(0.75),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.date_range, size: 18 , color: Colors.blue),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      // الوصف
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            description,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // السعر القديم والجديد
                          Row(
                            children: [
                              Text(
                                "${oldPrice} ",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                "السعر السابق ",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color:  Colors.blue,
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Text(
                                "${newPrice}",
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "سعر العرض ",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color:   Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class DiscountCard extends StatelessWidget {
//   final String imageUrl;
//   final String storeName;
//   final String location;
//   final String description;
//   final int discountPercent;
//   final String date;
//   final String oldPrice;
//   final String newPrice;
//   final VoidCallback? onTap;

//   const DiscountCard({
//     super.key,
//     required this.imageUrl,
//     required this.storeName,
//     required this.location,
//     required this.description,
//     required this.discountPercent,
//     required this.date,
//     required this.oldPrice,
//     required this.newPrice,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 8,
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       clipBehavior: Clip.antiAlias, // لضمان قص الصورة بشكل صحيح
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // قسم الصورة وشارة الخصم
//             _buildImageSection(context),
//             // قسم المحتوى النصي والتفاصيل
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end, // محاذاة لليمين
//                 children: [
//                   Text(
//                     storeName,
//                     style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blue.shade800,
//                         ),
//                     textDirection: TextDirection.rtl,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 8),
//                   // قسم الموقع والتاريخ
//                   _buildInfoSection(context),
//                   const SizedBox(height: 12),
//                   // قسم الوصف
//                   Text(
//                     description,
//                     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                           color: Colors.grey.shade700,
//                         ),
//                     textDirection: TextDirection.rtl,
//                     maxLines: 3,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 16),
//                   // قسم الأسعار
//                   _buildPriceSection(context),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildImageSection(BuildContext context) {
//     return Stack(
//       alignment: Alignment.bottomCenter,
//       children: [
//         // الصورة
//         SizedBox(
//           height: 180,
//           width: double.infinity,
//           child: imageUrl.isEmpty
//               ? Image.asset('assets/images/shope.png', fit: BoxFit.cover)
//               : Image.network(
//                   imageUrl,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) {
//                     return Image.asset('assets/images/shope.png',
//                         fit: BoxFit.cover);
//                   },
//                 ),
//         ),
//         // التدرج اللوني فوق الصورة
//         Container(
//           height: 180,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Colors.black.withOpacity(0.0),
//                 Colors.black.withOpacity(0.5),
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//         ),
//         // شارة الخصم
//         Positioned(
//           top: 16,
//           right: 16,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//             decoration: BoxDecoration(
//               color: Colors.green.shade600,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Text(
//               '$discountPercent%',
//               style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildInfoSection(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Text(
//               location,
//               style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                     color: Colors.grey.shade600,
//                   ),
//               textDirection: TextDirection.rtl,
//               overflow: TextOverflow.ellipsis,
//             ),
//             const SizedBox(width: 4),
//             Icon(Icons.location_on, color: Colors.blue.shade400, size: 18),
//           ],
//         ),
//         const SizedBox(width: 20),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Text(
//               date,
//               style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                     color: Colors.grey.shade600,
//                   ),
//               textDirection: TextDirection.rtl,
//             ),
//             const SizedBox(width: 4),
//             Icon(Icons.date_range, color: Colors.blue.shade400, size: 18),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildPriceSection(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       textDirection: TextDirection.rtl,
//       children: [
//         // السعر الجديد
//         Row(
//           children: [
//             Text(
//               newPrice,
//               style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                     color: Colors.green.shade700,
//                     fontWeight: FontWeight.bold,
//                   ),
//               textDirection: TextDirection.rtl,
//             ),
//             const SizedBox(width: 4),
//             Text(
//               'سعر العرض',
//               style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                     color: Colors.green.shade700,
//                   ),
//               textDirection: TextDirection.rtl,
//             ),
//           ],
//         ),
//         // السعر القديم
//         Row(
//           children: [
//             Text(
//               oldPrice,
//               style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                     color: Colors.red.shade400,
//                     decoration: TextDecoration.lineThrough,
//                     decorationColor: Colors.red.shade400,
//                     decorationThickness: 2,
//                   ),
//               textDirection: TextDirection.rtl,
//             ),
//             const SizedBox(width: 4),
//             Text(
//               'السعر السابق',
//               style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                     color: Colors.red.shade400,
//                   ),
//               textDirection: TextDirection.rtl,
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
