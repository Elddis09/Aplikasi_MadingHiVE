import 'package:flutter/material.dart';
import 'package:flutter_hive/screens/login_page.dart';
import 'package:flutter_hive/screens/register_page.dart';

class PopUpDaftarPage extends StatelessWidget {
  const PopUpDaftarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding =
        50.0 * MediaQuery.of(context).devicePixelRatio / 2;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF7CA33),
      body: Stack(
        children: [
          // Main content
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/loading.png'),
                ],
              ),
            ),
          ),
          // Semi-transparent overlay to darken the background
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          // Popup from the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: screenWidth,
              height: screenHeight / 3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // shadow position
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(38.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Opsi Mendaftar',
                      ),
                    ),
                    const Spacer(),
                    RichText(
                      text: const TextSpan(
                        text: 'Dengan mendaftar, saya bersedia menyetujui\n',
                        style: TextStyle(color: Colors.black, fontSize: 13.0),
                        children: [
                          TextSpan(
                            text: 'Baca ',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: 'Syarat dan Ketentuan',
                            style: TextStyle(
                              color: const Color(0xFFF7CA33),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: ' dan ',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: 'Kebijakan Privasi',
                            style: TextStyle(
                              color: Color(0xFFF7CA33),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 13.0), // Adjusted space
                    IntrinsicWidth(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: const Text(
                          'Masuk Sekarang',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFFF7CA33),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 90),
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(34.0)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5.0), // Adjusted space
                    IntrinsicWidth(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()));
                        },
                        child: const Text(
                          '+Daftar Sekarang',
                          style: TextStyle(
                            color: Color(0xFFF7CA33),
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 90),
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(34.0)),
                            side: BorderSide(
                                color: Color(0xFFFD9D9D9), width: 1.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 13.0), //
                    const Text.rich(
                      TextSpan(
                        text: 'Batalkan',
                        style: TextStyle(
                            color: Color(0xFFF7CA33),
                            fontSize: 13.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    //Adjusted space
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
