import 'package:flutter/material.dart';

class Featurecard extends StatelessWidget {
  final IconData icon; // نوع المدخل: IconData للأيقونة
  final String title; // نوع المدخل: String للعنوان
  final String description; // نوع المدخل: String للوصف
  final Color color; // نوع المدخل: Color للون خلفية البطاقة
  final Color iconColor; // نوع المدخل: Color للون الأيقونة

  const Featurecard({super.key, required this.icon, required this.title, required this.description, required this.color, required this.iconColor });

  @override
  Widget build(BuildContext context) {
    return    
    Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      color: color,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: iconColor.withOpacity(0.2),
              child: Icon(icon, size: 35, color: iconColor),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  
  ;
  }
}