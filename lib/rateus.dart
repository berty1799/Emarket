import 'package:berty1/btnnavigationbar.dart';

import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:gradient_borders/gradient_borders.dart';

class Rateus extends StatefulWidget {
  const Rateus({super.key});

  @override
  State<Rateus> createState() => _RateusState();
}

class _RateusState extends State<Rateus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Color(0xFF5D3FD3),
        title: Text(
          'Rate Us',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              Icons.rate_review_outlined,
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
                height: 300,
                child: ListView(children: [Lottie.asset("assets/rate.json")])),
            SizedBox(
              height: 40,
            ),
            Center(
              child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                      decoration: BoxDecoration(
                          border: GradientBoxBorder(
                              gradient: LinearGradient(
                                  colors: [Colors.blue, Colors.red]),
                              width: 10)),
                      height: 300,
                      child: ListView(children: [
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Give us rate 1 to 5",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        )),
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: RatingBar.builder(
                            initialRating: 1,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.red,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                            child: Container(
                                height: 50,
                                width: 200,
                                child: ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                            title: const Text('Success'),
                                            content: Container(
                                              height: 300,
                                              width: 300,
                                              child: LottieBuilder.asset(
                                                "assets/sucess.json",
                                                repeat: false,
                                              ),
                                            ),
                                            actions: <Widget>[
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Btnnavigationbar()));
                                                  },
                                                  child: Text("Ok"))
                                            ]);
                                      },
                                    );
                                  },
                                  child: Text("Save"),
                                )))
                      ]))),
            )
          ],
        ),
      ),
    );
  }
}
