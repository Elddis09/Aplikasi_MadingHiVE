import 'package:flutter/material.dart';
import 'package:flutter_hive/screens/berandaMading.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

class LoginPage extends StatelessWidget {
  // final TextEditingController email = TextEditingController();
  // final TextEditingController password = TextEditingController();

  // Future<void> _login() async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse("http://10.0.2.2:8000/api/"),
  //       body: {
  //         "email": email.text,
  //         "password": password.text,
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       String token = data['token'];
  //       print('Login successful: $token');
  //     } else {
  //       print('Server error: ${response.statusCode} - ${response.body}');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.0 * MediaQuery.of(context).devicePixelRatio / 2,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/Hive Logo.png'),
              const SizedBox(height: 24),
              TextField(
                // controller: email,
                decoration: const InputDecoration(
                  hintText: 'Username/Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(34.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 2.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
                style: const TextStyle(color: Colors.grey, fontSize: 13.0),
              ),
              const SizedBox(height: 13),
              TextField(
                // controller: password,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(34.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 2.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
                style: const TextStyle(color: Colors.grey, fontSize: 13.0),
                obscureText: true,
              ),
              const SizedBox(height: 13),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      print('Forgot Password');
                    },
                    child: Text(
                      'Lupa Password?',
                      style: TextStyle(
                        color: Colors.yellow.shade600,
                        fontSize: 14.0,
                        decoration: TextDecoration.underline,
                        decorationColor: const Color(0xFFF7CA33),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 13),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    // _login();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BerandaMading()));
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFFF7CA33),
                  ),
                  child: const Text('Masuk'),
                ),
              ),
              const SizedBox(height: 13),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Belum punya akun?',
                    style: TextStyle(color: Colors.grey, fontSize: 14.0),
                  ),
                  TextButton(
                    onPressed: () {
                      print('Register');
                    },
                    child: Text(
                      'Daftar',
                      style: TextStyle(
                        color: Colors.yellow.shade600,
                        fontSize: 14.0,
                        decoration: TextDecoration.underline,
                        decorationColor: const Color(0xFFF7CA33),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
