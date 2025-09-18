import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../db/db_helper.dart';  // تأكد من المسار الصحيح

class ScannController extends GetxController {
  var searchText = ''.obs;
  var resultsSanner = <Map<String, dynamic>>[].obs; // تخزين النتائج
  var isLoading = false.obs; // حالة التحميل

  /// التحقق من وجود إنترنت فعلي
  Future<bool> hasInternetConnection() async {
    try {
      final result = await http.get(Uri.parse('https://www.google.com'))
          .timeout(const Duration(seconds: 5));
      if (result.statusCode == 200) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<void> performSearchFromScan(String scannedCode) async {
    searchText.value = scannedCode;

    if (scannedCode == "-1") {
      resultsSanner.clear();
      isLoading.value = false;
      return;
    }

    isLoading.value = true;

    try {
      bool internetAvailable = await hasInternetConnection();

      if (internetAvailable) {
       
        // الإنترنت موجود: ابحث من API
        final url = Uri.parse(
          'https://mclo.pythonanywhere.com/bulletins/bulletins/?search=$scannedCode',
        );

        final response = await http.get(url);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);

          if (data['success'] == true &&
              data['data'] != null &&
              data['data']['results'] != null) {
            resultsSanner.value = List<Map<String, dynamic>>.from(
              data['data']['results'],
            );

            
          } else {
            resultsSanner.clear();
          }
        } else {
          resultsSanner.clear();
        }
      } else {
         // بدون إنترنت: ابحث من SQLite
        final localResults = await DBHelper().getBulletins();
        resultsSanner.value = localResults
            .where((item) => item['name_code']
                .toString()
                .toLowerCase()
                .contains(scannedCode.toLowerCase()))
            .toList();
        print("value${ resultsSanner.value}");

      }
    } catch (e) {
      print("Error: $e");
      resultsSanner.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
