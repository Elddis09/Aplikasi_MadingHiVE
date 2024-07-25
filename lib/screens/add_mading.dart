import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hive/screens/berandaMading.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_hive/screens/all_mading.dart';

class AddMading extends StatefulWidget {
  @override
  _AddMadingState createState() => _AddMadingState();
}

class _AddMadingState extends State<AddMading> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _pretextController = TextEditingController();
  final TextEditingController _keteranganController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  File? _image;

  Future saveMading() async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://192.168.209.245:8000/api/mading/'));

      request.fields['judul'] = _judulController.text;
      request.fields['pretext'] = _pretextController.text;
      request.fields['keterangan'] = _keteranganController.text;
      request.fields['tanggal'] = _tanggalController.text;

      if (_image != null) {
        print('Image Path: ${_image!.path}');
        var imageFile =
            await http.MultipartFile.fromPath('image_url', _image!.path);
        request.files.add(imageFile);
      } else {
        print('No image selected.');
      }

      var response = await request.send();

      if (response.statusCode == 201) {
        final responseData = await response.stream.bytesToString();
        final jsonData = json.decode(responseData);
        print('Response Data: $jsonData');
        return jsonData;
      } else {
        print('Failed to save mading: ${response.statusCode}');
        final responseData = await response.stream.bytesToString();
        print('Response Data: $responseData');
        return null;
      }
    } catch (e) {
      print('Error: $e');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Mading'),
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
                      return 'Masukkan keterangan Mading';
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
                  onTap: () {
                    _selectDate();
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _pickImage();
                  },
                  child: Text(_image == null
                      ? 'Pilih Gambar dari Galeri'
                      : 'Gambar Dipilih'),
                ),
                if (_image != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Image.file(
                      _image!,
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(height: 20),
               ElevatedButton(
  onPressed: () {
    if (_formKey.currentState!.validate()) {
      saveMading().then((value) => {
            if (value != null)
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllMading(),
                  ),
                ).then((_) {
                  // After navigating back from AllMading, go to BerandaMading
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => BerandaMading()),
                    (Route<dynamic> route) => false,
                  );
                })
              }
            else
              {
                print('Failed to save mading.')
              }
          }).catchError((error) {
        print('Error in saveMading: $error');
      });
    }
  },
  child: const Text('Save'),
),

              ],
            ),
          ),
        ),
      ),
    );
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
}
