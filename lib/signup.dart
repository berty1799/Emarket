import 'package:berty1/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF5D3FD3),
        title: Text(
          "Sign up",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            feild("Email", TextInputType.emailAddress, emailcontroller),
            SizedBox(height: 10),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
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
              keyboardType: TextInputType.visiblePassword,
              controller: passwordcontroller,
            ),
            SizedBox(height: 10),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password again",
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
              keyboardType: TextInputType.visiblePassword,
              controller: passwordcontroller,
            ),
            Column(children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () async {
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
                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .createUserWithEmailAndPassword(
                                  email: emailcontroller.text,
                                  password: passwordcontroller.text);

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Signin()));
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            print('The account already exists for that email.');
                          }
                        } catch (e) {
                          print(e);
                        }
                        User? user = FirebaseAuth.instance.currentUser;

                        if (user != null && !user.emailVerified) {
                          await user.sendEmailVerification();
                        }
                      },
                      child: Text("Sign up ")),
                ),
              )
            ]),
            Expanded(
                child: ListView(children: [
              Center(
                child: Lottie.asset('assets/signupp.json', repeat: false),
              ),
            ]))
          ],
        ),
      ),
    );
  }
}

feild(
    String label, TextInputType keybordtype, TextEditingController controller) {
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
