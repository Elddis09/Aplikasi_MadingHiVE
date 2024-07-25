import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FriendshipScreen extends StatefulWidget {
  @override
  _FriendshipScreenState createState() => _FriendshipScreenState();
}

class _FriendshipScreenState extends State<FriendshipScreen> {
  List<String> users = ['User 1', 'User 2', 'User 3']; // Daftar nama pengguna
  List<bool> isFollowing = [
    false,
    false,
    false
  ]; // Daftar status follow/unfollow
  late List<String> filteredUsers;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredUsers = users;
  }

  void toggleFollow(int index) {
    setState(() {
      isFollowing[index] = !isFollowing[index];
    });
  }

  void filterSearch(String query) {
    List<String> dummySearchList = List.from(users);
    if (query.isNotEmpty) {
      List<String> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        filteredUsers = dummyListData;
      });
      return;
    } else {
      setState(() {
        filteredUsers = users;
      });
    }
  }

  void navigateToProfile(String user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen(user: user)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pertemanan',
          style: GoogleFonts.getFont(
            'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 254, 199, 46),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                filterSearch(value);
              },
              decoration: InputDecoration(
                labelText: 'Cari Teman',
                hintText: 'Masukkan nama teman',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(13.0)),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                String user = filteredUsers[index];
                int userIndex = users.indexOf(user);
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/user_$userIndex.png'),
                  ),
                  title: GestureDetector(
                    onTap: () => navigateToProfile(user),
                    child: Text(
                      user,
                      style: GoogleFonts.getFont(
                        'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  trailing: ElevatedButton(
                    onPressed: () => toggleFollow(userIndex),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isFollowing[userIndex] ? Colors.red : Colors.green,
                    ),
                    child: Text(
                      isFollowing[userIndex] ? 'Unfollow' : 'Follow',
                      style: GoogleFonts.getFont(
                        'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final String user;

  ProfileScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    int userIndex = int.parse(user.split(' ')[1]) - 1;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$user\'s Profile',
          style: GoogleFonts.getFont(
            'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 226, 79),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                    AssetImage('assets/images/user_$userIndex.png'),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Nama Lengkap: $user',
              style: GoogleFonts.getFont(
                'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Kelas: 12A',
              style: GoogleFonts.getFont(
                'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Keterangan Lainnya:',
              style: GoogleFonts.getFont(
                'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '1. Anggota klub basket',
              style: GoogleFonts.getFont(
                'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 5),
            Text(
              '2. Juara Olimpiade Matematika',
              style: GoogleFonts.getFont(
                'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 5),
            Text(
              '3. Ketua OSIS',
              style: GoogleFonts.getFont(
                'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FriendshipScreen(),
  ));
}