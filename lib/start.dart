import 'package:berty1/signin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:lottie/lottie.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  PageController _controller = PageController();
  bool onlastpage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
          physics: BouncingScrollPhysics(),
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              onlastpage = index == 2;
            });
          },
          children: [
            Container(
              color: Color(0xFF5D3FD3),
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Lottie.asset('assets/welcome.json'),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: Lottie.asset('assets/welcome1.json'),
                        ),
                      ])),
            ),
            Container(
              color: Color(0xFF4169E1),
              child: Center(child: Lottie.asset('assets/screen3.json')),
            ),
            Container(
              color: Color(0xFF6495ED),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 80, left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          child: Row(
                            children: [
                              Text(
                                "Lets go",
                                style: GoogleFonts.poppins(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(Icons.arrow_forward_ios)
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Signin(),
                                ));
                          },
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Lottie.asset('assets/screen31.json')])),
                ],
              ),
            ),
          ],
        ),
        Container(
            alignment: Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: ExpandingDotsEffect(
                      radius: 10.0,
                      dotHeight: 7,
                      dotColor: Colors.grey,
                      activeDotColor: Colors.pinkAccent),
                ),
              ],
            ))
      ]),
    );
  }
}
