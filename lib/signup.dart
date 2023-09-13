import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/main.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController emailidcontroller = TextEditingController();
  TextEditingController contactnocontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue,
            Colors.red,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _page(),
      ),
    );
  }

  Widget _page() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _icon(),
              const SizedBox(
                height: 30,
              ),
              _inputFields("Username", usernamecontroller),
              const SizedBox(
                height: 25,
              ),
              _inputFields("Email Id", emailidcontroller),
              const SizedBox(
                height: 25,
              ),
              _inputFields("Contact No", contactnocontroller),
              const SizedBox(
                height: 25,
              ),
              _inputFields("Password", passwordcontroller, isPassword: true),
              const SizedBox(
                height: 25,
              ),
              _registerBtn(),
              const SizedBox(
                height: 20,
              ),
              _extraText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _icon() {
    return Container(
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.white, width: 2),
      //   shape: BoxShape.circle,
      // ),
      child: const Icon(
        Icons.person_add,
        color: Colors.white,
        size: 120,
      ),
    );
  }

  Widget _inputFields(String hintText, TextEditingController controller,
      {isPassword = false}) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Colors.black));

    return TextField(
      style: const TextStyle(color: Colors.white),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: border,
        focusedBorder: border,
      ),
      obscureText: isPassword,
    );
  }

  Widget _registerBtn() {
    return ElevatedButton(
      onPressed: () {

        // Authentication
        FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailidcontroller.text,
            password: passwordcontroller.text).then((value) {
              print('User has been created.');
          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
        }).onError((error, stackTrace) {
          print('Error: ${error.toString()}');
        });

        // Store data to Cloud Firestore
        CollectionReference collectionReference = FirebaseFirestore.instance.collection('User-Info');
        collectionReference.add({
          'username': usernamecontroller.text,
          'email': emailidcontroller.text,
          'contact_no': contactnocontroller.text,
          'password': passwordcontroller.text
        });
      },

      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: const Color.fromARGB(255, 228, 226, 226),
        foregroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: const SizedBox(
        width: double.infinity,
        child: Text(
          "Sign Up",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget _extraText() {
    return Row(
      children: [
        const Text(
          "Already have an account?",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),

        // Sign In Button
        TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          },
          child: const Text(
            "Login here",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
