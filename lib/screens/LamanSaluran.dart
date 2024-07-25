import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LamanSaluran(),
    );
  }
}

class LamanSaluran extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Color(0xFFFBBC05),
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'Buat Saluran',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    // Define your menu button function here
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Color(0xFFFFE598),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => KeteranganSaluran()),
                    );
                  },
                  child: Text('Klik + Buat Saluran'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFBBC05), // Button color
                    foregroundColor: Colors.white, // Text color
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.2,
                      vertical: screenWidth * 0.05,
                    ),
                    textStyle: TextStyle(
                      fontSize: screenWidth * 0.04,
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

class KeteranganSaluran extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFBBC05),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Keterangan Saluran',
            style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.05)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenWidth * 0.05),
            Icon(Icons.wifi, size: screenWidth * 0.25, color: const Color.fromARGB(255, 255, 199, 87)),
            SizedBox(height: screenWidth * 0.05),
            Text(
              'Buat saluran untuk menyampaikan informasi penting dan pengumuman dari organisasi',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenWidth * 0.075),
            _buildKeteranganItem(
              Icons.public,
              'Semua orang dapat menemukan saluran Anda',
              'Berbagi berita, acara, dan update organisasi Anda melalui saluran ini.',
              screenWidth,
            ),
            _buildKeteranganItem(
              Icons.shield,
              'Anda bertanggung jawab atas saluran Anda',
              'Saluran Anda harus mematuhi pedoman kami dan ditinjau berdasarkan pedoman tersebut.',
              screenWidth,
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BuatSaluranPage()),
                );
              },
              child: Text('Lanjut'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 208, 78),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.2,
                  vertical: screenWidth * 0.05,
                ),
                textStyle: TextStyle(
                  fontSize: screenWidth * 0.04,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeteranganItem(IconData icon, String title, String description, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.025),
      child: Row(
        children: [
          Icon(icon, size: screenWidth * 0.075),
          SizedBox(width: screenWidth * 0.025),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold)),
                Text(description, style: TextStyle(fontSize: screenWidth * 0.035)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BuatSaluranPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Buat saluran', style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.05)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenWidth * 0.05),
            CircleAvatar(
              radius: screenWidth * 0.125,
              backgroundColor: Colors.grey.shade300,
              child: Icon(Icons.add_photo_alternate, size: screenWidth * 0.125, color: const Color.fromARGB(255, 251, 210, 74)),
            ),
            SizedBox(height: screenWidth * 0.05),
            TextField(
              decoration: InputDecoration(
                hintText: 'Nama saluran',
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: screenWidth * 0.05),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Beri penjelasan tentang saluran Anda. Menyertakan deskripsi akan membantu pengikut.',
                border: OutlineInputBorder(),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SaluranCreatedPage()),
                );
              },
              child: Text('Buat saluran'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 213, 85),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.2,
                  vertical: screenWidth * 0.05,
                ),
                textStyle: TextStyle(
                  fontSize: screenWidth * 0.04,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SaluranCreatedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Nama Saluran', style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.05)),
        actions: [
          IconButton(
            icon: Icon(Icons.link, color: Colors.black),
            onPressed: () {
              // Define your link button function here
            },
          ),
          PopupMenuButton<String>(
            onSelected: (String value) {
              switch (value) {
                case 'info saluran':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InfoSaluranPage(),
                    ),
                  );
                  break;
                case 'setelan saluran':
                  // Handle 'setelan saluran'
                  break;
                case 'bagikan':
                  // Handle 'bagikan'
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return {'info saluran', 'setelan saluran', 'bagikan'}
                  .map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenWidth * 0.05),
            CircleAvatar(
              radius: screenWidth * 0.125,
              backgroundColor: Colors.grey.shade300,
              child: Icon(Icons.add_photo_alternate, size: screenWidth * 0.125, color: const Color.fromARGB(255, 251, 210, 74)),
            ),
            SizedBox(height: screenWidth * 0.05),
            Text(
              'Deskripsi saluran',
              style: TextStyle(fontSize: screenWidth * 0.045),
            ),
            SizedBox(height: screenWidth * 0.05),
            Container(
              color: const Color(0xFFF9F9F9),
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Buat postingan', style: TextStyle(fontSize: screenWidth * 0.04)),
                  IconButton(
                    icon: Icon(Icons.edit, color: const Color.fromARGB(255, 251, 210, 74)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BuatPostinganPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: screenWidth * 0.05),
            Container(
              color: const Color(0xFFF9F9F9),
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Setelan saluran', style: TextStyle(fontSize: screenWidth * 0.04)),
                  IconButton(
                    icon: Icon(Icons.settings, color: const Color.fromARGB(255, 251, 210, 74)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SetelanSaluranPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoSaluranPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Info Saluran', style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.05)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenWidth * 0.05),
            CircleAvatar(
              radius: screenWidth * 0.125,
              backgroundColor: Colors.grey.shade300,
              child: Icon(Icons.add_photo_alternate, size: screenWidth * 0.125, color: const Color.fromARGB(255, 251, 210, 74)),
            ),
            SizedBox(height: screenWidth * 0.05),
            Text(
              'Info tentang saluran',
              style: TextStyle(fontSize: screenWidth * 0.045),
            ),
            SizedBox(height: screenWidth * 0.05),
            Text(
              'Deskripsi lengkap tentang saluran ini.',
              style: TextStyle(fontSize: screenWidth * 0.04),
            ),
            SizedBox(height: screenWidth * 0.05),
            Text(
              'Pemilik: Nama Pemilik',
              style: TextStyle(fontSize: screenWidth * 0.04),
            ),
            SizedBox(height: screenWidth * 0.05),
            Text(
              'Jumlah Pengikut: 123',
              style: TextStyle(fontSize: screenWidth * 0.04),
            ),
            SizedBox(height: screenWidth * 0.05),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Kembali'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 213, 85),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.2,
                  vertical: screenWidth * 0.05,
                ),
                textStyle: TextStyle(
                  fontSize: screenWidth * 0.04,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuatPostinganPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Buat Postingan', style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.05)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenWidth * 0.05),
            TextField(
              decoration: InputDecoration(
                hintText: 'Tulis sesuatu...',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Handle posting creation
              },
              child: Text('Posting'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 213, 85),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.2,
                  vertical: screenWidth * 0.05,
                ),
                textStyle: TextStyle(
                  fontSize: screenWidth * 0.04,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SetelanSaluranPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Setelan Saluran', style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.05)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenWidth * 0.05),
            Text(
              'Pengaturan saluran',
              style: TextStyle(fontSize: screenWidth * 0.045),
            ),
            SizedBox(height: screenWidth * 0.05),
            Text(
              'Atur preferensi dan pengaturan saluran Anda di sini.',
              style: TextStyle(fontSize: screenWidth * 0.04),
            ),
            SizedBox(height: screenWidth * 0.05),
            // Add your settings options here
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Simpan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 213, 85),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.2,
                  vertical: screenWidth * 0.05,
                ),
                textStyle: TextStyle(
                  fontSize: screenWidth * 0.04,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}