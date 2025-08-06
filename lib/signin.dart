import 'package:berty1/passwordfor.dart';
import 'package:berty1/signup.dart';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'btnnavigationbar.dart';
import 'package:lottie/lottie.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';
import 'session_manager.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

bool isSelected = false;
bool isSelectedpass = false;
bool keypass = true;

class _SigninState extends State<Signin> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithTwitter() async {
    try {
      final twitterProvider = TwitterAuthProvider();

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithProvider(twitterProvider);

      // تخزين بيانات الجلسة بعد تسجيل الدخول
      String? token = userCredential.credential?.accessToken;
      if (token != null) {
        await SessionManager.saveUserToken(token);
      }

      return userCredential;
    } catch (e) {
      print("Error during Twitter sign-in: $e");
      throw Exception("Twitter sign-in failed. Please try again.");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF5D3FD3),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Sign in",
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Color(0xFFE3F2FD),
      body: Container(
          margin: EdgeInsets.all(5),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Container(
                    height: 300,
                    child: ListView(children: [
                      Center(
                          child: Lottie.asset('assets/log in.json',
                              height: 300, width: 300, repeat: false)),
                    ]),
                  ),
                ),
                feild("Email", TextInputType.emailAddress, emailcontroller),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    suffixIcon: IconButton.filledTonal(
                      onPressed: () {
                        setState(() {
                          isSelectedpass = !isSelectedpass;
                          keypass = !keypass;
                        });
                      },
                      isSelected: isSelectedpass,
                      icon: Icon(Icons.visibility_off_outlined),
                      selectedIcon: Icon(Icons.visibility_outlined),
                      style: ButtonStyle(
                        elevation: WidgetStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(
                          Colors.transparent,
                        ),
                        shadowColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),
                        surfaceTintColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),
                        overlayColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),
                      ),
                    ),
                    labelText: "Password",
                    labelStyle: GoogleFonts.poppins(
                      fontSize: 14,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 0.5,
                        )),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: keypass,
                  controller: passwordcontroller,
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Passwordfor(),
                            ));
                      },
                      child: Text("forget password",
                          style: GoogleFonts.poppins(
                              fontSize: 15, color: Colors.blue)),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Signup(),
                            ));
                      },
                      child: Text(
                        "Sign up",
                        style: GoogleFonts.poppins(
                            fontSize: 15, color: Colors.blue),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Center(
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                Color(0xFF673AB7)),
                          ),
                          onPressed: () async {
                            try {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Center(
                                        child: SizedBox(
                                      width: 200.0,
                                      height: 100.0,
                                      child: Shimmer.fromColors(
                                          baseColor: Colors.deepPurpleAccent,
                                          highlightColor: Colors.cyanAccent,
                                          child: Lottie.asset(
                                              "assets/loading splash.json",
                                              height: 200,
                                              width: 200)),
                                    ));
                                  });

                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .signInWithEmailAndPassword(
                                      email: emailcontroller.text,
                                      password: passwordcontroller.text);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      BottomBarWithNormalStyle()));
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                print('No user found for that email.');
                              } else if (e.code == 'wrong-password') {
                                print('Wrong password provided for that user.');
                              }
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Title(
                                  color: Colors.white,
                                  child: Text("log in",
                                      style: GoogleFonts.poppins(
                                          fontSize: 20, color: Colors.white))),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Text("OR",
                            style: GoogleFonts.poppins(
                                fontSize: 15, color: Color(0xFF512DA8)))),
                    SizedBox(height: 10),
                    Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                              Color(0xFFFFFFFF))),
                                  onPressed: () async {
                                    final user = await signInWithGoogle();
                                    if (user != null) {
                                      // تأكد من نجاح تسجيل الدخول
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BottomBarWithNormalStyle()),
                                      );
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: LottieBuilder.asset(
                                            "assets/googlean.json",
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Container(
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all<
                                              Color>(
                                          Color.fromARGB(255, 41, 156, 244))),
                                  onPressed: () async {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Center(
                                              child: CircularProgressIndicator(
                                            color: Color(0xFF5D3FD3),
                                          ));
                                        });

                                    signInWithTwitter();

                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BottomBarWithNormalStyle()));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: LottieBuilder.asset(
                                              "assets/bird.json",
                                              height: 30,
                                              width: 30,
                                              repeat: false,
                                              delegates:
                                                  LottieDelegates(values: [
                                                ValueDelegate.color(
                                                  const ['**'],
                                                  value: Colors.white,
                                                ),
                                              ]))),
                                    ],
                                  )),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Container(
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                              Color(0xFF757575))),
                                  onPressed: () async {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Center(
                                              child: SizedBox(
                                            width: 200.0,
                                            height: 100.0,
                                            child: Shimmer.fromColors(
                                                baseColor:
                                                    Colors.deepPurpleAccent,
                                                highlightColor:
                                                    Colors.cyanAccent,
                                                child: Lottie.asset(
                                                    "assets/loading splash.json",
                                                    height: 200,
                                                    width: 200)),
                                          ));
                                        });
                                    UserCredential userCredential =
                                        await FirebaseAuth.instance
                                            .signInAnonymously();
                                    if (userCredential != null) {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BottomBarWithNormalStyle()));
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          height: 50,
                                          width: 50,
                                          child:
                                              Image.asset("assets/hacker.png")),
                                    ],
                                  )),
                            ),
                          ]),
                    ),
                  ],
                ),
              ])),
    );
  }

  feild(String label, TextInputType keybordtype,
      TextEditingController controller) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 15,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.black,
              width: 0.5,
            )),
      ),
      keyboardType: keybordtype,
      controller: controller,
    );
  }
}
