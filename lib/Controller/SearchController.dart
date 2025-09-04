import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class SearchBarController extends GetxController {
  var searchText = ''.obs;
  var resultsSearch = <Map<String, dynamic>>[].obs; 
   var isLoading = false.obs;  
     var isSearchFocused = false.obs;  

  TextEditingController textEditingController = TextEditingController();
  Timer? _debounce;

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
      final url = Uri.parse(
        'https://mclo.pythonanywhere.com/bulletins/bulletins/?search=$query',
      );

      try {
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