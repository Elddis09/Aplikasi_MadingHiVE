import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_hive/screens/mading_detail.dart';

class EditMading extends StatefulWidget {
  final Map mading;

  const EditMading({Key? key, required this.mading}) : super(key: key);

  @override
  _EditMadingState createState() => _EditMadingState();
}

class _EditMadingState extends State<EditMading> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _judulController;
  late TextEditingController _pretextController;
  late TextEditingController _keteranganController;
  late TextEditingController _tanggalController;
  File? _image;
  late String _oldImageUrl;

  @override
  void initState() {
    super.initState();
    _judulController = TextEditingController(text: widget.mading['judul']);
    _pretextController = TextEditingController(text: widget.mading['pretext']);
    _keteranganController =
        TextEditingController(text: widget.mading['keterangan']);
    _tanggalController =
        TextEditingController(text: widget.mading['tanggal'] ?? '');
    _oldImageUrl = widget.mading['image_url'] ?? '';
  }

  @override
  void dispose() {
    _judulController.dispose();
    _pretextController.dispose();
    _keteranganController.dispose();
    _tanggalController.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>?> updateMading() async {
    try {
      var uri = Uri.parse('http://192.168.209.245:8000/api/mading/' +
          widget.mading['id'].toString());

      var request = http.Request('PUT', uri);

      // Menambahkan body JSON jika diperlukan
      request.body = json.encode({
        'judul': _judulController.text,
        'pretext': _pretextController.text,
        'keterangan': _keteranganController.text,
        'tanggal':
            _tanggalController.text.isNotEmpty ? _tanggalController.text : null,
      });

      // Jika Anda perlu menambahkan header JSON
      request.headers['Content-Type'] = 'application/json';

      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = await response.stream.bytesToString();
        final jsonData = json.decode(responseData);
        print('Response Data: $jsonData');
        print('Response Data Type: ${jsonData.runtimeType}');

        if (jsonData != null && jsonData is Map<String, dynamic>) {
          return jsonData;
        } else {
          // Tangani kasus ketika jsonData tidak valid
          print('Invalid data received from server.');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invalid data received from server.')),
          );
          return null;
        }
      } else {
        // Tangani kasus ketika statusCode bukan 200 atau 201
        print('Failed to load data from server.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load data from server.')),
        );
        return null;
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
      return null;
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _tanggalController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Mading'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _judulController,
                  decoration: InputDecoration(
                    labelText: 'Judul',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Judul Mading';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _pretextController,
                  decoration: InputDecoration(
                    labelText: 'Pretext',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Pretext Mading';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _keteranganController,
                  decoration: InputDecoration(
                    labelText: 'Keterangan',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Keterangan Mading';
                    }
                    return null;
                  },
                ),
                TextField(
                  controller: _tanggalController,
                  decoration: InputDecoration(
                    labelText: 'Tanggal',
                    filled: true,
                    prefixIcon: Icon(Icons.calendar_today),
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  readOnly: true,
                  onTap: _selectDate,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text(_image == null && _oldImageUrl.isEmpty
                      ? 'Pilih Gambar dari Galeri'
                      : 'Gambar Dipilih'),
                ),
                const SizedBox(height: 20),
                if (_image != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Image.file(
                      _image!,
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  )
                else if (_oldImageUrl.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Image.network(
                      _oldImageUrl,
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var updatedData = await updateMading();
                      print('Updated Data: $updatedData'); // Debug print
                      if (updatedData != null) {
                        Navigator.pop(context, updatedData['data']);
                      }
                    }
                  },
                  child: const Text('Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String formatDate(String? date) {
  if (date == null || date.isEmpty) {
    return 'Tanggal tidak tersedia';
  }
  // Proses format tanggal seperti biasa
  return DateFormat('yyyy-MM-dd').format(DateTime.parse(date));
}
