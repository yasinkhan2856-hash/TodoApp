import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Taskpagelist extends StatelessWidget {
  final String label;
  final String docId;
  final Map<String, String> task;

  const Taskpagelist({
    super.key,
    required this.task,
    required this.docId,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff05243E),
        leading: BackButton(color: Colors.white),
        title: Text("TASK PAGE", style: TextStyle(color: Colors.white)),
      ),
      backgroundColor: Color(0xff05243E),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 80, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task['title'] ?? '', style: TextStyle(color: Colors.white, fontSize: 24)),
            SizedBox(height: 10),
            Text("📅 ${task['daate'] ?? ''}", style: TextStyle(color: Colors.white, fontSize: 16)),
            Text("⏰ ${task['time'] ?? ''}", style: TextStyle(color: Colors.white, fontSize: 16)),
            SizedBox(height: 10),
            Divider(color: Colors.white),
            SizedBox(height: 10),
            Text(task['description'] ?? '', style: TextStyle(color: Colors.white, fontSize: 18)),
            Gap(40),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () async {
                    if (label == "Done") {
                      await FirebaseFirestore.instance
                          .collection('tasks')
                          .doc(docId)
                          .update({'status': 'complete'});
                      Navigator.pop(context);
                    }
                  },
                  child: actionButton("Done", Icons.check, Colors.green),
                ),
                InkWell(
                  onTap: () async {
                    await FirebaseFirestore.instance
                        .collection('tasks')
                        .doc(docId)
                        .delete();
                    Navigator.pop(context);
                  },
                  child: actionButton("Delete", Icons.delete, Colors.redAccent),
                ),
                InkWell(
                    onTap: ()  async{
                      await FirebaseFirestore.instance.collection("tasks").doc(docId).update({'isPinned': true});

                    }
                    ,child: actionButton("Pin", Icons.push_pin, Colors.yellow)),
              ],
            )
          ],
        ),
      ),
    );
  }
  Widget actionButton(String label, IconData icon, Color iconColor) {
    return Container(
      height: 60,
      width: 70,
      decoration: BoxDecoration(
        color: Color(0xff0F2C4A),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor),
          Text(label, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
