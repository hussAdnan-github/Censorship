import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> fetchBulletinsFromAPI() async {
    final url = Uri.parse(
      'https://mclo.pythonanywhere.com/bulletins/bulletins?pagination=false',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      List results = jsonData['data'];
    // print(results);
      return results
          .map(
            (e) => {
              'id': e['id'],
              'name_code': e['name_code_product'],
              'name_day': e['name_day'],
              'name_date_day': e['name_date_day'],
              'name_product': e['name_product'],
              'name_unit': e['name_unit'],
              'old_price': e['old_price'],
              'new_price': e['new_price'],
              'note': e['note'],
              'created_at': e['created_at'],
              'updated_at': e['updated_at'],
              'day': e['day'],
              'product': e['product'],
            },
          )
          .toList();
    } else {
      throw Exception('Failed to load bulletins');
    }
  }