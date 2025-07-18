import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Color(0xFFF4F6FA),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF1E3A8A),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "My Profile",
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: user == null
          ? Center(
              child: Text(
                "No user signed in",
                style: GoogleFonts.poppins(fontSize: 18),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue.shade100,
                    child: Icon(Icons.person, size: 60, color: Colors.blue),
                  ),
                  SizedBox(height: 20),
                  Text(
                    user.displayName ?? "No name set",
                    style: GoogleFonts.poppins(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    user.email ?? '',
                    style: GoogleFonts.poppins(
                        fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        _buildInfoCard("Email", user.email ?? "Not set"),
                        _buildInfoCard("User ID", user.uid),
                        _buildInfoCard("Display Name",
                            user.displayName ?? "No name available"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.blue),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.grey[700])),
                  SizedBox(height: 4),
                  Text(value,
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
