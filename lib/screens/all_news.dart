import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_hive/screens/detail_news.dart';
import 'package:flutter_hive/screens/notifikasi.dart';
import 'package:http/http.dart' as http;

class AllNews extends StatefulWidget {
  const AllNews({super.key});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  List _posts = [];
  bool _isLoading = false; // State variable for loading

  @override
  void initState() {
    super.initState();
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
                // Handle navigation to Profile
              },
            ),
            ListTile(
              title: const Text('Notifikasi'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Notifikasi()));
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(), // Show loading indicator
            )
          : RefreshIndicator(
              onRefresh: _getData, // Refresh data on pull down
              child: ListView.builder(
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      color: Colors.grey[300],
                      height: 100,
                      width: 100,
                      child: _posts[index]['image'] != null
                          ? Image.network(
                              _posts[index]['image'],
                              width: 100,
                              fit: BoxFit.cover,
                            )
                          : Center(),
                    ),
                    title: Text(
                      '${_posts[index]['title']}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      '${_posts[index]['contentSnippet']}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) => DetailNews(
                            link: _posts[index]['link'],
                            title: _posts[index]['title'],
                            contentSnippet: _posts[index]['contentSnippet'],
                            isoDate: _posts[index]['isoDate'],
                            // author: _posts[index]['author'],
                            image: _posts[index]['image'],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
    );
  }
}
