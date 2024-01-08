import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  //function login
  Future<void> login(String email, String password) async {
    String token = "TESTING";
    var url = "https://dev-api.arminadaily.id/mobiledev/auth/";
    var response = await http.post(
      Uri.parse(url),
      headers: {
        "token": "$token",
      },
      body: {
        'users_email': email,
        'users_pass': password,
      },
    );
    //status response
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['status'] == 'true' && data['responseCode'] == '00') {
        //login sukses
        print("login Sukses: $data['data]");
      } else {
        print("Error: $response.reasonPharase");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -60,
            left: -60,
            child: CircleAvatar(
              radius: 100,
              backgroundColor: Colors.blue,
            ),
          ),
          Positioned(
            bottom: -90,
            right: -60,
            child: CircleAvatar(
              radius: 100,
              backgroundColor: Colors.blue,
            ),
          ),
          Positioned(
            bottom: 40,
            left: 20,
            child: Icon(
              Icons.scatter_plot,
              size: 100,
              color: Colors.purple[400],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: Colors.blue),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: txtEmail,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                      hintText: "Masukkan Email Anda ...",
                      isDense: true,
                      prefixIcon: Icon(
                        Icons.email,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: txtPassword,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                      hintText: "Masukkan Password Anda ...",
                      isDense: true,
                      prefixIcon: Icon(
                        Icons.lock,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      login(txtEmail.text, txtPassword.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: Text(
                      "Login ",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
