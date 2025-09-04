import 'package:get/get.dart';
import 'dart:async';

class SliderController extends GetxController {
  RxInt currentPage = 0.obs;
  RxInt length = 0.obs; // عدد العناصر ديناميكي
  Timer? _timer;
  Function(int)? animateToPage;

  SliderController(int initialLength) {
    length.value = initialLength;
  }

  @override
  void onInit() {
    super.onInit();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer?.cancel();
    if (length.value > 0) {
      _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
        if (currentPage.value >= length.value - 1) {
          // رجع لأول عنصر
          animateToPage?.call(0);
          currentPage.value = 0;
        } else {
          currentPage.value++;
          animateToPage?.call(currentPage.value);
        }
      });
    }
  }

  void updateLength(int newLength) {
    length.value = newLength;
    if (currentPage.value >= newLength) {
      currentPage.value = 0;
    }
    _startAutoSlide(); // أعد تشغيل التايمر مع العدد الجديد
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
