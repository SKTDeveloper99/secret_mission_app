import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:secret_mission_app/test1.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({ Key? key }) : super(key: key);
  final ref = FirebaseDatabase.instance.ref().child("users/${FirebaseAuth.instance.currentUser!.uid}"); ///${FirebaseAuth.instance.currentUser!.uid}
  final emailController = TextEditingController();


  final Stream generateNumbers = (() async* {
    //await Future<void>.delayed(const Duration(seconds: 2));
      while(true) {
        await Future<void>.delayed(const Duration(milliseconds: 1));
        int love = 1658893800000 - DateTime.now().millisecondsSinceEpoch;
        yield love;
      }
  })();

  @override
  Widget build(BuildContext context) {
    //print(DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch).millisecondsSinceEpoch);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Flutter StreamBuilder Demo'),
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text("data"),
            ),
            Padding(
              padding: const EdgeInsets.all(2),
              child: StreamBuilder(
                stream: generateNumbers,
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                         CircularProgressIndicator(),
                      ],
                    );
                  } else if (snapshot.connectionState == ConnectionState.active
                      || snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                      int day = Duration(milliseconds: snapshot.data!.toInt()).inDays;
                      int hour = Duration(milliseconds: snapshot.data!.toInt() - Duration(days: day).inMilliseconds).inHours;
                      int minutes1 = Duration(milliseconds: snapshot.data!.toInt() - Duration(days: day).inMilliseconds).inMinutes - 60 * hour;
                      int seconds1 = Duration(milliseconds: snapshot.data!.toInt() - Duration(days: day).inMilliseconds).inSeconds - 3600 * hour - 60 * minutes1;
                      return StreamBuilder(
                        stream: ref.onValue,
                          builder: (context,snapshot) {
                            if (snapshot.hasData) {
                              final userInfo = (snapshot.data as DatabaseEvent).snapshot.value as Map;
                              // if (DateTime.now().millisecondsSinceEpoch == userInfo['timeRemain']) {
                              //
                              // }
                              return Column(
                                children: [
                                  Text(
                                      "$day days : $hour h  : $minutes1\' : $seconds1\''", //{Duration(milliseconds: (Duration(milliseconds: snapshot.data!.toInt()).inHours - (Duration(milliseconds: snapshot.data!.toInt()).inHours))).inMinutes}
                                      style: const TextStyle(color: Colors.red, fontSize: 30)
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      userInfo['username'],
                                    ),
                                  ),
                                  Container(
                                    margin:
                                    const EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
                                    child: TextField(
                                      controller: emailController,
                                      onSubmitted: (String value) async {
                                        await showDialog<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            print(emailController.toString());
                                            if (emailController.text == userInfo['secretNumber'].toString()) {
                                              return AlertDialog(
                                                title: const Text('Thanks!'),
                                                content: Text(
                                                    'You typed "$value", which is correct'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              );
                                            }
                                              return AlertDialog(
                                                title: const Text('Thanks!'),
                                                content: Text(
                                                    'You typed "$value", which is not correct'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              );
                                          },
                                        );
                                      },
                                      obscureText: false,
                                      decoration: const InputDecoration(
                                        border:  OutlineInputBorder(),
                                        labelText: 'Secret Password',
                                        filled: true,
                                        fillColor: Colors.white70,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          });

                    } else {
                      return const Text('Empty data');
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  }


// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({ Key? key }) : super(key: key);
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   Widget build(BuildContext context) {
//     var ref = FirebaseDatabase.instance.ref().child("users"); ///${FirebaseAuth.instance.currentUser!.uid}
//     DateTime now = DateTime.now();
//     var epochTime= now.millisecondsSinceEpoch;
//
//     return Scaffold(
//       body:  StreamBuilder<Object>(
//         stream: ref.onValue,
//         builder: (context, snapshot) {
//         if(snapshot.hasData) {
//           final userInfo = (snapshot.data as DatabaseEvent).snapshot.value as Map;
//           final extractInfo = Map<dynamic,dynamic>.from(userInfo);
//           //extractInfo.
//           return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("$epochTime"),
//                   const SizedBox(height: 20,),
//                   FloatingActionButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const GreenFrog()),
//                         );
//                       })
//                 ],
//               ),
//           );
//         }
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//         }
//       ),
//     );
//   }
// }