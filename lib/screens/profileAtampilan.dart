import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfillAtampilan extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 219, 100),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset(
                        'assets/images/hive_logo.png', // Replace with your logo
                        height: 50,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                // Handle navigation to Profile
              },
            ),
            ListTile(
              title: Text('Notifikasi'),
              onTap: () {
                // Handle navigation to Notifikasi
              },
            ),
            ListTile(
              title: Text('Saluran'),
              onTap: () {
                // Handle navigation to Saluran
              },
            ),
            ListTile(
              title: Text('Teman'),
              onTap: () {
                // Handle navigation to Teman
              },
            ),
            ListTile(
              title: Text('Kotak Saran'),
              onTap: () {
                // Handle navigation to Kotak Saran
              },
            ),
            ListTile(
              title: Text('Keluar'),
              onTap: () {
                // Handle logout
              },
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.facebook),
                    onPressed: () {
                      // Handle Facebook link
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.favorite),
                    onPressed: () {
                      // Handle Instagram link
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 250, 223),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: screenHeight * 0.05, bottom: screenHeight * 0.02),
              width: screenWidth * 0.3,
              height: screenWidth * 0.3,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey, // Placeholder for profile picture
              ),
              child: Icon(Icons.person, size: screenWidth * 0.15, color: const Color.fromARGB(255, 255, 228, 74)),
            ),
            Container(
              margin: EdgeInsets.only(bottom: screenHeight * 0.01),
              child: Text(
                'Username',
                style: GoogleFonts.getFont(
                  'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: screenWidth * 0.05,
                  color: Color(0xFF000000),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: screenHeight * 0.02),
              child: Text(
                'Siswa', // Ganti dengan keterangan yang sesuai
                style: GoogleFonts.getFont(
                  'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: screenWidth * 0.04,
                  color: Color(0xFF6D6D6D),
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Pengaturan',
                style: GoogleFonts.getFont(
                  'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: screenWidth * 0.05,
                  color: Color(0xFF000000),
                ),
              ),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return ListView(
                      padding: EdgeInsets.all(screenWidth * 0.05),
                      children: [
                        ListTile(
                          title: Text('Edit Profile'),
                          onTap: () {
                            Navigator.pop(context);
                            // Navigate to Edit Profile page
                          },
                        ),
                        ListTile(
                          title: Text('Layanan Admin'),
                          onTap: () {
                            Navigator.pop(context);
                            // Navigate to Layanan Admin page
                          },
                        ),
                        ListTile(
                          title: Text('Notifikasi'),
                          onTap: () {
                            Navigator.pop(context);
                            // Navigate to Notifikasi page
                          },
                        ),
                        ListTile(
                          title: Text('Bahasa'),
                          onTap: () {
                            Navigator.pop(context);
                            // Navigate to Bahasa page
                          },
                        ),
                        ListTile(
                          title: Text('Update Aplikasi'),
                          onTap: () {
                            Navigator.pop(context);
                            // Navigate to Update Aplikasi page
                          },
                        ),
                        ListTile(
                          title: Text('FAQ'),
                          onTap: () {
                            Navigator.pop(context);
                            // Navigate to FAQ page
                          },
                        ),
                        ListTile(
                          title: Text('Kontak Dukungan'),
                          onTap: () {
                            Navigator.pop(context);
                            // Navigate to Kontak Dukungan page
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            Divider(color: Colors.black),
            ListTile(
              title: Text(
                'Tentang Kami',
                style: GoogleFonts.getFont(
                  'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: screenWidth * 0.05,
                  color: Color(0xFF000000),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TentangKamiPage()),
                );
              },
            ),
            Divider(color: Colors.black),
            ListTile(
              title: Text(
                'Syarat & Ketentuan',
                style: GoogleFonts.getFont(
                  'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: screenWidth * 0.05,
                  color: Color(0xFF000000),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SyaratKetentuanPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SyaratKetentuanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Syarat & Ketentuan'),
        backgroundColor: Color(0xFFFFD700),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Syarat dan Ketentuan Penggunaan Aplikasi HIVE\n\n'
                'Selamat datang di HIVE. Dengan menggunakan aplikasi ini, Anda setuju untuk mematuhi dan terikat oleh syarat dan ketentuan penggunaan berikut ini. Harap baca dengan cermat.\n\n'
                '1. Penerimaan Syarat\n'
                'Dengan mengakses atau menggunakan aplikasi HIVE, Anda menyetujui syarat dan ketentuan ini. Jika Anda tidak setuju dengan syarat dan ketentuan ini, harap jangan gunakan aplikasi ini.\n\n'
                '2. Penggunaan Aplikasi\n\n'
                'Aplikasi HIVE hanya boleh digunakan untuk tujuan yang sah dan sesuai dengan semua hukum dan peraturan yang berlaku.\n'
                'Anda setuju untuk tidak menggunakan aplikasi ini untuk kegiatan yang melanggar hukum, merugikan, atau mengganggu hak-hak orang lain.\n\n'
                '3. Akun Pengguna\n\n'
                'Anda harus mendaftar untuk membuat akun pengguna untuk mengakses fitur-fitur tertentu dalam aplikasi HIVE.\n'
                'Anda bertanggung jawab untuk menjaga kerahasiaan informasi akun Anda dan semua aktivitas yang terjadi di akun Anda.\n\n'
                '4. Konten dan Informasi\n\n'
                'Semua konten yang diposting dalam aplikasi, termasuk tetapi tidak terbatas pada teks, gambar, dan video, harus sesuai dengan standar komunitas dan tidak melanggar hak cipta atau hak kekayaan intelektual orang lain.\n'
                'HIVE tidak bertanggung jawab atas konten yang diposting oleh pengguna aplikasi.\n\n'
                '5. Pembaruan Aplikasi\n\n'
                'HIVE berhak untuk mengubah, memperbarui, atau menghentikan aplikasi atau fitur-fitur tertentu kapan saja tanpa pemberitahuan sebelumnya.\n\n'
                '6. Batasan Tanggung Jawab\n\n'
                'HIVE tidak bertanggung jawab atas kerugian atau kerusakan yang timbul dari penggunaan aplikasi ini.\n'
                'Penggunaan aplikasi ini adalah risiko Anda sendiri.\n\n'
                '7. Privasi\n\n'
                'Kami mengumpulkan dan menggunakan informasi pribadi Anda sesuai dengan Kebijakan Privasi kami. Harap tinjau Kebijakan Privasi kami untuk informasi lebih lanjut.\n\n'
                '8. Perubahan Syarat dan Ketentuan\n\n'
                'Kami dapat mengubah syarat dan ketentuan ini sewaktu-waktu tanpa pemberitahuan sebelumnya. Perubahan akan berlaku setelah diposting di aplikasi HIVE.\n\n'
                '9. Hukum yang Berlaku\n\n'
                'Syarat dan ketentuan ini diatur oleh dan ditafsirkan sesuai dengan hukum yang berlaku di negara tempat HIVE beroperasi.\n\n'
                'Jika Anda memiliki pertanyaan atau masalah mengenai syarat dan ketentuan ini, harap hubungi tim dukungan kami.',
                style: GoogleFonts.getFont(
                  'Inter',
                  fontSize: screenWidth * 0.04,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TentangKamiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Tentang Kami'),
        backgroundColor: Color(0xFFFFD700),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tentang Kami\n\n'
                'Selamat datang di HIVE, aplikasi yang dirancang untuk membantu Anda mengatur kegiatan belajar dan mengajar dengan lebih efisien. Kami adalah tim yang berdedikasi untuk memberikan pengalaman terbaik bagi pengguna kami.\n\n'
                'Visi Kami\n\n'
                'Menjadi platform terdepan dalam mendukung kegiatan belajar dan mengajar di era digital.\n\n'
                'Misi Kami\n\n'
                '1. Mempermudah akses ke sumber belajar.\n'
                '2. Meningkatkan interaksi antara siswa dan pengajar.\n'
                '3. Memberikan alat-alat yang diperlukan untuk pengelolaan pembelajaran yang efektif.\n\n'
                'Nilai-Nilai Kami\n\n'
                '1. Inovasi: Terus berinovasi untuk memberikan solusi terbaik.\n'
                '2. Kolaborasi: Mendorong kolaborasi antara semua pihak yang terlibat dalam proses belajar-mengajar.\n'
                '3. Keunggulan: Berkomitmen untuk memberikan layanan dan produk yang unggul.\n\n'
                'Hubungi Kami\n\n'
                'Jika Anda memiliki pertanyaan, saran, atau masukan, jangan ragu untuk menghubungi kami melalui email di support@hive.com atau melalui nomor telepon (021) 123-4567.',
                style: GoogleFonts.getFont(
                  'Inter',
                  fontSize: screenWidth * 0.04,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}