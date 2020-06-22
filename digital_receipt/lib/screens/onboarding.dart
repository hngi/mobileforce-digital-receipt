import 'dart:io';
import './login_screen.dart';
import '../models/data.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  List<SliderModel> slides = new List<SliderModel>();

  int currentIndex = 0;
  PageController pageController = new PageController(initialPage: 0);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    slides = getSlides();
  }

  Widget pageIndexIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: 2,
      width: 20,
      decoration: BoxDecoration(
          color: isCurrentPage ? Color(0xFF25CCB3) : Color(0xFFC4C4C4),
          borderRadius: BorderRadius.circular(80)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: PageView.builder(
            controller: pageController,
            itemCount: slides.length,
            onPageChanged: (val) {
              setState(() {
                currentIndex = val;
              });
            },
            itemBuilder: (context, index) {
              return SliderTile(
                imageAssetPath: slides[index].getImageAssetPath(),
                title: slides[index].getTitle(),
                desc: slides[index].getDesc(),
              );
            }),
      ),
      bottomSheet: currentIndex != slides.length - 1
          ? Container(
              height: Platform.isIOS ? 130 : 120,
              color: Color(0xFFF2F8FF),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 0; i < slides.length; i++)
                          currentIndex == i
                              ? pageIndexIndicator(true)
                              : pageIndexIndicator(false)
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            pageController.animateToPage(slides.length - 1,
                                duration: Duration(milliseconds: 400),
                                curve: Curves.linear);
                          },
                          child: Text(
                            "Back",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.3,
                            ),
                          )),
                      GestureDetector(
                          onTap: () {
                            pageController.animateToPage(currentIndex + 1,
                                duration: Duration(milliseconds: 400),
                                curve: Curves.linear);
                          },
                          child: Text(
                            "Next",
                            style: TextStyle(
                                color: Color(0xFF226EBE),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                letterSpacing: 0.3),
                          )),
                    ],
                  ),
                ],
              ),
            )
          : Container(
              color: Color(0xFFF2F8FF),
              height: Platform.isIOS ? 130 : 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 32,
                      height: 45,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => LogInScreen(),
                            ),
                          );
                        },
                        color: Color(0xFF0B57A7),
                        child: Text(
                          "Proceed",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class SliderTile extends StatelessWidget {
  String imageAssetPath, title, desc;
  SliderTile({this.imageAssetPath, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(imageAssetPath),
          SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(0, 0, 0, 0.87),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 16,
              letterSpacing: 0.3,
              color: Color.fromRGBO(0, 0, 0, 0.87),
            ),
          )
        ],
      ),
    );
  }
}
