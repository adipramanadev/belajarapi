import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  //deklarasi variabel TextField
  TextEditingController _txtNama = TextEditingController();
  TextEditingController _txtEmail = TextEditingController();
  TextEditingController _txtPassword = TextEditingController();

  //function future
  void tambahData(
      String users_nm, String users_email, String users_pass) async {
    String apiUrl = "https://dev-api.arminadaily.id/mobiledev/create/";
    String key = "TESTING";
    http.post(
      Uri.parse(apiUrl),
      headers: {
        'Accept': 'application/json',
        'adsignature': '$key',
      },
      body: {
        'users_nm': _txtNama.text,
        'users_email': _txtEmail.text,
        'users_pass': _txtPassword.text,
      },
    ).then((response) {
      print('Reponse status: ${response.statusCode}');
      print('Reponse body: ${response.body}');
    });
  }

  //show hide password
  bool _secureText = true;
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TAMBAH DATA",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.only(top: 62, left: 12, right: 12),
          children: [
            Container(
              height: 50.0,
              child: TextField(
                controller: _txtNama,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  labelText: "Nama",
                  hintText: "Masukkan Nama",
                  icon: Icon(Icons.person),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50.0,
              child: TextField(
                controller: _txtEmail,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  labelText: "Email",
                  hintText: "Masukkan Email",
                  icon: Icon(Icons.mail),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50.0,
              child: TextField(
                controller: _txtPassword,
                obscureText: _secureText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  labelText: "Password",
                  hintText: "Masukkan Password",
                  icon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      showHide();
                    },
                    icon: Icon(
                        _secureText ? Icons.visibility_off : Icons.visibility),
                  ),
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
                tambahData(
                  _txtNama.text.trim(),
                  _txtEmail.text.trim(),
                  _txtPassword.text.trim(),
                );
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => HomePage()),
                  ),
                );
              },
              child: Text(
                'TAMBAH DATA',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
