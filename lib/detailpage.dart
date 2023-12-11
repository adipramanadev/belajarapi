import 'package:flutter/material.dart';

import 'editpage.dart';

class DetailPage extends StatefulWidget {
  final Map<String, dynamic> user;
  int index;
  DetailPage({required this.user, required this.index});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          widget.user['users_nm'],
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('ID: ${widget.user['users_id']}'),
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        EditPage(user: widget.user, index: widget.index),
                  ),
                ),
                icon: Icon(
                  Icons.edit,
                  color: Colors.yellow,
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
