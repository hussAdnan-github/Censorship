import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/BarcodeButton.dart';
import 'package:flutter_application_1/components/FeatureCard.dart';
import 'package:flutter_application_1/components/SearchBar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1976D2),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(118, 25, 118, 210),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 50.0, left: 20, right: 0, bottom: 10),
            child: Searchbar(),
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.white, size: 34),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF1976D2)),
              child: Text(
                'القائمة',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('الرئيسية'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            // يمكن إضافة عناصر أخرى هنا
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 0.0,
            left: 20,
            right: 20,
            bottom: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'مرحباً بك!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              Text(
                'ساهم في حماية المستهلك بالإبلاغ عن المخالفات.',
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
              const SizedBox(height: 10),

              Featurecard(
                icon: Icons.store_mall_directory,
                title: 'بلاغ عن محل',
                description:
                    'قدّم بلاغ عن أي محل يبيع بسعر مبالغ فيه أو منتجات مخالفة.',
                color: Colors.orange.shade100,
                iconColor: Colors.orange.shade700,
              ),
              const SizedBox(height: 10),

              Featurecard(
                icon: Icons.warning,
                title: 'منتجات منتهية الصلاحية',
                description:
                    'أبلغ عن المنتجات المنتهية الصلاحية أو التالفة لحماية المستهلك.',
                color: Colors.red.shade100,
                iconColor: Colors.red.shade700,
              ),
              const SizedBox(height: 10),

              Featurecard(
                icon: Icons.receipt_long,
                title: 'ارتفاع غير مبرر بالأسعار',
                description:
                    'ساعدنا في مراقبة الأسعار عبر الإبلاغ عن أي زيادات غير مبررة.',
                color: Colors.green.shade100,
                iconColor: Colors.green.shade700,
              ),
              const SizedBox(height: 10),

              Featurecard(
                icon: Icons.receipt_long,
                title: 'ارتفاع غير مبرر بالأسعار',
                description:
                    'ساعدنا في مراقبة الأسعار عبر الإبلاغ عن أي زيادات غير مبررة.',
                color: const Color.fromARGB(255, 225, 200, 230),
                iconColor: const Color.fromARGB(255, 115, 56, 142),
              ),
              const SizedBox(height: 32),
              Center(
                child: ScanBarcodeButton(
                  onScanCompleted: (code) {
                    // هنا يمكنك التعامل مع الباركود الممسوح
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Scanned Code: $code")),
                    );
                  },
                ),
              ),
        
            ],
          ),
        ),
      ),
    );
  }
}
