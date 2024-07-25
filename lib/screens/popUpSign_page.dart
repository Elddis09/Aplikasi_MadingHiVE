// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hive/screens/login_page.dart';
import 'package:flutter_hive/screens/register_page.dart';

class PopUpSignPage extends StatefulWidget {
  PopUpSignPage({Key? key}) : super(key: key);

  @override
  _PopUpSignPage createState() => _PopUpSignPage();
}

class _PopUpSignPage extends State<PopUpSignPage>
    with TickerProviderStateMixin {
  // Change SingleTickerProviderStateMixin to TickerProviderStateMixin
  bool isLoading = false;
  late AnimationController _animationController; // Main animation controller
  late AnimationController
      _exitAnimationController; // Exit animation controller
  late Animation<Offset> _animation; // Animation for initial popup
  late Animation<Offset> _exitAnimation; // Animation for exiting popup
// Animation for login button

  @override
  void initState() {
    super.initState();
    // Initialize the main animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    // Initialize the exit animation controller
    _exitAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
    );
    // Define the animation for the initial popup
    _animation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(_animationController);

    // Define the animation for the exit popup
    _exitAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, 1.0),
    ).animate(CurvedAnimation(
      parent: _exitAnimationController,
      curve: Curves.easeInOut,
    ));

    // Start the initial animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _exitAnimationController.dispose();
    super.dispose();
  }

  // Function to handle navigation with animation
  void navigateToPage(Widget page) async {
    if (isLoading) return;
    setState(() => isLoading = true);

    // Play exit animation
    await _exitAnimationController.forward();

    // Navigate to the new page with custom transition
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );

    setState(() => isLoading = false);
  }

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
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SlideTransition(
              position: _animation,
              child: SlideTransition(
                position: _exitAnimation,
                child: Container(
                  width: screenWidth,
                  height: screenHeight / 2.8,
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
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(38.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Image(
                            image: AssetImage('assets/images/Hive Logo.png'),
                          ),
                          const SizedBox(height: 1.0),
                          const SizedBox(height: 3),
                          IntrinsicWidth(
                            child: TextButton(
                              onPressed: () =>
                                  navigateToPage(LoginPage()),
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFFF7CA33),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 90,
                                ),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(34.0)),
                                ),
                              ),
                              child: const Text(
                                'Masuk Sekarang',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          IntrinsicWidth(
                            child: TextButton(
                              onPressed: () =>
                                  navigateToPage(const RegisterPage()),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 90,
                                ),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(34.0)),
                                  side: BorderSide(
                                    color: Color(0xFFFD9D9D9),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: const Text(
                                '+Daftar Sekarang',
                                style: TextStyle(
                                  color: Color(0xFFF7CA33),
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 13.0),
                          RichText(
                            text: TextSpan(
                              text: 'Baca ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13.0,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Syarat & Ketentuan',
                                  style: TextStyle(
                                    color: Color(0xFFF7CA33),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: ' dan ',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
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
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
