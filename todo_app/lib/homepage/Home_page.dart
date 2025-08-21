import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../Task_Page/taskpagelist.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;
  void showEditNameDialog(
    BuildContext context,
    String currentName,
    VoidCallback onNameUpdated,
  ) {
    final TextEditingController nameController = TextEditingController(
      text: currentName,
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xff05243E),
          title: Text('Edit Name', style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: nameController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Enter new name',
              hintStyle: TextStyle(color: Colors.white54),
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.white70)),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Save', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                String newName = nameController.text.trim();
                if (newName.isNotEmpty) {
                  final user = FirebaseAuth.instance.currentUser;
                  await user?.updateDisplayName(
                    newName,
                  ); //Yeh line Firebase Auth ke displayName ko update karti hai with the new name.

                  // user?. ka matlab hai agar user null na ho to hi update kare.
                  await user
                      ?.reload(); //Yeh Firebase Auth ko refresh karta hai taki updated info immediately reflect ho.
                  onNameUpdated(); //Yeh ek callback function hai jo UI ko notify karta hai ke name change ho gaya.
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff05243E),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(50),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ClipOval(
                    //
                    //   child: Image.asset(
                    //     "assets/images/1.jpg",
                    //     width: 52,
                    //     height: 50,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    ClipOval(
                      child: user?.photoURL != null
                          ? Image.network(
                              user!.photoURL!,
                              width: 52,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              "assets/images/1.jpg", // fallback if no photoURL
                              width: 52,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                    ),

                    Gap(20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              FirebaseAuth.instance.currentUser?.displayName ??
                                  "",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.white),
                              onPressed: () {
                                final currentName =
                                    FirebaseAuth
                                        .instance
                                        .currentUser
                                        ?.displayName ??
                                    "";
                                showEditNameDialog(context, currentName, () {
                                  setState(() {}); // Rebuild UI after update
                                });
                              },
                            ),
                          ],
                        ),
                        Text(
                          user?.email ?? "",
                          style: TextStyle(fontSize: 14, color: Colors.white70),
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.notifications_rounded,
                      color: Colors.white,
                      size: 40,
                    ),
                  ],
                ),
              ),
              Gap(20),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Group Task",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              Gap(20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Gap(10),
                    Container(
                      height: 150,
                      width: 280,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Design Meeting",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Tomorrow | 10:30pm",
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(height: 8),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                SimpleRoundImage(
                                  imagePath: "assets/images/1.jpg",
                                ),
                                SimpleRoundImage(
                                  imagePath: "assets/images/2.jpg",
                                ),
                                SimpleRoundImage(
                                  imagePath: "assets/images/3.jpg",
                                ),
                                SimpleRoundImage(
                                  imagePath: "assets/images/4.jpg",
                                ),
                                SimpleRoundImage(
                                  imagePath: "assets/images/5.jpg",
                                ),
                                CircleAvatar(
                                  backgroundColor: Color(0xffD9D9D9),
                                  child: Icon(Icons.add, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(20),
                    Container(
                      height: 150,
                      width: 280,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Project Meeting",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Thursday | 10:30pm",
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(height: 8),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  SimpleRoundImage(
                                    imagePath: "assets/images/17.jpg",
                                  ),
                                  SimpleRoundImage(
                                    imagePath: "assets/images/23.jpg",
                                  ),
                                  SimpleRoundImage(
                                    imagePath: "assets/images/21.jpg",
                                  ),
                                  SimpleRoundImage(
                                    imagePath: "assets/images/24.jpg",
                                  ),
                                  SimpleRoundImage(
                                    imagePath: "assets/images/25.jpg",
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Color(0xffD9D9D9),
                                    child: Icon(Icons.add, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(30),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Incomplete Tasks",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              Gap(10),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('tasks')
                    .where('status', isEqualTo: 'incomplete')
                    .where(
                      'uid',
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                    )
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        'No Incomplete Tasks',
                        style: TextStyle(color: Colors.white70, fontSize: 18),
                      ),
                    );
                  }

                  final tasks = snapshot.data!.docs;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index].data() as Map<String, dynamic>;
                      final docId = tasks[index].id;
                      final Map<String, String> taskString = task.map(
                        (key, value) => MapEntry(key, value.toString()),
                      );

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Taskpagelist(
                                  task: taskString,
                                  docId: docId,
                                  label: 'Done',
                                ),
                              ),
                            );
                          },
                          child: Box(
                            text: taskString['title'] ?? '',
                            text2: "📅 ${taskString['daate'] ?? ''}",
                            Text3: "⏰ ${taskString['time'] ?? ''}",
                            IconData: Icons.chevron_right_outlined,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "Completed Task",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("tasks")
                    .where('status', isEqualTo: 'complete')
                    .where(
                      'uid',
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                    )
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Center(
                        child: Text(
                          "No completed Tasks",
                          style: TextStyle(color: Colors.white70, fontSize: 20),
                        ),
                      ),
                    );
                  }

                  final docs = snapshot.data!.docs;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final task = docs[index].data();
                      final Map<String, String> taskString = task.map(
                        (key, value) => MapEntry(key, value.toString()),
                      );
                      return InkWell(
                        onTap: () {
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Box(
                            text: taskString['title'] ?? '',
                            text2: "📅 ${taskString['daate'] ?? ''}",
                            Text3: "⏰ ${taskString['time'] ?? ''}",
                            IconData: Icons.chevron_right_outlined,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SimpleRoundImage extends StatelessWidget {
  final String imagePath;
  final IconData? icon;
  const SimpleRoundImage({super.key, this.icon, required this.imagePath});
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: 30,
        height: 30,
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
  }
}

class Box extends StatelessWidget {
  final String text;
  final String text2;
  final String Text3;
  final dynamic IconData;

  const Box({
    super.key,
    required this.text,
    required this.text2,
    required this.IconData,
    required this.Text3,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListTile(
        title: Text(text),
        subtitle: Padding(
          padding: const EdgeInsets.fromLTRB(0, 1, 250, 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(text2), Gap(4), Text(Text3)],
          ),
        ),
      ),
    );
  }
}
