import 'package:flutter/material.dart';
import 'package:flutter_hive/screens/notifikasi.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailNews extends StatelessWidget {
  const DetailNews({
    Key? key,
    this.link,
    this.title,
    this.contentSnippet,
    // this.author,
    this.isoDate,
    this.image,
  }) : super(key: key);

  final String? link;
  final String? title;
  final String? contentSnippet;
  // final String? author;
  final String? isoDate;
  final String? image;

  Future<void> _launchUrl(String? url) async {
    if (url != null && await canLaunch(url)) {
      await launch(url);
    } else {
      throw Exception('Could not launch $url');
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
      body: Column(children: <Widget>[
        image != null
            ? Image.network(image!)
            : Container(
                height: 250,
                color: const Color(0xFFFFD700),
              ),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '$title',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text('$isoDate', style: TextStyle(fontStyle: FontStyle.italic)),
                SizedBox(height: 5),
                Text('$contentSnippet'),
                Divider(),
                link != null
                    ? TextButton(
                        onPressed: () => _launchUrl(link),
                        child: Text('Read More'),
                      )
                    : Container(),
              ],
            ))
      ]),
    );
  }
}
