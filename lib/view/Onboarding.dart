import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/OnboardingController.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
 

class Onboarding extends StatelessWidget {
  Onboarding({super.key});

  final Onboardingcontroller controller = Get.put(Onboardingcontroller());
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.slides.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        bool hasNullImage = controller.slides.any(
          (slide) => slide['main_image'] == null,
        );
        if (hasNullImage) {
          Future.microtask(() => controller.goToHome());
          return SizedBox.shrink();
        }

        return CarouselSlider.builder(
   
          itemCount: controller.slides.length,
          itemBuilder: (context, index, realIndex) {
            final slide = controller.slides[index];

            return Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(slide['main_image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 20,
                  child: Obx(
                    () => Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${controller.seconds.value}s',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          options: CarouselOptions(
            height: double.infinity,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            scrollPhysics: NeverScrollableScrollPhysics(),
            viewportFraction: 1.0,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              controller.currentIndex.value = index;
              controller.resetTimer();

              // إذا وصلنا للـ Slide الأخير، أوقف autoPlay مباشرة وانتقل للـ home
              if (index == controller.slides.length - 1) {
           
                Future.delayed(Duration(seconds: 5), () {
                  controller.goToHome();
                });
              }
            },
          ),
        );
      }),
    );
  }
}
