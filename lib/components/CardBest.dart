import 'dart:convert';

import 'package:flutter/material.dart';

class Cardbest extends StatelessWidget {
  final String? image;
  final String? namePlace;
  final String? nameDepartment;
  final String? nameMerchant;

  const Cardbest({
    required this.image,
    required this.namePlace,
    required this.nameDepartment,
    required this.nameMerchant,

    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(image);
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            image == null
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
                      image.toString(),
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),

            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    nameMerchant.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700],
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'القــــسم: ${nameDepartment}',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(Icons.location_on, color: Colors.blue, size: 18),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          namePlace.toString(),
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
