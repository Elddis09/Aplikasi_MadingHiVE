import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_hive/screens/LamanSaluran.dart';
import 'package:flutter_hive/screens/all_news.dart';
import 'package:flutter_hive/screens/detail_news.dart';
import 'package:flutter_hive/screens/mading_detail.dart';
import 'package:flutter_hive/screens/notifikasi.dart';
import 'package:flutter_hive/screens/profileAtampilan.dart';
import 'package:flutter_hive/screens/teman.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter_hive/screens/all_mading.dart';

class BerandaMading extends StatefulWidget {
  BerandaMading({Key? key}) : super(key: key);

  @override
  _BerandaMadingState createState() => _BerandaMadingState();
}

class _BerandaMadingState extends State<BerandaMading> {
  final String url = 'http://192.168.209.245:8000/api/mading';
  DateTime? _fetchTime;
  bool showAll = false;
  bool _isLoading = false;
  List _posts = [];
  late Future<List<dynamic>> futureMading;

  @override
  void initState() {
    super.initState();
    _fetchTime = DateTime.now();
    futureMading = getMading();
    _getData();
  }

  Future<void> _getData() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });
    try {
      final Uri url = Uri.parse(
          'https://berita-indo-api-next.vercel.app/api/tribun-news/jakarta/');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _posts = data['data'];
          _isLoading = false; // Hide loading indicator
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false; // Hide loading indicator in case of error
      });
    }
  }

  Future<List<dynamic>> getMading() async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responseBody = response.body;

        // Tambahkan logging untuk memeriksa data JSON yang diterima
        print('Response Body: $responseBody');

        var data = json.decode(responseBody);
        _fetchTime =
            DateTime.now(); // Update fetch time each time data is fetched

        List<dynamic> madingList = data['data'];

        // Mengurutkan data berdasarkan tanggal dari terbaru ke terlama
        madingList.sort((a, b) {
          DateTime dateA = DateTime.parse(a['tanggal']);
          DateTime dateB = DateTime.parse(b['tanggal']);
          return dateB.compareTo(dateA);
        });

        return madingList;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e'); // Tambahkan logging untuk kesalahan
      throw Exception('Failed to load data: $e');
    }
  }

  void _showAllData() {
    setState(() {
      showAll = true;
    });
  }

  void _updateMadingList() {
    setState(() {
      futureMading = getMading();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFD700),
        elevation: 0,
        title: SizedBox(
          height: 40,
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              hintText: 'Search',
              prefixIcon: const Icon(Icons.search, color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      'assets/images/logo_sidebar.png', // Path to your local image
                      height: 50,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfillAtampilan(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Notifikasi'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Notifikasi(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Saluran'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LamanSaluran(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Teman'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FriendshipScreen(),
                    ));
              },
            ),
            ListTile(
              title: const Text('Kotak Saran'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Keluar'),
              onTap: () {
                // Handle logout
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.facebook),
                    onPressed: () {
                      // Handle Facebook link
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite),
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
      body: FutureBuilder<List<dynamic>>(
        future: futureMading,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data found'));
          } else {
            List<dynamic> dataToShow =
                showAll ? snapshot.data! : snapshot.data!.take(5).toList();
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: const Color(0xFFFFD700),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/images/beranda_hero.png', // Path to your local image
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'PENGUMUMAN TERBARU',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () async {
                            var result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllMading()),
                            );
                            if (result != null) {
                              _updateMadingList();
                            }
                          },
                          child: const Text(
                            'Lainnya',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: dataToShow.length,
                    itemBuilder: (context, index) {
                      var madingItem = dataToShow[index];
                      var imageUrl = madingItem['image_url'];
                      var tanggal = madingItem['tanggal'];
                      var formattedDate = '';

                      if (tanggal != null) {
                        try {
                          var parsedDate = DateTime.parse(tanggal);
                          formattedDate =
                              DateFormat('d MMMM yyyy').format(parsedDate);
                        } catch (e) {
                          formattedDate = tanggal;
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    var result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MadingDetail(
                                                mading: madingItem,
                                              )),
                                    );
                                    if (result != null) {
                                      _updateMadingList();
                                    }
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      imageUrl ?? '',
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return const Icon(Icons.error);
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        madingItem['judul'] ?? '',
                                        maxLines: 2,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        madingItem['pretext'] ?? '',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        formattedDate,
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'COMINGSOON',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    color: const Color(0xFFFFD700),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          SizedBox(
                            width: 200,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/kotak saran.jpg',
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return const Icon(Icons.error);
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 200,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/saluran.png',
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return const Icon(Icons.error);
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 200,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/teman.png',
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return const Icon(Icons.error);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'BERITA TERKINI',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllNews()),
                            );
                          },
                          child: const Text(
                            'Lainnya',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _posts.length > 3 ? 3 : _posts.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (c) => DetailNews(
                                link: _posts[index]['link'],
                                title: _posts[index]['title'],
                                contentSnippet: _posts[index]['contentSnippet'],
                                isoDate: _posts[index]['isoDate'],
                                image: _posts[index]['image'],
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: _posts[index]['image'] != null
                                        ? Image.network(
                                            _posts[index]['image'],
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          )
                                        : const SizedBox.shrink(),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${_posts[index]['title']}',
                                          maxLines: 2,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          '${_posts[index]['contentSnippet']}',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // Nama Saluran Section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'NAMA SALURAN',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            // Determine card width based on screen size
                            double cardWidth = constraints.maxWidth / 3 - 16;
                            if (constraints.maxWidth < 600) {
                              cardWidth = constraints.maxWidth / 2 - 16;
                            }
                            return SizedBox(
                              height: 250,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    5, // Ganti dengan jumlah saluran yang Anda miliki
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ChannelCard(
                                      channelName: 'Nama Saluran $index',
                                      status: 'Status',
                                      cardWidth: cardWidth,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class ChannelCard extends StatelessWidget {
  final String channelName;
  final String status;
  final double cardWidth;

  const ChannelCard({
    required this.channelName,
    required this.status,
    required this.cardWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                // Aksi untuk tombol close
              },
            ),
          ),
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.yellow[100],
          ),
          const SizedBox(height: 10),
          Text(
            channelName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(status),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Aksi untuk tombol Gabung
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFD700),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Gabung'),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: BerandaMading(),
  ));
}
