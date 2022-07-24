import 'dart:math';

import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class SignUpPage extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var usernameController =  TextEditingController();
  var cardHaving = TextEditingController();
  String locationController = "";
  String descriptionController = "";
  String profilePicController = "";

  SignUpPage({Key? key}) : super(key: key);

  //build sign up page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center (
        child: SingleChildScrollView (
          child: Column (
              children: <Widget>[
                Image.asset(
                    'assets/secret-societies.jpg'
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: const Text (
                    "Hello!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin:
                  const EdgeInsets.only(left: 35, right: 35, top: 16, bottom: 10),
                  child: TextField(
                    controller: emailController,
                    obscureText: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  margin:
                  const EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                  margin:
                  const EdgeInsets.only(left: 35, right: 35, top: 16, bottom: 10),
                  child: TextField(
                    controller: usernameController,
                    obscureText: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 20),
                  width: 200,
                  height: 40,
                  child: ElevatedButton(
                      child: const Text('Sign Up!'),
                      onPressed: () {
                        // get the email and password typed
                        print(emailController.text);
                        print(passwordController.text);
                        // deliver the materials to Google Firebase
                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailController.text, password: passwordController.text)
                            .then((authResult){
                          print("Successfully signed up UID! UID: ${authResult.user!.uid}");

                          var userProfile =  {
                            'uid': authResult.user!.uid,
                            'email': emailController.text,
                            'password': passwordController.text,
                            'username': usernameController.text,
                            'timeRemain':24,
                            'secretNumber': Random().nextInt(89989) +1000
                          };
                          FirebaseDatabase.instance.ref().child("friends/${authResult.user!.uid}").set({
                            "N66Wx0S1bjk9D39V4lH": "true",
                            authResult.user!.uid: "true",
                          });

                          FirebaseDatabase.instance.ref().child("users/${authResult.user!.uid}")
                              .set(userProfile)
                              .then((value) {
                            print("Successfully created a portfolio");
                          }).catchError((error) {
                            print("Failed to create a portfolio");
                          });
                          Navigator.pop(context);
                        }).catchError((error){
                          print("Failed to sign up!");
                          print(error.toString());
                        });
                      }
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}