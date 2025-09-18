import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/NavController.dart';
import 'package:flutter_application_1/Controller/UpdateController.dart';
import 'package:flutter_application_1/bulletin_repository.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    final Updatecontroller updateController = Get.put(Updatecontroller());
    final navController = Get.find<NavController>();

    return Scaffold(
      appBar: AppBar(
        actions: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu, color: Colors.white, size: 34),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ],
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        backgroundColor: Colors.blue[500],
        elevation: 0,
        title: const Text(
          "مكتب وزارة الصناعة و التجارة",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_circle_left,
            color: Colors.white,
            size: 40,
          ),
          onPressed: () {
            if (navController.selectedIndex.value > 0) {
              navController.changeIndex(navController.selectedIndex.value - 1);
            }
          },
        ),
      ),

      endDrawer: Drawer(
        child: Directionality(
          textDirection: TextDirection.rtl, // اجعل المحتوى من اليمين لليسار
          child: Obx(() {
            final results = updateController.updates;
            return Column(
              children: [
                // المحتوى القابل للتمرير
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        decoration: const BoxDecoration(
                          color: Color(0xFF1976D2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(height: 16),
                            Text(
                              'مكتب وزارة الصناعة و التجارة بساحل حضرموت',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.home),
                        title: const Text('الرئيسية'),
                        onTap: () {
                          final navController = Get.find<NavController>();
                          navController.changeIndex(0);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.download),
                        title: const Text('تحميل البيانات بدون انترنت'),
                        onTap: () async {
                          Navigator.of(context).pop();
                          final repository = BulletinRepository();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('جاري تحميل البيانات...'),
                            ),
                          );
                          try {
                            final data = await repository.getBulletins();
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: 60,
                                        ),
                                        const SizedBox(height: 15),
                                        const Text(
                                          "تم الحفظ بنجاح 🎉",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          "يمكنك استخدام التطبيق حتى بدون انترنت 🌐❌",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text(
                                            "حسناً",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } catch (e) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.error_outline,
                                          color: Colors.red,
                                          size: 70,
                                        ),
                                        const SizedBox(height: 15),
                                        const Text(
                                          "حدث خطأ ❌",
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "تأكد من تشغيل الإنترنت أو أعد المحاولة لاحقاً.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text(
                                            "حسناً",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                      if (results.isNotEmpty)
                        ListTile(
                          leading: const Icon(
                            Icons.refresh,
                            color: Colors.blue,
                          ),
                          title: const Text('تحديث التطبيق'),
                          onTap: () async {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('جاري فتح الرابط...'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            final Uri url = Uri.parse(
                              updateController.appUrl.value,
                            );
                            if (!await launchUrl(
                              url,
                              mode: LaunchMode.externalApplication,
                            )) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('تعذر فتح الرابط'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                        ),
                    ],
                  ),
                ),

                // 👇 الصورة مثبتة أسفل الـ Drawer
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      10,
                    ), // 👈 هنا تحدد نصف القطر
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),

      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[500]!, Colors.blue[900]!, Colors.blue[700]!],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // الشعار
                Container(
                  width: double.infinity,
                  height: 180,
                  margin: const EdgeInsets.only(bottom: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                _buildSection(
                  icon: Icons.group,
                  title: 'من نحن',
                  description: 'مكتب وزارة الصناعة و التجارة بساحل حضرموت',
                ),
                const SizedBox(height: 25),

                _buildSection(
                  icon: Icons.info_outline,
                  title: 'عن التطبيق',
                  description:
                      'هذا التطبيق يسهل عمليات الرقابة ويتيح للمستهلك التبليغ عن المخالفات بسهولة.',
                ),
                const SizedBox(height: 25),

                _buildVisionSection(
                  vision: [
                    'بناء نظام رقابي مؤتمت يسهم في تنظيم الأسواق وضبط الأسعار وفقًا للمعايير الرسمية.',
                    'تعزيز مبدأ الشفافية وحماية المستهلك من الممارسات التجارية غير العادلة.',
                    'دعم مسيرة التحول الرقمي في وزارة التجارة والصناعة – فرع المكلا.',
                  ],
                ),
                const SizedBox(height: 25),

                _buildGoalsSection(
                  goals: [
                    'أتمتة عمليات الرقابة على الأسواق بدلاً من الاعتماد الكلي على الأساليب التقليدية.',
                    'رصد المخالفات السعرية بشكل لحظي من خلال تطبيقات ميدانية للمفتشين.',
                    'تمكين المستهلك من رفع البلاغات بسهولة عبر تطبيق أو موقع إلكتروني.',
                    'إدارة متكاملة للمخالفات ابتداءً من التبليغ وحتى إصدار القرار والغرامة.',
                    'توليد تقارير وإحصائيات دقيقة تساعد الإدارة في التخطيط واتخاذ القرارات السريعة.',
                    'تحسين كفاءة الموظفين والمفتشين عبر أدوات رقمية ذكية تسهل مهامهم.',
                  ],
                ),
                const SizedBox(height: 25),

                _buildQuoteSection(quote: ''),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // قسم نصوص عامة
  Widget _buildSection({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.white.withOpacity(0.95),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue[700], size: 38),
                const SizedBox(width: 15),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: TextStyle(
                fontSize: 17,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // قسم الرؤية
  Widget _buildVisionSection({required List<String> vision}) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.white.withOpacity(0.95),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.remove_red_eye, color: Colors.blue[700], size: 36),
                const SizedBox(width: 12),
                Text(
                  'رؤية المشروع',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            ...vision.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check_circle, color: Colors.blue[600], size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // قسم الأهداف
  Widget _buildGoalsSection({required List<String> goals}) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.white.withOpacity(0.95),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.flag, color: Colors.blue[700], size: 36),
                const SizedBox(width: 12),
                Text(
                  'أهداف المشروع',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            ...goals.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.star, color: Colors.orange[600], size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // قسم اقتباس
  Widget _buildQuoteSection({required String quote}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.format_quote, color: Colors.blue[700], size: 40),
           
          
          Image.asset('assets/images/kalima.png',width: 240, fit: BoxFit.cover),
          SizedBox(height: 12,),
          Text( 
            'مكــتب كــلمة للحلول البرمجية',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
            textAlign: TextAlign.center,
          ),
            
          SizedBox(height: 12,),
           Row(
           mainAxisAlignment: MainAxisAlignment.center,
  children: [
    const Icon(
      Icons.phone,
      color: Colors.blue,
      size: 24,
    ),
    const SizedBox(width: 8), // مسافة صغيرة بين الأيقونة والرقم
    Text(
      '779776749',
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
      textAlign: TextAlign.center,
    ),
  ],
),

          SizedBox(height: 12,),
           Row(
           mainAxisAlignment: MainAxisAlignment.center,
  children: [
    const Icon(
      Icons.web,
      color: Colors.blue,
      size: 24,
    ),
    const SizedBox(width: 8),  
    Text(
      'www.kalima-it.com',
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
      textAlign: TextAlign.center,
    ),
  ],
),

          Text(
            quote,
            style: const TextStyle(
              fontSize: 18,
              fontStyle: FontStyle.italic,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
