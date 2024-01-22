import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'detailpage.dart';
import 'tambah.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //deklarasi variabel
  final String apiUrl = "https://dev-api.arminadaily.id/mobiledev/getall/";
  final String token = "TESTING";

  //function future
  Future getData() async {
    final response = await http.get(Uri.parse(apiUrl), headers: {
      'adsignature': '$token',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == 'true' && data['responseCode'] == '00') {
        // print(data['data']);?
        return data['data'];
      } else {
        print('ga tampil');
      }
    }
  }

  //delete function
  Future<void> deleteData(String key_code) async {
    final String deleteUrl = "https://dev-api.arminadaily.id/mobiledev/delete/";
    final response = await http.post(Uri.parse(deleteUrl), body: {
      'key_code': '$key_code'
    }, headers: {
      'Accept': 'application/json',
      'adsignature': '$token',
    });

    //response status
    if (response.statusCode == 200) {
      // Map<String, dynamic> data = json.decode(response.body);
      print("Data deleted successfully");
    } else {
      print("Data deleted failed");
    }
  }

  String? userEmail = '';
  @override
  void initState() {
    super.initState();
    _loadUserEmail();
  }

  Future<void> _loadUserEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = json.decode(prefs.getString('userData')!)['users_email'];
    setState(() {
      userEmail = email ?? "Email tidak ditemukan";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Email : $userEmail",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddPage()));
          },
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.blue),
      body: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<dynamic> users = snapshot.data;
            return ListView.builder(
                itemBuilder: (context, index) {
                  Map<String, dynamic> user = users[index];
                  return Dismissible(
                    key: Key(user['users_id'].toString()),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20.0),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      deleteData(user['key_code'].toString()).then((_) {
                        setState(() {
                          users.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Users deleted successfully'),
                          ),
                        );
                      }).catchError((error) {
                        print('Error: $error');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to delete user'),
                          ),
                        );
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          //detail page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(user: user, index: index),
                            ),
                          );
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(user['users_nm']),
                            subtitle: Text(user['users_status'].toString()),
                            leading: Icon(Icons.apps),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: users.length);
          }
        },
      ),
    );
  }
}
