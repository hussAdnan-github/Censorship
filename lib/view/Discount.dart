import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/OffersController.dart';
 import 'package:flutter_application_1/components/DiscountCard.dart';
import 'package:get/get.dart';

class Discount extends StatelessWidget {
  const Discount({super.key});

  @override
  Widget build(BuildContext context) {

     

    final OffersController Mrchant = Get.put(OffersController());

    return Scaffold(
      backgroundColor: Colors.blue[50],

      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'العــــروض ',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1976D2),
      ),
      
     
     
      body:
      
      
       ListView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        children: [ 
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                  255,
                  48,
                  29,
                  219,
                ).withOpacity(0.3), // خلفية فاتحة
                borderRadius: BorderRadius.circular(16), // زوايا دائرية
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // ظل خفيف
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Text(
                '🔥 عروض مميزة بانتظارك!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          const SizedBox(height: 24), // مسافة قبل الكاردات

          DiscountCard(
            imageUrl: 'assets/images/discount.png',
            storeName: 'شارعشارعشارع',
            location: 'شارعشارعشارعشارعشارع',
            description:
                'الصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوف',
            date: '20/20/2024',

            discountPercent: 30,
          ),
          SizedBox(height: 16),
          DiscountCard(
            imageUrl: 'assets/images/discount.png',
            storeName: 'شارعشارعشارع',
            location: 'شارعشارعشارعشارعشارع',
            description:
                'الصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوفالصوف',
            date: '20/20/2024',

            discountPercent: 30,
          ),
          SizedBox(height: 16),
          DiscountCard(
            imageUrl: 'assets/images/discount.png',
            storeName: 'Tech Hub',
            location: 'تعز، الحوبان',
            description:
                'عروض على الملحقات الذكية: سماعات، باور بانك، شواحن سريعة والمزيد.',

            date: '20/20/2024',
            discountPercent: 15,
          ),
        ],
      ),
    );
  }
}
