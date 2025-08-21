import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'CustomTextField.dart';
import 'Login.dart';



class Signup extends StatefulWidget {
  const Signup({super.key});
  @override
  State<Signup> createState() => _SignupState();
}
class _SignupState extends State<Signup> {
  final TextEditingController emailController = TextEditingController();
  var  nameController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xff1253AA), Color(0xff05243E)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Gap(85),
                // SizedBox(
                //   height: 83,
                // ),
                Image(
                  image: AssetImage(
                    "assets/images/Checkmark.png",
                  ),
                  height: 80,
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome Back to ",
                      style: TextStyle(
                          color: Colors.white,
                          // fontFamily: "Darumadropone",
                          fontSize: 32),
                    ),
                    Text(
                      "Do It",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Darumadropone",
                          fontSize: 32),
                    ),
                  ],
                ),
                Text(
                  "create an account and Join us now!",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Gap(50),
                // SizedBox(
                //   height: 50,
                // ),
                CustomTextField(
                    controller: nameController,
                    icon: Icons.person,
                    hint: "User Name",
                    isPassword: false,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Name is required";
                      } else if (value.length < 2) {
                        return "Enter a valid name";
                      }
                      return null;
                    }),
                Gap(32),
                CustomTextField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your Email';
                    }
                    if (value != emailController.text) {
                      return 'Email do not match';
                    }
                    return null;
                  },
                  icon: Icons.email,
                  hint: "Email",
                  isPassword: false,
                ),
                Gap(32),
                CustomTextField(
                  controller: passController,
                  icon: Icons.lock,
                  hint: "Password",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != passController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  isPassword: false,
                ),
                Gap(25),
                // SizedBox(
                //   height: 25,
                // ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff0EA5E9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(358, 42),
                  ),
                  onPressed: () async {
                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: emailController.text.trim(),
                        password: passController.text.trim(),
                      );
                      await FirebaseAuth.instance.currentUser!
                          .updateDisplayName(nameController.text.trim());
                      User? user = credential.user;
                      if (user != null) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            title: Row(
                              children: [
                                Icon(Icons.verified, color: Colors.green),
                                SizedBox(width: 10),
                                Text("Account Created"),
                              ],
                            ),
                            content: Text(
                              "${user.email} is Verified",
                              style: TextStyle(fontSize: 16),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close dialog
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login(
                                        )),
                                  );
                                },
                                child: Text("OK"),
                              ),
                            ],
                          ),
                        );
                      }
                    } on FirebaseAuthException catch (e) {
                      String message;

                      if (e.code == 'user-not-found') {
                        message = "No user found for that email.";
                      } else if (e.code == 'wrong-password') {
                        message = "Incorrect password.";
                      } else if (e.code == 'invalid-email') {
                        message = "Email format is invalid.";
                      } else if (e.code == 'too-many-requests') {
                        message = "Too many attempts. Please try again later.";
                      } else if (e.code == 'user-disabled') {
                        message = "User account has been disabled.";
                      } else {
                        message = "Error: ${e.message}";
                      }
                    }
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ));
                      },
                      child: Text(
                        "  Sign In",
                        style:
                            TextStyle(color: Color(0xfff0EA5E9), fontSize: 14),
                      ),
                    )
                  ],
                ),
                // RichText(
                //   text: TextSpan(
                //     children: const <TextSpan>[
                //       TextSpan(text: 'Already have an account? '),
                //       TextSpan(
                //           text: 'Sign In',
                //           style: TextStyle(
                //               fontWeight: FontWeight.bold, color: Colors.blue)),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 50,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sign In With: ",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Image.asset("assets/images/macdone.png"),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          "assets/images/google.jpeg",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
