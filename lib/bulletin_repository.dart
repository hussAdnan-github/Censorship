import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_application_1/api_service.dart';
import 'package:flutter_application_1/db/db_helper.dart';

class BulletinRepository {
  Future<List<Map<String, dynamic>>> getBulletins() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    List<Map<String, dynamic>> bulletins = [];

    if (connectivityResult != ConnectivityResult.none) {
      // الإنترنت موجود
      bulletins = await fetchBulletinsFromAPI();
       
      // احفظ البيانات في SQLite
      await DBHelper().deleteAll();
      for (var b in bulletins) {
        await DBHelper().insertBulletin(b);
      }
      // final allData = await DBHelper().getBulletins();
      // print('عدد السجلات في الجدول: ${allData.length}');
      // print('عدد السجلات في الجدول: ${allData}');
    } else {
       

      // بدون إنترنت
      bulletins = await DBHelper().getBulletins();
    }

    return bulletins;
  }
}
