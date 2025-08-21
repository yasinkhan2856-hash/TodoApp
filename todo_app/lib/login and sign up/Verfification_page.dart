import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../Navigation_file/Navigation_File.dart';

class TwoVerfication extends StatefulWidget {
  const TwoVerfication({super.key});

  @override
  State<TwoVerfication> createState() => _TwoVerficationState();
}

class _TwoVerficationState extends State<TwoVerfication> {
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
      child: Column(
        children: [
          Gap(150),
          Text(
            "Varify account",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          Gap(20),
          Container(
            width: 400,
            height: 500,
            decoration: BoxDecoration(
              color: Color(0xffD9D9D9).withOpacity(0.3),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              // gradient: LinearGradient(colors: [
              //   Color(0xffD9D9D9),
              //   // Color(0xffD9D9D9).withOpacity(0.1),
              //   //  Color(0xffD9D9D9).withOpacity(0.1),
              // ],
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                  children: [
                    Gap(20),
                    Text(
                      "DO IT",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 29,
                          fontFamily: "Darumadropone"),
                    ),
                    Gap(80),
                    Text(
                      "By verifying your account, you \ndata will be secured and be \nefault you are accepting our \nterms and policies",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Gap(20),
                    TextFormField(
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                          fontSize: 13,
                          color: Colors.red,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Verification Code ",
                        hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Gap(20),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              title: Row(
                                children: [
                                  Icon(Icons.verified, color: Colors.green),
                                  SizedBox(width: 8),
                                  Text("Verified", style: TextStyle(color: Colors.black)),
                                ],
                              ),
                              content: Text(
                                "example2023@gmail.com is verified",
                                style: TextStyle(fontSize: 16, color: Colors.black),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MainLayout(),)),
                                  child: Text("OK", style: TextStyle(color: Colors.blue)),
                                )
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff0EA5E9),
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Verify",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),

                  ]),
            ),
          )
        ],
      ),
    ));
  }
}
