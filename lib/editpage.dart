import 'package:flutter/material.dart';

import 'main.dart';

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
                controller: _txtPassword,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  labelText: 'Password',
                  hintText: 'Password',
                  icon: Icon(Icons.person),
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
