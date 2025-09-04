import 'package:flutter_application_1/Service/serviceApi.dart';
import 'package:flutter_application_1/model/Offers.dart';
 
import 'package:get/get.dart';

class OffersController extends GetxController {
  var offers = <Offers>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchOffers();

    super.onInit();
  }

  void fetchOffers() async {
    try {

      isLoading(true);
      errorMessage(''); 

      var data = await ApiService.fetchOffers();

      offers.assignAll(data);

    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
