//  import 'package:flutter_application_1/Service/serviceApi.dart';
// import 'package:flutter_application_1/model/Bulletins.dart';
//  import 'package:get/get.dart';

// class BulletinsController extends GetxController {
//   var bulletins = <Bulletins>[].obs;
//   var isLoading = true.obs;
//   var errorMessage = ''.obs;

//   @override
//   void onInit() {
//     fetchBulletins();

//     super.onInit(); 
//   }

//   void fetchBulletins() async {
//     try {
//       isLoading(true);
//       errorMessage('');
//       var data = await ApiService.fetchBulletins();

//       bulletins.assignAll(data);
//     } catch (e) {
//       errorMessage(e.toString());
//     } finally {
//       isLoading(false);
//     }
//   }
// }
