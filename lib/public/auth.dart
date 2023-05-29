
import 'package:flutter/material.dart';
import 'package:testweo/services/UserService.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  UserService userService = UserService ();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: const TextSpan(
                  text: "Test",
                  style: TextStyle(
                    height: 0.7,
                    color: Color.fromARGB(255, 170, 219, 113),
                    fontSize: 30.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: RichText(
                  text: const TextSpan(
                    text: "We-O",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                      height: 0.7,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 150.0,
              ),
              ElevatedButton(
                child: Text('Sign In with Google'),
                onPressed: () {
                  userService.signinWithGoogle();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
