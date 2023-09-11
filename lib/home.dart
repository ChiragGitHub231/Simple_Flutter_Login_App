import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final userinfo = ModalRoute.of(context)?.settings?.arguments as Map<String, String>;
    final username = userinfo['username'].toString();

    return Scaffold(
      body: Center(
        /*
        child: ElevatedButton(
            onPressed: (){
              FirebaseAuth.instance.signOut().then((value){
                print('Logged Out Successfully');
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
              });
            },
            child: Text('Logout'),
        ),
        */
        child: Column(
          children: [
            SizedBox(height: 330,),
            Text(
              'Welcome, $username',
              style: TextStyle(
                fontSize: 20,
              ),
            ),

            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (){
                FirebaseAuth.instance.signOut().then((value){
                  print('Logged Out Successfully');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                });
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
