import 'package:counter_code/config/routes/routes_name.dart';
import 'package:flutter/material.dart';

class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  List<Map<String, dynamic>> tasbih = [
    {"title": "سبحان الله", "count": 0, "color": Colors.red},
    {"title": "الحمدلله", "count": 0, "color": Colors.red},
    {"title": "الله اكبر", "count": 0, "color": Colors.red},
    { "title": "سبحان الله وبحمده سبحان الله العظيم","count": 0,"color": Colors.red,},
    {"title": "استغفر الله", "count": 0, "color": Colors.red},
    {"title": "لا حول ولا قوة الا بالله", "count": 0, "color": Colors.red},
  ];
  Map<String, dynamic>? selectedZikr;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: selectedZikr == null
            ? const Text(
                "الأذكار",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )
            : Text(
                selectedZikr!["title"],
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
        backgroundColor: Colors.red,
        actions: selectedZikr == null
            ? [
                IconButton(
                  onPressed: () async {
                    final newtitle = await Navigator.pushNamed(
                      context,
                      RoutesName.add,
                    );
                    if (newtitle != null) {
                      setState(() {
                        tasbih.add({
                          "title": newtitle,
                          "count": 0,
                          "color": Colors.red,
                        });
                      });
                    }
                  },
                  icon: const Icon(Icons.add),
                ),
              ]
            : [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    showEditDialog(context, selectedZikr!);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    showDeleteDialog(context, selectedZikr!);
                  },
                ),
              ],
      ),
      body: GestureDetector(
        onTap: () {
          if (selectedZikr != null) {
            setState(() {
              selectedZikr = null;
            });
          }
        },
        child: ListView.builder(
          itemCount: tasbih.length,
          itemBuilder: (context, index) {
            final zikr = tasbih[index];
            final isSelected = selectedZikr == zikr;
            return GestureDetector(
              onLongPress: () {
                setState(() {
                  selectedZikr = zikr;
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue : zikr["color"],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          if (zikr["count"] > 0) zikr["count"]--;
                        });
                      },
                      color: Colors.grey,
                      child: const Text("-"),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            zikr["title"],
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            zikr["count"].toString(),
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          zikr["count"]++;
                        });
                      },
                      color: Colors.amberAccent,
                      child: const Text("+"),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  void showEditDialog(BuildContext context, Map<String, dynamic> zikr) {
    TextEditingController controller =
        TextEditingController(text: zikr["title"]);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('تعديل الذكر'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'العنوان الجديد'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                final index = tasbih.indexOf(zikr);
                tasbih[index]["title"] = controller.text;
                selectedZikr = null;
              });
              Navigator.pop(context);
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }
  void showDeleteDialog(BuildContext context, Map<String, dynamic> zikr) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('تأكيد الحذف'),
        content: Text("هل تريد حذف '${zikr["title"]}'؟"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                tasbih.remove(zikr);
                selectedZikr = null;
              });
              Navigator.pop(context);
            },
            child: const Text('حذف', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}