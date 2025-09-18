import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Onboardingcontroller extends GetxController {
  var slides = [].obs; // لتخزين البيانات من API
  var currentIndex = 0.obs; // لتتبع الـ index الحالي
  var seconds = 5.obs; // ثواني الـ autoPlayInterval لكل Slide
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    checkInternetAndFetch();
    startTimer();
  }

  // التحقق من الاتصال بالإنترنت
  Future<void> checkInternetAndFetch() async {
    bool connected = await hasInternetConnection();
    if (connected) {
      fetchSlides();
    } else {
      goToHome(); // الانتقال للصفحة الرئيسية مباشرة عند عدم وجود انترنت
    }
  }

  Future<bool> hasInternetConnection() async {
    try {
      final result = await http.get(Uri.parse('https://www.google.com')).timeout(Duration(seconds: 10));
      return result.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // جلب البيانات من API
  void fetchSlides() async {
    final url = Uri.parse(
        'https://mclo.pythonanywhere.com/advertisements/advertisements/?type=1');
    try {
      final response = await http.get(url).timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        slides.value = data['data']['results'];

        // إذا لم توجد slides → الانتقال للصفحة الرئيسية
        if (slides.isEmpty) {
          goToHome();
        }
      } else {
        goToHome();
      }
    } catch (e) {
      goToHome();
    }
  }

  // بدء عداد الثواني
  void startTimer() {
    _timer?.cancel();
    seconds.value = 5;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds.value > 0) {
        seconds.value--;
      }
    });
  }

  // إعادة ضبط العداد عند تغيير Slide
  void resetTimer() {
    startTimer();
  }

  // الانتقال للصفحة الرئيسية
  void goToHome() {
    _timer?.cancel();
    Get.offNamed('/home');
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
