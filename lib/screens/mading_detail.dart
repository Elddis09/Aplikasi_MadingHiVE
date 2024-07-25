import 'package:flutter/material.dart';
import 'package:flutter_hive/screens/add_mading.dart';
import 'package:flutter_hive/screens/edit_mading.dart';
import 'package:flutter_hive/screens/notifikasi.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class MadingDetail extends StatefulWidget {
  final Map<String, dynamic> mading;

  MadingDetail({required this.mading});

  @override
  _MadingDetailState createState() => _MadingDetailState();
}

class _MadingDetailState extends State<MadingDetail> {
  late Map<String, dynamic> mading;

  @override
  void initState() {
    super.initState();
    mading = widget.mading;
  }

  String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) {
      return 'Tanggal tidak tersedia';
    }
    try {
      final dateTime = DateTime.parse(dateStr);
      return DateFormat('dd MMMM yyyy').format(dateTime);
    } catch (e) {
      return dateStr; // Fallback jika tanggal tidak dapat diparsing
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMading()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue, // Better visibility for the FAB
      ),
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
                  MaterialPageRoute(builder: (context) => Notifikasi()),
                );
              },
            ),
            ListTile(
              title: const Text('Mading'),
              onTap: () {
                // Handle navigation to Mading
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
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, mading);
          return false;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity, // Ensure image takes full width
                  child: mading['image_url'] != null &&
                          mading['image_url'].isNotEmpty
                      ? Image.network(
                          mading['image_url'],
                          fit: BoxFit.cover,
                          key: ValueKey(mading[
                              'image_url']), // Add a unique key to force reload
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                                Icons.error); // Handle image loading error
                          },
                        )
                      : const Icon(
                          Icons.image_not_supported), // Placeholder if no image
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formatDate(mading['tanggal'] ??
                              ''), // Gunakan string kosong jika null
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                        ),
                        const Text('Dipublikasikan oleh kesiswaan'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.favorite, color: Colors.red),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () async {
                            var result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditMading(mading: mading)),
                            );
                            print('Result Data: $result'); // Debug print
                            if (result != null &&
                                result is Map<String, dynamic>) {
                              setState(() {
                                mading = result;
                              });
                            }
                          },
                          child: const Icon(Icons.edit, color: Colors.blue),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  mading['judul'] ?? '', // Gunakan string kosong jika null
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  mading['keterangan'] ?? '', // Gunakan string kosong jika null
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
