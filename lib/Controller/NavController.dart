import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/About.dart';
import 'package:flutter_application_1/view/Best.dart';
import 'package:flutter_application_1/view/Home.dart';

import 'package:flutter_application_1/view/review.dart';
import 'package:get/get.dart';

class NavController extends GetxController {
  var selectedIndex = 0.obs;
  var isFabPressed = false.obs;

  final List<Widget> screens = [
    Home(),
    Review(), Best(), About()];

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
