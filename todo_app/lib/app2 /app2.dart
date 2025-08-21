import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model class.dart';
class App2 extends StatefulWidget {
  const App2({super.key});

  @override
  State<App2> createState() => _App2State();
}

class _App2State extends State<App2> {
  var responce = http.get(
    Uri.parse(
      "https://api.weatherapi.com/v1/forecast.json?key=861ca1b02164490da0b114427251405&q=Kohat&days=7&aqi=yes&alerts=yes",
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            responce = http.get(
              Uri.parse(
                "https://api.weatherapi.com/v1/forecast.json?key=861ca1b02164490da0b114427251405&q=Kohat&days=7&aqi=yes&alerts=yes",
              ),
            );
          });
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: FutureBuilder(
            future: responce,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(color: Colors.red));
              }
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              var data = json.decode(snapshot.data!.body);
              Weatherdata a = Weatherdata.fromJson(data);
              return DefaultTabController(
                length: 3,
                child: Stack(
                  children: [
                    Positioned(
                      child: Image.network(
                        "https://images.pexels.com/photos/13225406/pexels-photo-13225406.jpeg?auto=compress&cs=tinysrgb&w=12000",
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 60, left: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Wellcome",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "RobotoMyFont",
                                  fontSize: 20,
                                ),
                              ),
                              Spacer(),
                              CircleAvatar(
                                radius: 30,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.blue,
                                  size: 50,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 320),
                            child: Text(
                              "Yaisn Khan ",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "RobotoMyFont",
                                fontSize: 20,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.only(right: 200),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "${a.location.name}, ${a.location.country}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.only(right: 280),
                            child: Text(
                              a.location.localtime,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(right: 170, top: 15),
                                child: Image.network(
                                  "https:${a.current.condition.icon}",
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                              Text(
                                a.current.tempC.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 50),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 300),
                            child: Text(
                              "Sunny",
                              style:
                              TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          SizedBox(height: 300),
                          Container(
                            height: 250,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                              ),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xffCCCCCC),
                                  Color(0xffE7EED0),
                                  Color(0xffE7EED0),
                                ],
                              ),
                            ),
                            child: BottomSheet(
                              onClosing: () {},
                              builder: (BuildContext context) {
                                return Column(
                                  children: [
                                    Expanded(
                                      child: TabBarView(
                                        children: [
                                          Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 250,
                                                  top: 30,
                                                ),
                                                child: Text(
                                                  "Weather Now ",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 20,
                                                  top: 10,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.thermostat_auto,
                                                      size: 50,
                                                    ),
                                                    SizedBox(width: 10),
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                          "Feel Like",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              a.current.tempC
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 24,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom:
                                                                  10),
                                                              child: Text("c",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black)),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                        left: 90,
                                                      ),
                                                      child: Image(
                                                        image: AssetImage(
                                                          "assets/images/Umrella.png",
                                                        ),
                                                        width: 60,
                                                        height: 60,
                                                      ),
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          "Precipitation",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              a.current.precipMm
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                            ),
                                                            Text("%",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black)),
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Center(
                                            child: Column(
                                              children: [
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                        right: 250,
                                                        top: 30,
                                                      ),
                                                      child: Text(
                                                        "Weather Now ",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                        left: 20,
                                                        top: 10,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .thermostat_auto,
                                                            size: 50,
                                                          ),
                                                          SizedBox(width: 10),
                                                          Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text(
                                                                "Feel Like",
                                                                style:
                                                                TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 5),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    a.current
                                                                        .tempC
                                                                        .toString(),
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      15,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                        10),
                                                                    child: Text(
                                                                        "c",
                                                                        style: TextStyle(
                                                                            color:
                                                                            Colors.black)),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .only(
                                                              left: 90,
                                                            ),
                                                            child: Image(
                                                              image: AssetImage(
                                                                "assets/images/Umrella.png",
                                                              ),
                                                              width: 60,
                                                              height: 60,
                                                            ),
                                                          ),
                                                          Column(
                                                            children: [
                                                              Text(
                                                                "Precipitation",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    a.current
                                                                        .precipMm
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight.bold),
                                                                  ),
                                                                  Text("%",
                                                                      style: TextStyle(
                                                                          color:
                                                                          Colors.black)),
                                                                ],
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Center(child: Text("10  Data")),
                                        ],
                                      ),
                                    ),
                                    TabBar(
                                      labelColor: Colors
                                          .black, //Jab tab active (select) hota hai, uska text ka color.
                                      unselectedLabelColor: Colors
                                          .grey, //Jo tab select nahi hai, uska color.
                                      indicatorColor: Colors
                                          .black, //Jo tab selected hai uske neeche jo line show hoti hai, uska color.
                                      indicator: UnderlineTabIndicator(
                                        borderSide: BorderSide(
                                            width: 4.0, color: Colors.black),
                                        insets: EdgeInsets.fromLTRB(16.0, 0.0,
                                            16.0, 40.0), // shift line upward
                                      ),
                                      tabs: const [
                                        //List of Tab widgets. Har ek tab mein aap text, icon ya dono de sakte hain.
                                        Tab(text: 'Now'),
                                        Tab(text: 'Hourly'),
                                        Tab(text: '10 Days'),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                          // ElevatedButton(
                          //   child: Text("data"),
                          //   onPressed: () {
                          //     showModalBottomSheet(
                          //       context: context,
                          //       backgroundColor: Colors.transparent, // Important to see gradient
                          //       builder: (_) => Container(
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          //           gradient: LinearGradient(
                          //             colors: [Colors.purple, Colors.orange], // Multiple colors
                          //             begin: Alignment.topLeft,
                          //             end: Alignment.bottomRight,
                          //           ),
                          //         ),
                          //         padding: EdgeInsets.all(16),
                          //         child: Column(
                          //           mainAxisSize: MainAxisSize.min,
                          //           children: [
                          //             Text(
                          //               "Beautiful BottomSheet",
                          //               style: TextStyle(color: Colors.white),
                          //             ),
                          //         ListTile(
                          //                       title: Text("jkdhf"),
                          //                       subtitle: Text("zdvnb"),
                          //                     ),
                          //                     ListTile(
                          //                       title: Text("dzjv"),
                          //                       subtitle: Text("dzfb"),
                          //                     ),
                          //                     ListTile(
                          //                       title: Text("Hourly"),
                          //                       subtitle: Text("10 days"),
                          //                     ),ListTile(
                          //                       title: Text("Hourly"),
                          //                       subtitle: Text("10 days"),
                          //                     ),
                          //                     ListTile(
                          //                       title: Text("Hourly"),
                          //                       subtitle: Text("10 days"),
                          //                     ),
                          //           ],
                          //         ),
                          //       ),
                          //     );
                          //
                          //   },
                          //   // onPressed: () {
                          //     showBottomSheet(
                          //          backgroundColor: Color(0xff1C1E5E),
                          //       elevation: 0,
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(30)
                          //       ),
                          //       enableDrag: true,
                          //       context: context,
                          //       builder: (context) {
                          //         return Column(
                          //           mainAxisSize: MainAxisSize.min,
                          //           children: [
                          //             ListTile(
                          //               title: Text("Hourly"),
                          //               subtitle: Text("10 days"),
                          //             ),
                          //             ListTile(
                          //               title: Text("jkdhf"),
                          //               subtitle: Text("zdvnb"),
                          //             ),
                          //             ListTile(
                          //               title: Text("dzjv"),
                          //               subtitle: Text("dzfb"),
                          //             ),
                          //             ListTile(
                          //               title: Text("Hourly"),
                          //               subtitle: Text("10 days"),
                          //             ),ListTile(
                          //               title: Text("Hourly"),
                          //               subtitle: Text("10 days"),
                          //             ),
                          //             ListTile(
                          //               title: Text("Hourly"),
                          //               subtitle: Text("10 days"),
                          //             ),
                          //           ],
                          //         );
                          //       },
                          //     );
                          // },
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
