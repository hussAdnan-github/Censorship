import 'package:flutter/material.dart';
import 'package:get/get.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'من نحن',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.blue[500],
        centerTitle: true,
        elevation: 0, // إزالة الظل من الـ AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(), // للعودة للصفحة السابقة
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
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // صورة الشعار أعلى الصفحة بتصميم أفضل
                Container(
                  width: double.infinity,
                  height: 180, // زيادة ارتفاع الصورة
                  margin: EdgeInsets.only(bottom: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      25,
                    ), // زيادة انحناء الزوايا
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3), // ظل أقوى
                        blurRadius: 20,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset(
                      'assets/images/about.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                _buildSection(
                  icon: Icons.group,
                  title: 'من نحن',
                  description:
                      'نحننحننحننحننحننحننحننحننحننحننحننحننحننحننحننحننحننحننحننحننحننحننحننحننحننحننحننحننحننحننحننحننحن',
                ),
                SizedBox(height: 25),
                _buildSection(
                  icon: Icons.info_outline,
                  title: 'عنا',
                  description:
                      'عناعناعناعناعناعناعناعناعناعناعناعناعناعناعناعناعناعناعناعناعناعناعناعناعناعناعناعناعناعناعناعناعناعنا',
                ),
                SizedBox(height: 25),
                _buildSection(
                  icon: Icons.flag,
                  title: 'هدفنا',
                  description:
                      'هدفناهدفناهدفناهدفناهدفناهدفناهدفناهدفناهدفناهدفناهدفناهدفناهدفناهدفناهدفناهدفناهدفناهدفناهدفناهدفناهدفناهدف',
                ),
                SizedBox(height: 25),
                _buildQuoteSection(
                  quote:
                      'نؤمن أن النجاح يبدأ بخطوة، وأن كل فكرة عظيمة تستحق أن ترى النور. شكراً لثقتكم بنا!',
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // دالة مساعدة لبناء الأقسام المختلفة بتصميم موحد
  Widget _buildSection({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      elevation: 10, // ظل للبطاقة
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ), // انحناء زوايا البطاقة
      margin: EdgeInsets.zero,
      color: Colors.white.withOpacity(0.95), // لون البطاقة مع شفافية بسيطة
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.blue[700],
                  size: 38,
                ), // حجم أكبر للأيقونة
                SizedBox(width: 15),
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
            SizedBox(height: 12),
            Text(
              description,
              style: TextStyle(
                fontSize: 17,
                color: Colors.grey[700],
                height: 1.5,
              ), // ارتفاع السطر
            ),
          ],
        ),
      ),
    );
  }

  // دالة مساعدة لبناء قسم الاقتباس بتصميم مميز
  Widget _buildQuoteSection({required String quote}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            blurRadius: 15,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.format_quote, color: Colors.blue[700], size: 40),
          SizedBox(height: 15),
          Text(
            'كلمة',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            quote,
            style: TextStyle(
              fontSize: 18,
              fontStyle: FontStyle.italic,
              color: Colors.blue[900],
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
