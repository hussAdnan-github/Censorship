import 'package:flutter_application_1/view/ForceUpdatePage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:package_info_plus/package_info_plus.dart';

class Updatecontroller extends GetxController {
  var updates = <dynamic>[].obs; // هنا نخزن results
  var appVersion = ''.obs;
  var appUrl = ''.obs;
 
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    fetchUpdate();
  }

  Future<void> fetchUpdate() async {
    isLoading.value = true;

    final url = Uri.parse('https://mclo.pythonanywhere.com/updates/updates/');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final List<dynamic> results = responseData['data']['results'];
        updates.assignAll(results);
        if (results.isNotEmpty) {
          appUrl.value = results[0]['urls_store_android'];

          final packageInfo = await PackageInfo.fromPlatform();
          appVersion.value = packageInfo.version;
          if (results[0]['status'] == true &&
              appVersion.value != results[0]['version_android']) {
            Get.offAll(
              () =>
                  ForceUpdatePage(updateUrl: results[0]['urls_store_android']),
            );
          }
        } else {}
      } else {
        print('فشل في تحميل التحديث: ${response.statusCode}');
      }
    } catch (e) {
      print('خطأ أثناء جلب التحديثات: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
