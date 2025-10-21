import 'package:flutter/material.dart';

class AddCounter extends StatefulWidget {
  const AddCounter({super.key});

  @override
  State<AddCounter> createState() => _AddCounterState();
}

class _AddCounterState extends State<AddCounter> {
  final TextEditingController tasbihtitle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ضيف الاذكار"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: tasbihtitle,
              decoration: const InputDecoration(
                labelText: "ضيف الذكر",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                final title = tasbihtitle.text.trim();
                if (title.isNotEmpty) {
                  // بيرجع الاسم فقط، من غير اللون
                  Navigator.pop(context, title);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("ضيف الذكر المطلوب")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(
                    horizontal: 50, vertical: 15),
              ),
              child: const Text(
                "اضافة",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}