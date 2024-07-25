import 'package:flutter/material.dart';
import 'package:flutter_hive/screens/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _policyChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 30.0 * MediaQuery.of(context).devicePixelRatio / 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/Hive Logo.png'),
              const SizedBox(height: 24),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(34.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 2.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
                style: TextStyle(color: Colors.grey, fontSize: 13.0),
              ),
              const SizedBox(height: 13),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Nama Lengkap',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(34.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 2.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
                style: TextStyle(color: Colors.grey, fontSize: 13.0),
              ),
              const SizedBox(height: 13),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Alamat Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(34.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 2.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
                style: TextStyle(color: Colors.grey, fontSize: 13.0),
              ),
              const SizedBox(height: 13),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Kata Sandi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(34.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 2.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
                style: TextStyle(color: Colors.grey, fontSize: 13.0),
                obscureText: true,
              ),
              const SizedBox(height: 13),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Ulangi Kata Sandi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(34.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 2.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
                style: TextStyle(color: Colors.grey, fontSize: 13.0),
                obscureText: true,
              ),
              const SizedBox(height: 13),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Nomor Ponsel',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(34.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 2.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
                style: TextStyle(color: Colors.grey, fontSize: 13.0),
              ),
              const SizedBox(height: 13),
              Row(
                children: [
                  Theme(
                    data: ThemeData(
                      unselectedWidgetColor: const Color(0xFFF7CA33),
                    ),
                    child: Checkbox(
                      value: _policyChecked,
                      activeColor: const Color(0xFFF7CA33),
                      onChanged: (bool? value) {
                        setState(() {
                          _policyChecked = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RichText(
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
                              color: Color(0xFFF7CA33),
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
                  ),
                ],
              ),
              const SizedBox(height: 17),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    if (_policyChecked) {
                      print('Register');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Anda harus menyetujui Kebijakan Privasi dan Syarat dan Ketentuan'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFFF7CA33),
                  ),
                  child: const Text('Daftar'),
                ),
              ),
              const SizedBox(height: 13),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sudah punya akun?',
                    style: TextStyle(color: Colors.grey, fontSize: 14.0),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text(
                      'Masuk',
                      style: TextStyle(
                          color: Colors.yellow.shade600,
                          fontSize: 14.0,
                          decoration: TextDecoration.underline,
                          decorationColor: const Color(0xFFF7CA33)),
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
