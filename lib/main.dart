import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:testweo/public/auth.dart';
import 'package:testweo/public/users/todolist.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Permet d'assurer que tout est initialisé
  await Firebase.initializeApp();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test We-o',
      home: LandingPage(), //Classe définiit plus bas, le contenu de LandingPage dépend de la presence ou non données utilisateur.
    );
  }
}

class LandingPage extends StatelessWidget {
   LandingPage({super.key});

@override
Widget build(BuildContext context) {
  // J'utilise un streambuilder et un snapshot pour écouter les changements d'authentification
  return StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {

      if (snapshot.hasData){
        return Todolist(user: snapshot.data);
      }else{
        return AuthScreen();
      }
    }
  );
}
}
