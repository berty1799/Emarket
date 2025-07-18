import 'package:berty1/btnnavigationbar.dart';
import 'package:berty1/homepage.dart';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

CarouselSliderController buttonCarouselController = CarouselSliderController();
void searchAndNavigate(String query) {
  int index = product.indexWhere((product) => product["name"].contains(query));
  if (index != -1) {
    buttonCarouselController.animateToPage(index);
  }
}

List searchhistory = [];

final SearchController controller = SearchController();

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          color: Color.fromARGB(255, 39, 79, 187),
          child: Column(children: [
            SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Btnnavigationbar(),
                            ));
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search',
                ),
                onChanged: searchAndNavigate,
              ),
            ),
            Expanded(
              child: Container(
                  height: MediaQuery.of(context).size.height - 260,
                  child: GestureDetector(
                    onTap: () {},
                    child: CarouselSlider.builder(
                      itemCount: product.length,
                      itemBuilder: (context, index, realIndex) => Container(
                          color: Color(0xFF4A90E2),
                          child: ListView(children: [
                            Container(
                                height: 300,
                                color: Color(0xFF4A90E2),
                                child: Image.network(product[index]["image"])),
                            ListTile(
                              title: Center(
                                  child: Text(
                                product[index]["name"],
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              )),
                              subtitle: Center(
                                  child: Text(
                                product[index]["price"],
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              )),
                            ),
                          ])),
                      carouselController: buttonCarouselController,
                      options: CarouselOptions(
                        height: 400,
                        pauseAutoPlayOnTouch: true,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 2),
                        autoPlayCurve: Curves.easeInOut,
                        enlargeCenterPage: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        enlargeFactor: 0.3,
                      ),
                    ),
                  )),
            )
          ])),
    );
  }
}
