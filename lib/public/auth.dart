
import 'package:flutter/material.dart';
import 'package:testweo/services/UserService.dart';
import 'package:custom_signin_buttons/custom_signin_buttons.dart';

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox( //Utile pour limiter le spaceBetween de la colonne.
                height: MediaQuery.of(context).size.height*0.2,
              ),
              Container( // Utile pour garder "Test" proche de "We-o"
                child : Column(
                  children: [
                Text(
                   "Test",
                  style: TextStyle(
                    color: Color.fromARGB(255, 170, 219, 113),
                    fontSize: 30.0,
                  ),
                ),
              const Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Text(
                   "We-O",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                ),
                ]
                )
              ),
              Text('Pour accéder à votre liste de tache, veuillez vous connecter grâce à votre compte google',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0
                
              ),),
              SignInButton( // Provient du package custom signin button
                button : Button.Google,
                text: 'Compte Google',
                onPressed: () {
                  userService.signinWithGoogle();
                },
              ),
              Align(
                alignment: FractionalOffset.bottomCenter, //Permet de simuler un footer
                child: Container(
                  color : Color.fromARGB(255, 170, 219, 113),
                  height: 60,
                  child: Center(child: Text('Powered by Aymeric Kreicher')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
