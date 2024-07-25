import 'package:flutter/material.dart';
import 'package:flutter_hive/screens/PopUpSign_page.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    // Navigasi ke halaman NextPage setelah delay beberapa detik
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PopUpSignPage()),
      );
    });
  }

  Widget build(BuildContext context) {
    final double horizontalPadding =
        50.0 * MediaQuery.of(context).devicePixelRatio / 2;

    return Scaffold(
      backgroundColor: const Color(0xFFF7CA33),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/Hive 2 B 2.png'),
              SizedBox(height: 10),
              Image.asset('assets/images/loading.png'),
            ],
          ),
        ),
      ),
    );
  }
}
