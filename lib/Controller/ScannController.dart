import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class ScannController extends GetxController {
  var searchText = ''.obs;
  var resultsSanner = <Map<String, dynamic>>[].obs; // تخزين النتائج
  var isLoading = false.obs; // حالة التحميل

  Future<void> performSearchFromScan(String scannedCode) async {
    searchText.value = scannedCode;
    if (scannedCode == "-1") {
      resultsSanner.clear();
      isLoading.value = false;
      return;
    }

    isLoading.value = true;

    final url = Uri.parse(
      'https://mclo.pythonanywhere.com/bulletins/bulletins/?search=$scannedCode',
    );

    try {
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
    } catch (e) {
      print("Error: $e");
      resultsSanner.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
