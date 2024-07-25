import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_hive/screens/mading_detail.dart';
import 'package:flutter_hive/screens/notifikasi.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AllMading extends StatefulWidget {
  const AllMading({super.key});

  @override
  _AllMadingState createState() => _AllMadingState();
}

class _AllMadingState extends State<AllMading> {
  final String url = 'http://192.168.209.245:8000/api/mading';
  DateTime? _fetchTime;
  late Future<List<dynamic>> _madingList;

  @override
  void initState() {
    super.initState();
    _fetchTime = DateTime.now();
    _madingList = getMading();
  }

  Future<List<dynamic>> getMading() async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
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
      throw Exception('Failed to load data: $e');
    }
  }

  Future<void> deleteMading(String madingId) async {
    String deleteUrl = 'http://192.168.209.245:8000/api/mading/' + madingId;
    try {
      var response = await http.delete(Uri.parse(deleteUrl));
      if (response.statusCode == 200) {
        setState(() {
          _madingList = getMading(); // Refresh the list after deletion
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Mading Deleted!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  "Failed to delete Mading. Status Code: ${response.statusCode}")),
        );
        print('Failed to delete Mading. Status Code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to delete Mading. Error: $e")),
      );
      print('Failed to delete Mading. Error: $e');
    }
  }

  void _refreshMadingList() {
    setState(() {
      _madingList = getMading();
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
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      'assets/images/logo_sidebar.png',
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
                // Handle navigation to Profile
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
                // Handle navigation to Saluran
              },
            ),
            ListTile(
              title: const Text('Teman'),
              onTap: () {
                // Handle navigation to Teman
              },
            ),
            ListTile(
              title: const Text('Kotak Saran'),
              onTap: () {
                // Handle navigation to Kotak Saran
              },
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
        future: _madingList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var madingItem = snapshot.data![index];
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

                return Container(
                  height: 150,
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          if (imageUrl != null && imageUrl.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MadingDetail(
                                      mading: madingItem,
                                    ),
                                  ),
                                ).then((_) {
                                  _refreshMadingList(); // Refresh the list when returning from detail page
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                height: 120,
                                width: 120,
                                child: Image.network(
                                  fit: BoxFit.cover,
                                  imageUrl,
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return const Icon(Icons.error);
                                  },
                                ),
                              ),
                            )
                          else
                            const Icon(Icons.image_not_supported),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data![index]['judul'],
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  snapshot.data![index]['pretext'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                                Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (formattedDate.isNotEmpty)
                                      Text(
                                        'Uploaded on $formattedDate',
                                      ),
                                    GestureDetector(
                                      onTap: () {
                                        deleteMading(snapshot.data![index]['id']
                                            .toString());
                                      },
                                      child: const Icon(Icons.delete,
                                          color: Colors.red),
                                    ),
                                  ],
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
            );
          }
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AllMading(),
  ));
}
