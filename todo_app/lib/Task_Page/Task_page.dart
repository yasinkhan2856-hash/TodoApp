import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/Task_Page/taskpagelist.dart';
import 'package:todo_app/utils/libs.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  var taskController = TextEditingController();
  var desController = TextEditingController();

  String date = "";
  String time = "";
  String searchQuery = "";

  List<Map<String, String>> tasks = [];

  Future<void> salectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        date = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> salectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        time = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff05243E),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Gap(100),
            Row(
              children: [
                Container(
                  width: 250,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Color(0xff102D53),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value.trim();
                      });
                      },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      hintText: "Search by task title",
                      hintStyle: TextStyle(color: Colors.white70),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
                Gap(10),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Color(0xff102D53),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.sort, color: Colors.white),
                      Gap(5),
                      Text("Sort by", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                )
              ],
            ),
            Gap(20),
            Text(
              "Tasks list",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Gap(10),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('tasks')
                  .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .orderBy('isPinned', descending: true)
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      "No tasks found",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
                final docs = snapshot.data!.docs;
                final filteredDocs = docs.where((doc) {
                  final title = (doc['title'] ?? '').toString().toLowerCase();
                  return title.contains(searchQuery);
                }).toList();
                return Expanded(
                  child: ListView.builder(
                    itemCount: filteredDocs.length,
                    itemBuilder: (context, index) {
                      final task = filteredDocs[index].data();
                      final Map<String, String> taskString = task.map(
                            (key, value) => MapEntry(key, value.toString()),
                      );
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${taskString['title'] ?? ''} ${(task['isPinned'] ?? false) ? '📌' : ''}",
                                style: TextStyle(color: Colors.black, fontSize: 18),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Text("📅 ${taskString['date']}", style: TextStyle(color: Colors.black)),
                                  SizedBox(width: 10),
                                  Text("⏰ ${taskString['time']}", style: TextStyle(color: Colors.black)),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Taskpagelist(
                                            task: taskString,
                                            docId: docs[index].id,
                                            label: "Done",
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.arrow_forward, size: 30, color: Colors.blue),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      final currentPinned = task['isPinned'] ?? false;
                                      await FirebaseFirestore.instance
                                          .collection('tasks')
                                          .doc(filteredDocs[index].id)
                                          .update({'isPinned': !currentPinned});
                                    },
                                    icon: Icon(
                                      (task['isPinned'] ?? false)
                                          ? Icons.push_pin
                                          : Icons.push_pin_outlined,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff63D9F3),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  top: 30,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: taskController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.check_box, color: Colors.white),
                          hintText: 'Task',
                          hintStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Color(0xff0F2C4A),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      Gap(10),
                      TextField(
                        controller: desController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: 'Description',
                          hintStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Color(0xff0F2C4A),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      Gap(10),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: Color(0xff0A2E5E),
                              ),
                              icon: Icon(Icons.calendar_month),
                              onPressed: () => salectDate(context),
                              label: Text("Date", style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          Gap(20),
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: Color(0xff0A2E5E),
                              ),
                              icon: Icon(Icons.access_time),
                              onPressed: () => salectTime(context),
                              label: Text("Time", style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                      Gap(20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff63D9F3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        ),
                        onPressed: () async {
                          final title = taskController.text.trim();
                          final description = desController.text.trim();
                          if (title.isNotEmpty &&
                              description.isNotEmpty &&
                              date.isNotEmpty &&
                              time.isNotEmpty) {
                            await FirebaseFirestore.instance.collection('tasks').add({
                              'title': title,
                              'description': description,
                              'date': date,
                              'time': time,
                              'status': 'incomplete',
                              'uid': FirebaseAuth.instance.currentUser!.uid,
                              'createdAt': Timestamp.now(),
                              'isPinned': false,
                            });

                            setState(() {
                              tasks.add({
                                'title': title,
                                'description': description,
                                'date': date,
                                'time': time,
                              });
                            });

                            Navigator.pop(context);
                            taskController.clear();
                            desController.clear();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Please fill all fields"),
                              backgroundColor: Colors.red,
                            ));
                          }
                        },
                        child: Text("Create", style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
