import 'package:flutter/material.dart';
import 'package:flutter_hive/screens/Loading_page.dart';

class Loading1Page extends StatefulWidget {
  const Loading1Page({Key? key}) : super(key: key);

  @override
  _Loading1Page createState() => _Loading1Page();
}

class _Loading1Page extends State<Loading1Page> {
  @override
  void initState() {
    super.initState();
    // Navigasi ke halaman NextPage setelah delay beberapa detik
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoadingPage()),
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
              Image.asset('assets/images/Hive 2 B 1.png'),
            ],
          ),
        ),
      ),
    );
  }
}
