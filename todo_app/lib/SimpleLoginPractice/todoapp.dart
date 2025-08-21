import 'package:flutter/material.dart';
class SimpleLogin extends StatefulWidget {
  const SimpleLogin({super.key});

  @override
  State<SimpleLogin> createState() => _SimpleLoginState();
}

class _SimpleLoginState extends State<SimpleLogin> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Email
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty || !value.contains('@')) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Email",
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Password
                TextFormField(
                  controller: passController,
                  obscureText: obscurePassword,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Password",
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Gap(20),

                // Login Button
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Login logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Logging in...")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: const Text("Login", style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}









































// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
//
//
//
//
// class Login extends StatefulWidget {
//   const Login({
//     super.key,
//   });
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//
//   bool obscurePassword = true;
//   final formKey = GlobalKey<FormState>();
//   final TextEditingController passController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xff05243E),
//       body: SingleChildScrollView(
//         child: Form(
//           key: formKey,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               children: [
//                 SizedBox(height: 83),
//                 Image.asset("assets/images/Checkmark.png", height: 80),
//                 SizedBox(height: 40),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text("Welcome Back to ",
//                         style: TextStyle(color: Colors.white, fontSize: 32)),
//                     Text("Do It",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 32,
//                             fontFamily: "Darumadropone")),
//                   ],
//                 ),
//                 Text("Have another productive day!",
//                     style: TextStyle(color: Colors.white, fontSize: 20)),
//                 Gap(50),
//                 // SizedBox(height: 50),
//                 // SizedBox(
//                 //   height: 70,
//                 //   width: 358,
//                 // child: TextFormField(
//                 //   decoration: InputDecoration(
//                 //     errorStyle: TextStyle(
//                 //       fontSize: 13,
//                 //     ),
//                 //     fillColor: Colors.white,
//                 //     hintText: "E-Mail",
//                 //     hintStyle: TextStyle(color: Colors.black, fontSize: 14),
//                 //     prefixIcon: Icon(Icons.email, color: Colors.black),
//                 //     border: OutlineInputBorder(
//                 //       borderRadius: BorderRadius.circular(10),
//                 //     ),
//                 //   ),
//                 //   validator: (value) {
//                 //     if (value == null || value.isEmpty) {
//                 //       return "Enter your email";
//                 //     }
//                 //     final emailRegExp =
//                 //         RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
//                 //     if (!emailRegExp.hasMatch(value)) {
//                 //       return "Enter a valid email";
//                 //     }
//                 //     return null;
//                 //   },
//                 // ),
//                 // ),
//                 CustomTextField(
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Email required";
//                       } else if (!value.contains('@')) {
//                         return "Enter valid email";
//                       }
//                       return null;
//                     },
//                     hint: "E_Mail",
//                     controller: emailController,
//                     isPassword: false,
//                     icon: Icons.email),
//                 // SizedBox(
//                 //   height: 42,
//                 //   width: 358,
//                 // child: TextFormField(
//                 //   decoration: InputDecoration(
//                 //     fillColor: Colors.white,
//                 //     hintText: "Password",
//                 //     hintStyle: TextStyle(color: Colors.black),
//                 //     prefixIcon: Icon(Icons.lock, color: Colors.black),
//                 //     border: OutlineInputBorder(
//                 //       borderRadius: BorderRadius.circular(10),
//                 //     ),
//                 //   ),
//                 // ),
//                 // ),
//                 Gap(32),
//                 CustomTextField(
//                     validator: (value) {
//                       if (value == null || value.length < 6) {
//                         return "Password must be 6+ characters";
//                       }
//                       return null;
//                     },
//                     hint: "Password",
//                     suffixIcon: IconButton(
//                       onPressed: () {
//                         setState(() {
//                           if (obscurePassword) {
//                             obscurePassword = false;
//                           } else {
//                             obscurePassword = true;
//                           }
//                         });
//                       },
//                       icon: Icon(
//                         ! obscurePassword
//                             ? Icons.visibility
//                             : Icons.visibility_off,
//                       ),
//                     ),
//                     controller: passController,
//                     isPassword: obscurePassword,
//                     icon: Icons.lock),
//                 Gap(10),
//                 // SizedBox(height: 10),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 210),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Forget Password?",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold)),
//                       Container(
//                         width: 150,
//                         height: 2,
//                         color: Colors.white,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Gap(20),
//                 // SizedBox(height: 20),
//                 ElevatedButton(onPressed: , child: Text("Login "))
//                 // ElevatedButton(
//                 //   onPressed: () async {
//                 //     if (formKey.currentState!.validate()) {
//                 //       try {
//                 //         await FirebaseAuth.instance.signInWithEmailAndPassword(
//                 //           email: emailController.text.trim(),
//                 //           password: passController.text.trim(),
//                 //         );
//                 //         showDialog(
//                 //           context: context,
//                 //           builder: (context) => AlertDialog(
//                 //             title: const Text('Success'),
//                 //             content: const Text('User Logged In Successfully'),
//                 //             actions: [
//                 //               TextButton(
//                 //                 onPressed: () {
//                 //                   Navigator.pushReplacement(
//                 //                     context,
//                 //                     MaterialPageRoute(
//                 //                         builder: (context) => MainLayout()),
//                 //                   );
//                 //                 },
//                 //                 child: const Text('OK'),
//                 //               ),
//                 //             ],
//                 //           ),
//                 //         );
//                 //       } on FirebaseAuthException catch (e) {
//                 //         String errorMessage;
//                 //         if (e.code == 'network-request-failed') {
//                 //           errorMessage =
//                 //           'No internet connection. Please check your network.';
//                 //         } else if (e.code == 'invalid-email') {
//                 //           errorMessage = 'Please enter a valid email address.';
//                 //         } else if (e.code == 'user-not-found') {
//                 //           errorMessage = 'No account found with this email.';
//                 //         } else if (e.code == 'wrong-password') {
//                 //           errorMessage =
//                 //           'Incorrect password. Please try again.';
//                 //         } else {
//                 //           errorMessage = e.message ??
//                 //               'Something went wrong. Please try again.';
//                 //         }
//                 //         showDialog(
//                 //           context: context,
//                 //           builder: (context) => AlertDialog(
//                 //             title: const Text('Error'),
//                 //             content: Text(errorMessage),
//                 //             actions: [
//                 //               TextButton(
//                 //                 onPressed: () => Navigator.pop(context),
//                 //                 child: const Text('OK'),
//                 //               ),
//                 //             ],
//                 //           ),
//                 //         );
//                 //       }
//                 //     }
//                 //   },
//                 //   child: const Text("Sign In"),
//                 // ),
//                 // ElevatedButton(
//                 //   onPressed: ()  async {
//                 //      {
//                 //       if (formKey.currentState!.validate()) {
//                 //         final email = emailController.text.trim();
//                 //         final password = passController.text.trim();
//                 //
//                 //         try {
//                 //           // Try signing in
//                 //           await FirebaseAuth.instance.signInWithEmailAndPassword(
//                 //             email: emailController.text.trim(),
//                 //             password: passController.text.trim(),
//                 //           );
//                 //
//                 //           // Agar login ho gaya
//                 //           Navigator.push(
//                 //             context,
//                 //             MaterialPageRoute(builder:(context) => HomePage()),
//                 //           );
//                 //         } on FirebaseAuthException catch (e) {
//                 //           // Agar login fail ho jaye, to sign up try karo
//                 //           if (e.code == 'user-not-found') {
//                 //             try {
//                 //               await FirebaseAuth.instance.createUserWithEmailAndPassword(
//                 //                 email: email,
//                 //                 password: password,
//                 //               );
//                 //
//                 //               // Sign up success
//                 //               Navigator.push(
//                 //                 context,
//                 //                 MaterialPageRoute(builder: (context) => HomePage()),
//                 //               );
//                 //             } on FirebaseAuthException catch (signUpError) {
//                 //               ScaffoldMessenger.of(context).showSnackBar(
//                 //                 SnackBar(content: Text(signUpError.message ?? 'Sign up failed')),
//                 //               );
//                 //             }
//                 //           } else {
//                 //             ScaffoldMessenger.of(context).showSnackBar(
//                 //               SnackBar(content: Text(e.message ?? 'Login failed')),
//                 //             );
//                 //           }
//                 //         }
//                 //       }
//                 //     };
//                 //
//                 //   },
//                 //   style: ElevatedButton.styleFrom(
//                 //     backgroundColor: Color(0xff0EA5E9),
//                 //     minimumSize: Size(358, 42),
//                 //     shape: RoundedRectangleBorder(
//                 //       borderRadius: BorderRadius.circular(10),
//                 //     ),
//                 //   ),
//                 //   child: Text(
//                 //     "Sign In",
//                 //     style: TextStyle(
//                 //       color: Colors.white,
//                 //       fontWeight: FontWeight.bold,
//                 //       fontSize: 20,
//                 //     ),
//                 //   ),
//                 // ),
//                 Gap(15),
//                 // SizedBox(height: 15),
//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.center,
//                 //   children: [
//                 //     Text("Don’t have an account?",
//                 //         style: TextStyle(color: Colors.white, fontSize: 14)),
//                 //     InkWell(
//                 //       onTap: () {
//                 //         Navigator.push(
//                 //             context,
//                 //             MaterialPageRoute(
//                 //               builder: (context) => Signup(),
//                 //             ));
//                 //       },
//                 //       child: Text("  Sign Up",
//                 //           style: TextStyle(
//                 //               color: Color(0xfff0EA5E9), fontSize: 14)),
//                 //     ),
//                 //   ],
//                 // ),
//                 Gap(100),
//                 // SizedBox(height: 100),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text("Sign In With: ",
//                         style: TextStyle(color: Colors.white, fontSize: 20)),
//                     SizedBox(width: 10),
//                     Container(
//                       height: 70,
//                       width: 70,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10)),
//                       child: Image.asset("assets/images/macdone.png"),
//                     ),
//                     SizedBox(width: 10),
//                     // GestureDetector(
//                     //   onTap: () async{
//                     //     await sigIn();
//                     //   },
//                     //   child: Container(
//                     //     height: 70,
//                     //     width: 70,
//                     //     decoration: BoxDecoration(
//                     //         color: Colors.white,
//                     //         borderRadius: BorderRadius.circular(10)),
//                     //     child: Padding(
//                     //       padding: const EdgeInsets.all(10),
//                     //       child: Image.asset(
//                     //         "assets/images/google.jpeg",
//                     //         fit: BoxFit.contain,
//                     //       ),
//                     //     ),
//                     //   ),
//                     // ),
//                   ],
//                 )
//                 // SizedBox(height: 30),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
