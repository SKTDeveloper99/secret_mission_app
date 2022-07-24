import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:secret_mission_app/test1.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({ Key? key }) : super(key: key);

  final Stream<int> generateNumbers = (() async* {
    await Future<void>.delayed(const Duration(seconds: 2));

    for (int i = 1; i <= 10; i++) {
      await Future<void>.delayed(const Duration(seconds: 1));
      yield i;
    }
  })();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Flutter StreamBuilder Demo'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Center(
          child: StreamBuilder<int>(
            stream: generateNumbers,
            initialData: 0,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot){
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Visibility(
                      visible: snapshot.hasData,
                      child: Text(
                        snapshot.data.toString(),
                        style: const TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.active
                  || snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  return Text(
                      snapshot.data.toString(),
                      style: const TextStyle(color: Colors.red, fontSize: 40)
                  );
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            },
          ),
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