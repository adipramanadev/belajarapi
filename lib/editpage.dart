import 'package:flutter/material.dart';

import 'main.dart';
import 'package:http/http.dart' as http;

class EditPage extends StatefulWidget {
  final Map<String, dynamic> user; //array
  final int index; //id

  EditPage({required this.user, required this.index, super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController _txtNama = TextEditingController();
  TextEditingController _txtEmail = TextEditingController();
  TextEditingController _txtPassword = TextEditingController();

  //edit data
  void editData(String keyCode, String users_nm, String users_email) {
    String apiUrl = "https://dev-api.arminadaily.id/mobiledev/update/$keyCode";
    String key = "TESTING";
    http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
      'adsignature': '$key',
    }, body: {
      'users_nm': _txtNama.text,
      'users_email': _txtEmail.text,
    }).then((response) {
      print('Reponse status: ${response.statusCode}');
      print('Reponse body: ${response.body}');
    });
  }

  //muncul data
  @override
  void initState() {
    super.initState();
    _txtNama.text = widget.user['users_nm'];
    _txtEmail.text = widget.user['users_email'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          widget.user['users_nm'],
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.only(top: 20, left: 12, right: 12),
          children: [
            Container(
              height: 50.0,
              child: TextField(
                controller: _txtNama,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  labelText: 'User Name',
                  hintText: 'Masukkan Nama',
                  icon: Icon(Icons.person),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: 50.0,
              child: TextField(
                controller: _txtEmail,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  labelText: 'Email',
                  hintText: 'Masukkan Email',
                  icon: Icon(Icons.mail),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: 50.0,
              child: TextField(
                controller: _txtPassword,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  labelText: 'Password',
                  hintText: 'Password',
                  icon: Icon(Icons.lock),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => HomePage()),
                  ),
                );
              },
              child: Text(
                'Edit DATA',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
