import 'dart:convert';
import 'package:flutter_application_1/Service/paginated_response.dart';
import 'package:flutter_application_1/model/Bulletins.dart';
import 'package:flutter_application_1/model/Merchant.dart';
import 'package:flutter_application_1/model/Offers.dart';

import 'package:flutter_application_1/model/advertisements.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:http/http.dart' as http;
 class ApiService {

  

  // static Future<List<Merchant>> fetchMerchants() async {
  //   final response = await http.get(Uri.parse(ApiEndpoints.merchant));
  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> jsonData = jsonDecode(response.body);
  //     final List results = jsonData['data']['results'];
  //     return results.map((e) => Merchant.fromJson(e)).toList();
  //   } else {
  //     throw Exception("فشل في جلب البيانات");
  //   }
  // }

  static Future<List<Offers>> fetchOffers() async {
    final response = await http.get(Uri.parse(ApiEndpoints.offers));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final List results = jsonData['data']['results'];
      print( results.map((e) => Offers.fromJson(e)).toList());
 
      return results.map((e) => Offers.fromJson(e)).toList();
    } else {
      throw Exception("فشل في جلب البيانات");
    }
  }

  static Future<List<Bulletins>> fetchBulletins() async {
    final response = await http.get(Uri.parse(ApiEndpoints.bulletins));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final List results = jsonData['data']['results'];

      return results.map((e) => Bulletins.fromJson(e)).toList();
    } else {
      throw Exception("فشل في جلب البيانات");
    }
  }

  static Future<List<Advertisement>> fetchAdvertisement() async {
    final response = await http.get(Uri.parse(ApiEndpoints.advertisements));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      final List results = jsonData['data']['results'];

      return results.map((e) => Advertisement.fromJson(e)).toList();
    } else {
      throw Exception("فشل في جلب البيانات");
    }
  }
   static const String _baseUrl = 'https://mclo.pythonanywhere.com/tops/tops/';

  static Future<PaginatedResponse> fetchMerchants({int? page}) async {
    // إذا لم يتم توفير رقم صفحة، استخدم الصفحة الأولى
    final finalUrl = page == null ? _baseUrl : '$_baseUrl?page=$page';
    
    try {
      final response = await http.get(Uri.parse(finalUrl));

      if (response.statusCode == 200) {
        final decodedBody = json.decode(utf8.decode(response.bodyBytes));
        final data = decodedBody['data'];

        // استخراج قائمة النتائج
        final List results = data['results'];
        final List<Merchant> merchantsList = results.map((item) => Merchant.fromJson(item)).toList();

        // استخراج رقم الصفحة التالية (int أو null)
        final int? nextPage = data['next'];

        return PaginatedResponse(merchants: merchantsList, nextPage: nextPage);
      } else {
        throw Exception('Failed to load merchants. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
 




