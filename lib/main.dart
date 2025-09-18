import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/UpdateController.dart';
import 'package:flutter_application_1/view/Onboarding.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/components/NavigationButtom.dart';
import 'package:google_fonts/google_fonts.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
        final Updatecontroller updateController = Get.put(Updatecontroller());

    return GetMaterialApp(
      title: 'مكتب وزارة الصناعة و التجارة بساحل حضرموت',
      theme: ThemeData(
    // textTheme: GoogleFonts.tajawalTextTheme(), 
     textTheme: GoogleFonts.cairoTextTheme(), 

  ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/slider', 
      getPages: [
        GetPage(name: '/slider', page: () => Onboarding()),
        GetPage(name: '/home', page: () => NavigationButtom()),
      ],
    );
  }
}
