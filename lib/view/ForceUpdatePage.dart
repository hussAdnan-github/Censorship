import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ForceUpdatePage extends StatelessWidget {
  final String updateUrl;

  const ForceUpdatePage({super.key, required this.updateUrl});

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse(updateUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'لا يمكن فتح الرابط $updateUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.system_update, size: 100, color: Colors.blue),
              const SizedBox(height: 20),
              const Text(
                "يوجد تحديث جديد للتطبيق",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                "الرجاء تحديث التطبيق للاستمرار في استخدامه.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _launchUrl,
                child: const Text("تحديث الآن" , style: TextStyle(color: Colors.blue),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
