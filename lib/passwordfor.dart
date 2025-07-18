import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Passwordfor extends StatefulWidget {
  const Passwordfor({super.key});

  @override
  State<Passwordfor> createState() => _PasswordforState();
}

class _PasswordforState extends State<Passwordfor> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xFF5D3FD3),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Reset password",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              height: 150,
              child: Center(
                child: ListTile(
                  title: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Forgot password",
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  subtitle: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Enter your email account to reset your password",
                      style: GoogleFonts.poppins(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            TextField(
              controller: emailcontroller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                hintText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    14.0,
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 50),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF5D3FD3)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      16,
                    ),
                  ),
                ),
              ),
              onPressed: () async {
                await FirebaseAuth.instance.sendPasswordResetEmail(
                  email: emailcontroller.text,
                );

                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      icon: CircleAvatar(
                        backgroundColor: Colors.blue[600],
                        child: Icon(
                          Icons.mark_email_read_outlined,
                          color: Colors.white,
                        ),
                      ),
                      title: Center(
                        child: Container(
                          height: 100,
                          child: ListTile(
                            title: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: "Check your email",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            subtitle: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text:
                                    "We have send password recovery instruction to your email",
                                style: GoogleFonts.poppins(
                                  color: Colors.grey[600],
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: 56,
                width: 400,
                child: Center(
                  child: Text(
                    "Reset Password",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: Colors.white,
                    ),
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
