// file: models/paginated_response.dart
import 'package:flutter_application_1/model/Merchant.dart';

class PaginatedResponse {
  final List<Merchant> merchants;
  final int? nextPage; // بدلاً من String? nextUrl

  PaginatedResponse({required this.merchants, this.nextPage});
}
