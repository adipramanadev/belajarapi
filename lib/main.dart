import 'dart:convert';

import 'package:belajarapi/tambah.dart';

import 'detailpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

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

  // @override
  // void initState() {
  //   super.initState();
  //   getData();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "API",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
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
                      setState(() {
                        users.removeAt(index);
                        //kasih function delete
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Users deleted successfully'),
                        ),
                      );
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
