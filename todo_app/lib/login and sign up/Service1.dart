import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'Login.dart';

class Todoappscreen1 extends StatefulWidget {
  const Todoappscreen1({super.key});

  @override
  State<Todoappscreen1> createState() => _Todoappscreen1State();
}

class _Todoappscreen1State extends State<Todoappscreen1> {
  final PageController pageController = PageController();
  int currentpage = 0;
  final List<Widget> screens = [
    one(),
    firstpage(),
    secondpage(),
    thirdpage(),
    fourth(),
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff05243E),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: screens.length,
              onPageChanged: (index) {
                setState(() {
                  currentpage = index;
                });
              },
              itemBuilder: (context, index) {
                return screens[index];
              },
            ),
          ),
          currentpage == 0
              ? SizedBox.shrink()
              : SizedBox(
            height: height * 0.15,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: pageController,
                    count: screens.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.white54,
                      //activeDotColor: Colors.white,
                      dotHeight: 7,
                      dotWidth: 20,
                      spacing: 8,
                      expansionFactor: 3,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(

                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: height * 0.05,
                      backgroundColor: Colors.white,
                      child: Icon(
                        currentpage == screens.length - 1
                            ? Icons.check
                            : Icons.arrow_forward,
                        size: height * 0.05,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class one extends StatelessWidget {
  const one({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      color: Color(0xff05243E),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.1,
          vertical: height * 0.15,
        ),
        child: Column(
          children: [
            Image(
              image: AssetImage("assets/images/Checkmark.png"),
              height: height * 0.1,
            ),
            SizedBox(height: height * 0.1),
            Text(
              "DO IT",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Darumadropone",
                fontSize: height * 0.065,
              ),
            ),
            SizedBox(height: height * 0.05),
            Text(
              "v 1.0.0",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: height * 0.03,
              ),
            ),
          ],
        ),
      ),

    );
  }
}

class firstpage extends StatelessWidget {
  const firstpage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Container(
      color: Color(0xff05243E),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage("assets/images/firstpicdone.png")),
          SizedBox(height: height * 0.05),
          Text(
            "Plan your tasks to do, that \n way you’ll stay organized \n and you won’t skip any",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: height * 0.025,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class secondpage extends StatelessWidget {
  const secondpage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Container(
      color: Color(0xff05243E),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage("assets/images/secondpicdone.png"),
            width: height * 0.35,
            height: height * 0.35,
          ),
          SizedBox(height: height * 0.05),
          Text(
            "Make a full schedule for \n the whole week and stay \n organized and productive \n all days",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: height * 0.025,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class thirdpage extends StatelessWidget {
  const thirdpage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Container(
      color: Color(0xff05243E),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage("assets/images/thirdpic.png"),
            width: height * 0.35,
            height: height * 0.35,
          ),
          SizedBox(height: height * 0.05),
          Text(
            "Create a team task, invite \n people and manage your \n work together",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: height * 0.025,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class fourth extends StatelessWidget {
  const fourth({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Container(
      color: Color(0xff05243E),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/4done.png"),
          SizedBox(height: height * 0.05),
          Text(
            "You informations are \n secure with us",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: height * 0.025,
            ),
          ),
        ],
      ),
    );
  }
}