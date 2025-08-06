import 'dart:convert';

import 'package:berty1/ProductDetails.dart';
import 'package:berty1/Viewall.dart';
import 'package:berty1/signin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'rateus.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:animations/animations.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

List product = [];

Future<void> fetchData() async {
  final response = await http.get(Uri.parse(
      'https://script.google.com/macros/s/AKfycbzpmG9yAS4-fWPu2XpQVY6BGMRIe0llFEn9yuEl7EV-WQ61DqkACUUJ8N4U1NuhVxwD/exec'));

  var data = json.decode(response.body);

  product = data;
}

int prod = 0;

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF1E3A8A),
          title: Text("Home"),
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            size: 25,
            color: Colors.white,
          ),
          /*leading: Icon(Icons.search),*/
        ),
        drawer: Drawer(
          backgroundColor: Color(0xFF4A90E2),
          child: Column(
            children: <Widget>[
              Container(
                color: Color(0xFF1E3A8A),
                child: ListTile(
                  title: Text(
                    "Info",
                    style:
                        GoogleFonts.poppins(fontSize: 25, color: Colors.white),
                  ),
                  subtitle: Text(
                    "Call center: 000000000",
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                  leading: Icon(Icons.info, color: Colors.white),
                  onTap: () {},
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                        child: ListTile(
                      tileColor: Color.fromARGB(255, 13, 107, 214),
                      title: Text(
                        "Version: 1.1.1",
                        style: GoogleFonts.poppins(
                            fontSize: 15, color: Colors.white),
                      ),
                      leading:
                          Icon(Icons.verified, size: 20, color: Colors.white),
                    )),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.black)),
                      ),
                      child: Column(children: <Widget>[
                        Container(
                            child: MaterialButton(
                          child: ListTile(
                            title: Text(
                              "Rate us",
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            trailing: Icon(
                              Icons.navigate_next,
                              size: 20,
                              color: Colors.white,
                            ),
                            leading: Icon(
                              Icons.star,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Rateus()));
                          },
                        ))
                      ]),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(color: Colors.black, width: 1),
                      )),
                      child: MaterialButton(
                        child: ListTile(
                          title: Text(
                            "Sign out",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          trailing: Icon(
                            Icons.navigate_next,
                            size: 20,
                            color: Colors.white,
                          ),
                          leading: Icon(
                            Icons.logout,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Signin()));
                        },
                      ))
                ]),
              ),
              Container(
                child: Column(children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ))),
                      child: MaterialButton(
                        child: ListTile(
                          title: Text(
                            "delete account",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          trailing: Icon(
                            Icons.navigate_next,
                            size: 20,
                            color: Colors.white,
                          ),
                          leading: Icon(
                            Icons.delete,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    "Delete Account",
                                    style: GoogleFonts.poppins(),
                                  ),
                                  content: Text(
                                    "Are you sure you want to delete your account ?",
                                    style: GoogleFonts.poppins(fontSize: 15),
                                  ),
                                  icon: Icon(
                                    Icons.warning,
                                    size: 25,
                                    color: Colors.red,
                                  ),
                                  actions: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: GestureDetector(
                                        child: Text(
                                          "Cancel",
                                          style:
                                              GoogleFonts.poppins(fontSize: 15),
                                        ),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: GestureDetector(
                                        child: Text(
                                          "ok",
                                          style:
                                              GoogleFonts.poppins(fontSize: 15),
                                        ),
                                        onTap: () async {
                                          CircularProgressIndicator(
                                            color: Colors.purple,
                                          );
                                          try {
                                            await FirebaseAuth
                                                .instance.currentUser!
                                                .delete();
                                          } on FirebaseAuthException catch (e) {
                                            if (e.code ==
                                                'requires-recent-login') {
                                              print(
                                                  'The user must reauthenticate before this operation can be executed.');
                                            }
                                          }

                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Signin()));
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              });
                        },
                      )),
                ]),
              )
            ],
          ),
        ),
        body: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ListView(
                children: [
                  shimmerSectionTitle("most view"),
                  Container(
                    height: 250,
                    color: Color(0xFF1E3A8A),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) => shimmerItem(),
                    ),
                  ),
                  shimmerSectionTitle("Today's deal"),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) => shimmerRowItem(),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                  child: LottieBuilder.asset("assets/Error 404.json"));
            } else {
              // البيانات وصلت وهنعرضها
              return ListView(
                children: [
                  ListTile(
                    tileColor: Color(0xFF4A90E2),
                    leading: Text(
                      "most view",
                      style: GoogleFonts.poppins(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    trailing: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Viewall()));
                      },
                      child: Text(
                        "View all",
                        style: GoogleFonts.poppins(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 250,
                    color: Color(0xFF1E3A8A),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: product.length < 5 ? product.length : 5,
                      itemBuilder: (context, index) => buildProductItem(index),
                    ),
                  ),
                  ListTile(
                    tileColor: Color(0xFF4A90E2),
                    title: Text(
                      "Today's deal",
                      style: GoogleFonts.poppins(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    color: Color(0xFF1E3A8A),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: product.length < 4 ? product.length : 4,
                      itemBuilder: (context, index) => buildRowProduct(index),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    ]);
  }

  Widget shimmerSectionTitle(String title) {
    return ListTile(
      tileColor: Color(0xFF4A90E2),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 20.0,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget shimmerItem() {
    return Padding(
      padding: const EdgeInsets.only(right: 15, top: 10),
      child: Container(
        height: 300,
        width: 170,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFCBD5E1)),
          borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
          color: Colors.white,
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            children: [
              Container(
                height: 100,
                width: 100,
                color: Colors.grey[300],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 15,
                  width: 100,
                  color: Colors.grey[300],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  height: 10,
                  width: 60,
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget shimmerRowItem() {
    return Padding(
      padding: const EdgeInsets.only(right: 15, bottom: 10, top: 10),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFCBD5E1)),
          borderRadius: BorderRadius.only(topRight: Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: Offset(4, 4),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Row(
            children: [
              Container(
                height: 150,
                width: 150,
                color: Colors.grey[300],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 15,
                        width: 100,
                        color: Colors.grey[300],
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 12,
                        width: 60,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProductItem(int index) {
    final item = product[index];

    return Padding(
      padding: const EdgeInsets.only(right: 15, top: 10),
      child: OpenContainer(
        transitionType: ContainerTransitionType.fadeThrough,
        transitionDuration: Duration(milliseconds: 500),
        closedElevation: 5,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
        ),
        closedColor: Colors.white,
        openBuilder: (context, _) => ProductDetails(product: item),
        closedBuilder: (context, openContainer) => GestureDetector(
          onTap: openContainer,
          child: Container(
            height: 300,
            width: 170,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFCBD5E1)),
              borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: Offset(4, 4),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  child: Image.network(
                    fit: BoxFit.contain,
                    item["image"],
                  ),
                ),
                ListTile(
                  title: Text(
                    item["name"],
                    style: GoogleFonts.poppins(),
                  ),
                  subtitle: Text(
                    item["price"],
                    style: GoogleFonts.poppins(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRowProduct(int index) {
    final item = product[index];

    return Padding(
      padding: const EdgeInsets.only(right: 15, bottom: 10, top: 10),
      child: OpenContainer(
        transitionType: ContainerTransitionType.fade,
        transitionDuration: Duration(milliseconds: 500),
        closedElevation: 5,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(10)),
        ),
        closedColor: Colors.white,
        openBuilder: (context, _) => ProductDetails(product: item),
        closedBuilder: (context, openContainer) => GestureDetector(
          onTap: openContainer,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFCBD5E1)),
              borderRadius: BorderRadius.only(topRight: Radius.circular(10)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: Offset(4, 4),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  height: 150,
                  width: 150,
                  child: Image.network(
                    fit: BoxFit.contain,
                    item["image"],
                  ),
                ),
                Flexible(
                  child: ListTile(
                    title: Text(
                      item["name"],
                      style: GoogleFonts.poppins(),
                    ),
                    subtitle: Text(
                      item["price"],
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
