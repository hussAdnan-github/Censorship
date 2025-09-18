import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
 import '../bulletin_repository.dart';
import '../db/db_helper.dart';
import 'dart:async';

class SearchBarController extends GetxController {
  var searchText = ''.obs;
  var resultsSearch = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var isSearchFocused = false.obs;

  TextEditingController textEditingController = TextEditingController();
  Timer? _debounce;
  Future<bool> hasInternetConnection() async {
    try {
      final result = await http.get(Uri.parse('https://www.google.com'));
      if (result.statusCode == 200) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  void performSearch(String query) {
    searchText.value = query;

    if (query.isEmpty) {
      resultsSearch.clear();

      if (_debounce?.isActive ?? false) _debounce!.cancel();
      return;
    }

    if (query.length <= 2) {
      resultsSearch.clear();
      return;
    }

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      isLoading.value = true;

      bool internetAvailable = await hasInternetConnection();
 
      try {
        final url = Uri.parse(
          'https://mclo.pythonanywhere.com/bulletins/bulletins/?search=$query',
        );

        if (internetAvailable) {
          final response = await http.get(url);
          if (response.statusCode == 200) {
            final data = jsonDecode(response.body);
            if (data['success'] == true &&
                data['data'] != null &&
                data['data']['results'] != null) {
              resultsSearch.value = List<Map<String, dynamic>>.from(
                data['data']['results'],
              );
            } else {
              resultsSearch.clear();
            }
          } else {
            resultsSearch.clear();
          }
        } else {
          // بدون إنترنت: البحث داخل SQLite
          final localResults = await DBHelper().getBulletins();
          resultsSearch.value = localResults
              .where(
                (item) => item['name_product']
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()),
              )
              .toList();
        }
      } catch (e) {
        print('Error fetching search results: $e');
        resultsSearch.clear();
      } finally {
        isLoading.value = false;
      }
    });
  }

  void clearSearch() {
    textEditingController.clear();
    searchText.value = '';
    resultsSearch.clear();
    if (_debounce?.isActive ?? false) _debounce!.cancel();
  }

  @override
  void onClose() {
    _debounce?.cancel();
    textEditingController.dispose();
    super.onClose();
  }
}
