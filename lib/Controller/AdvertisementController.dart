import 'package:flutter_application_1/Service/serviceApi.dart';
import 'package:flutter_application_1/model/advertisements.dart';
import 'package:get/get.dart';

class AdvertisementController extends GetxController {
  var advertisement = <Advertisement>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchMerchants();

    super.onInit();
  }

  void fetchMerchants() async {
    try {
      isLoading(true);
      errorMessage('');
      var data = await ApiService.fetchAdvertisement();

      advertisement.assignAll(data);
      
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
