import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../homepage/model class.dart';


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String url =
      "https://api.weatherapi.com/v1/forecast.json?key=b028abc92fe2455dac3113350251405&q=London&days=3&aqi=yes&alerts=yes";
  int number = 0;
  late var response = http.get(Uri.parse(url));



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Center(child: Text("this Future API and one AddButton")),
          leading: Text(number.toString(),style: TextStyle(fontSize: 30),),
          actions: [
            InkWell(
              onTap: () {
                setState(() {
                  number++;
                });
              },
              child: Icon(
                Icons.add,
                size: 40,
              ),
            )
          ],
        ),
        body: FutureBuilder(
          future: response,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Text(snapshot.hasError.toString());
            }

            if (snapshot.hasData) {
              final Apidata = jsonDecode(snapshot.data!.body);
              Weather w = Weather.fromJson(Apidata);
              return Center(
                child: Column(
                  children: [

                    Text(
                      //Apidata["location"]["name"],
                      w.location!.name.toString(),
                      style: TextStyle(fontSize: 25),
                    ),

                    Row(mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Icon(Icons.sunny,color: Colors.yellow,size: 50,),
                        ),
                      ],
                    ),
                    Text(
                      //Apidata["location"]["country"],
                      w.location!.country.toString(),
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      //Apidata["current"]["temp_c"].toString(),
                      w.current!.tempC.toString(),
                      style: TextStyle(fontSize: 40),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Partly Cloudy",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Container(
                          height: 120,
                          width: 450,
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadiusDirectional.circular(10),
                              color: Colors.cyan),
                          child: Column(
                            children: [
                              Text(
                                  "Partly Cloudy. Highs 33 to 35 C and low 26 to 28 C . "),
                              Divider(
                                color: Colors.white,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 50,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: w.forecast!.forecastday[0].hour!.length,
                                      itemBuilder: (context, index) {
                                        final hourData = w.forecast!.forecastday[0].hour![index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                          child: Text("${hourData.tempC?.toStringAsFixed(1)}°C"),
                                        );
                                      },
                                    ),
                                  ),

                                  // Icon(
                                  //   Icons.cloudy_snowing,
                                  //   color: Colors.yellow,
                                  //   size: 30,
                                  // ),
                                  // SizedBox(
                                  //   width: 20,
                                  // ),
                                  // Icon(
                                  //   Icons.cloudy_snowing,
                                  //   color: Colors.yellow,
                                  //   size: 30,
                                  // ),
                                  // SizedBox(
                                  //   width: 20,
                                  // ),
                                  // Icon(
                                  //   Icons.cloudy_snowing,
                                  //   color: Colors.yellow,
                                  //   size: 30,
                                  // ),
                                  // SizedBox(
                                  //   width: 20,
                                  // ),
                                  // Icon(
                                  //   Icons.cloudy_snowing,
                                  //   color: Colors.yellow,
                                  //   size: 30,
                                  // ),
                                  // SizedBox(
                                  //   width: 20,
                                  // ),
                                  // Icon(
                                  //   Icons.cloudy_snowing,
                                  //   color: Colors.yellow,
                                  //   size: 30,
                                  // ),
                                  // SizedBox(
                                  //   width: 20,
                                  // ),
                                  // Icon(
                                  //   Icons.cloudy_snowing,
                                  //   color: Colors.yellow,
                                  //   size: 30,
                                  // ),
                                  // SizedBox(
                                  //   width: 20,
                                  // ),
                                  // Icon(
                                  //   Icons.cloudy_snowing,
                                  //   color: Colors.yellow,
                                  //   size: 30,
                                  // ),
                                  // SizedBox(
                                  //   width: 20,
                                  // ),
                                  // Icon(
                                  //   Icons.cloudy_snowing,
                                  //   color: Colors.yellow,
                                  //   size: 30,
                                  // ),
                                  // SizedBox(
                                  //   width: 20,
                                  // ),
                                  // Icon(
                                  //   Icons.cloudy_snowing,
                                  //   color: Colors.yellow,
                                  //   size: 30,
                                  // ),
                                  // SizedBox(
                                  //   width: 20,
                                  // ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("33 C"),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text("33 C"),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text("33 C"),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text("33 C"),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text("33 C"),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text("33 C"),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text("33 C"),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text("33 C"),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text("33 C"),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Column(
                          children: [
                            Center(
                              child: Container(
                                height: 150,
                                width: 450,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadiusDirectional.circular(10),
                                    color: Colors.cyan),
                                child: Column(
                                  children: [

                                    Text("Today temperature is 34 to 27 C",style: TextStyle(fontSize: 20)),
                                    SizedBox(height: 8),
                                    Icon(Icons.cloudy_snowing,color: Colors.yellow,size: 100,),


                                  ],
                                ),



                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Text("no data ");
            }
          },
        ),
      ),
    );
  }
}