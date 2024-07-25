import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Notifikasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 226, 61),
        title: Text(
          'NOTIFIKASI',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: screenWidth * 0.05,
            color: const Color.fromARGB(255, 3, 3, 3),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: const Color.fromARGB(255, 0, 0, 0)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Color(0xFFF3F2F0),
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'INFO',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: screenWidth * 0.04,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'BANTUAN',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: screenWidth * 0.04,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey),
          Expanded(
            child: Center(
              child: Text(
                'Coming Soon! Belum ada notifikasi masuk.',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: screenWidth * 0.04,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}