import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final Map<String, dynamic> user;
  final int index;

  EditPage({required this.user, required this.index, super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
