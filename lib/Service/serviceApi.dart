import 'dart:convert';
import 'package:flutter_application_1/Controller/GenericPaginationController.dart';

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

  // static Future<List<Bulletins>> fetchBulletins() async {
  //   final response = await http.get(Uri.parse(ApiEndpoints.bulletins));
  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> jsonData = jsonDecode(response.body);
  //     final List results = jsonData['data']['results'];

  //     return results.map((e) => Bulletins.fromJson(e)).toList();
  //   } else {
  //     throw Exception("فشل في جلب البيانات");
  //   }
  // }

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

  static Future<List<Offers>> fetchOffers() async {
    final response = await http.get(Uri.parse(ApiEndpoints.offers));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final List results = jsonData['data']['results'];
      print(results.map((e) => Offers.fromJson(e)).toList());

      return results.map((e) => Offers.fromJson(e)).toList();
    } else {
      throw Exception("فشل في جلب البيانات");
    }
  }

  static Future<PaginatedResponseGeneric<Bulletins>> fetchBulletins({
    int? page,
  }) async {
    final finalUrl = page == null
        ? ApiEndpoints.bulletins
        : '${ApiEndpoints.bulletins}?page=$page';

    final response = await http.get(Uri.parse(finalUrl));

    if (response.statusCode == 200) {
      final decodedBody = json.decode(utf8.decode(response.bodyBytes));
      final data = decodedBody['data'];

      final List results = data['results'];
      final List<Bulletins> bulletinsList = results
          .map((item) => Bulletins.fromJson(item))
          .toList();

      final int? nextPage = data['next'];

      return PaginatedResponseGeneric<Bulletins>(
        items: bulletinsList,
        nextPage: nextPage,
      );
    } else {
      throw Exception('Failed to load bulletins');
    }
  }

  static Future<PaginatedResponseGeneric<Merchant>> fetchMerchants({
    int? page,
  }) async {
    final finalUrl = page == null
        ? ApiEndpoints.merchant
        : '${ApiEndpoints.merchant}?page=$page';
    final response = await http.get(Uri.parse(finalUrl));

    if (response.statusCode == 200) {
      final decodedBody = json.decode(utf8.decode(response.bodyBytes));
      final data = decodedBody['data'];

      final List results = data['results'];
      final List<Merchant> merchantsList = results
          .map((item) => Merchant.fromJson(item))
          .toList();

      final int? nextPage = data['next'];
      return PaginatedResponseGeneric<Merchant>(
        items: merchantsList,
        nextPage: nextPage,
      );
    } else {
      throw Exception('Failed to load merchants');
    }
  }
}
