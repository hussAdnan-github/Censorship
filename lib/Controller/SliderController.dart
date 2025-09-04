import 'package:get/get.dart';
import 'dart:async';

class SliderController extends GetxController {
  RxInt currentPage = 0.obs;
  final int imageCount;
  late Timer _timer;
  Function(int)? animateToPage;

  SliderController(this.imageCount);

  get length => null;

  @override
  void onInit() {
    super.onInit();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (currentPage.value == imageCount - 1) {
        if (animateToPage != null) {
          animateToPage!(0);
        }
        currentPage.value = 0;
      } else {
        currentPage.value++;
      }
    });
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
