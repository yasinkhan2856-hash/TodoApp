import 'package:todo_app/utils/libs.dart';
import 'CustomTextField.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  void _checkUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainLayout()),
        );
      });
    }
  }

  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<void> sigIn() async {
    try {
      final showBox = await GoogleSignIn().signIn();
      if (showBox == null) return;
      final auth = await showBox.authentication;
      final cradential = GoogleAuthProvider.credential(
        accessToken: auth.accessToken,
        idToken: auth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(cradential);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login Sucess")));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login failed : ${e.toString()}")));
    }
  }

  bool obscurePassword = true;
  final formKey = GlobalKey<FormState>();
  final TextEditingController passController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff05243E),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 83),
                Image.asset("assets/images/Checkmark.png", height: 80),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome Back to ",
                      style: TextStyle(color: Colors.white, fontSize: 32),
                    ),
                    Text(
                      "Do It",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: "Darumadropone",
                      ),
                    ),
                  ],
                ),
                Text(
                  "Have another productive day!",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Gap(50),
                // SizedBox(height: 50),
                // SizedBox(
                //   height: 70,
                //   width: 358,
                // child: TextFormField(
                //   decoration: InputDecoration(
                //     errorStyle: TextStyle(
                //       fontSize: 13,
                //     ),
                //     fillColor: Colors.white,
                //     hintText: "E-Mail",
                //     hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                //     prefixIcon: Icon(Icons.email, color: Colors.black),
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //   ),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return "Enter your email";
                //     }
                //     final emailRegExp =
                //         RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
                //     if (!emailRegExp.hasMatch(value)) {
                //       return "Enter a valid email";
                //     }
                //     return null;
                //   },
                // ),
                // ),
                CustomTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email required";
                    } else if (!value.contains('@')) {
                      return "Enter valid email";
                    }
                    return null;
                  },
                  hint: "E_Mail",
                  controller: emailController,
                  isPassword: false,
                  icon: Icons.email,
                ),
                // SizedBox(
                //   height: 42,
                //   width: 358,
                // child: TextFormField(
                //   decoration: InputDecoration(
                //     fillColor: Colors.white,
                //     hintText: "Password",
                //     hintStyle: TextStyle(color: Colors.black),
                //     prefixIcon: Icon(Icons.lock, color: Colors.black),
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //   ),
                // ),
                // ),
                Gap(32),
                CustomTextField(
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return "Password must be 6+ characters";
                    }
                    return null;
                  },
                  hint: "Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        if (obscurePassword) {
                          obscurePassword = false;
                        } else {
                          obscurePassword = true;
                        }
                      });
                    },
                    icon: Icon(
                      !obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                  controller: passController,
                  isPassword: obscurePassword,
                  icon: Icons.lock,
                ),
                Gap(10),
                // SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 210),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Forget Password?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(width: 150, height: 2, color: Colors.white),
                    ],
                  ),
                ),
                Gap(20),
                // SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passController.text.trim(),
                        );
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Success'),
                            content: const Text('User Logged In Successfully'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MainLayout(),
                                    ),
                                  );
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      } on FirebaseAuthException catch (e) {
                        String errorMessage;
                        if (e.code == 'network-request-failed') {
                          errorMessage =
                              'No internet connection. Please check your network.';
                        } else if (e.code == 'invalid-email') {
                          errorMessage = 'Please enter a valid email address.';
                        } else if (e.code == 'user-not-found') {
                          errorMessage = 'No account found with this email.';
                        } else if (e.code == 'wrong-password') {
                          errorMessage =
                              'Incorrect password. Please try again.';
                        } else {
                          errorMessage =
                              e.message ??
                              'Something went wrong. Please try again.';
                        }
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Error'),
                            content: Text(errorMessage),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  },
                  child: const Text("Sign In"),
                ),
                // ElevatedButton(
                //   onPressed: ()  async {
                //      {
                //       if (formKey.currentState!.validate()) {
                //         final email = emailController.text.trim();
                //         final password = passController.text.trim();
                //
                //         try {
                //           // Try signing in
                //           await FirebaseAuth.instance.signInWithEmailAndPassword(
                //             email: emailController.text.trim(),
                //             password: passController.text.trim(),
                //           );
                //
                //           // Agar login ho gaya
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(builder:(context) => HomePage()),
                //           );
                //         } on FirebaseAuthException catch (e) {
                //           // Agar login fail ho jaye, to sign up try karo
                //           if (e.code == 'user-not-found') {
                //             try {
                //               await FirebaseAuth.instance.createUserWithEmailAndPassword(
                //                 email: email,
                //                 password: password,
                //               );
                //
                //               // Sign up success
                //               Navigator.push(
                //                 context,
                //                 MaterialPageRoute(builder: (context) => HomePage()),
                //               );
                //             } on FirebaseAuthException catch (signUpError) {
                //               ScaffoldMessenger.of(context).showSnackBar(
                //                 SnackBar(content: Text(signUpError.message ?? 'Sign up failed')),
                //               );
                //             }
                //           } else {
                //             ScaffoldMessenger.of(context).showSnackBar(
                //               SnackBar(content: Text(e.message ?? 'Login failed')),
                //             );
                //           }
                //         }
                //       }
                //     };
                //
                //   },
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Color(0xff0EA5E9),
                //     minimumSize: Size(358, 42),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //   ),
                //   child: Text(
                //     "Sign In",
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 20,
                //     ),
                //   ),
                // ),
                Gap(15),
                // SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t have an account?",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Signup()),
                        );
                      },
                      child: Text(
                        "  Sign Up",
                        style: TextStyle(
                          color: Color(0xfff0ea5e9),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(100),
                // SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sign In With: ",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.asset(
                        fit: BoxFit.contain,
                        "assets/images/macdone.png",
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: sigIn,
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: Image.asset(
                          fit: BoxFit.contain,
                          "assets/images/google.jpeg",
                        ),
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
