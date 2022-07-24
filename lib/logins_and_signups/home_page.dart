import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:secret_mission_app/logins_and_signups/signup_page.dart';
import 'package:secret_mission_app/profile_screen.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //crafting login page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        body: Center(
          child: SingleChildScrollView (
            child: Column(
              children: <Widget> [
                Image.asset('assets/Top-Secret.jpg',scale: 2),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white24
                    ),
                  ),
                ),
                Container(
                  margin:
                  const EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
                  child: TextField(
                    controller: emailController,
                    obscureText: false,
                    decoration: const InputDecoration(
                      border:  OutlineInputBorder(),
                      labelText: 'Email',
                      filled: true,
                      fillColor: Colors.white70,
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
                      filled: true,
                      fillColor: Colors.white70,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 20),
                  width: 200,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.amberAccent,
                      ),
                      onPressed: () {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text)
                            .then((value) {
                          //return value;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  ProfileScreen()),
                          );
                        }).catchError((error) {
                          return error;
                        });
                      },
                      child: const Text('Log In')
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: const Text(
                    "Create new Account",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}




