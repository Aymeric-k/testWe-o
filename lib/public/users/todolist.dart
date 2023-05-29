import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testweo/public/auth.dart';
import 'package:testweo/services/UserService.dart';

class Todolist extends StatefulWidget {
  final User? user;
  const Todolist({super.key, required this.user});

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  List<Map<String, String>> _toDoList =
      []; //Représente la liste de tache, qui récupérera toutes les taches
  List<bool> taskCompletion = [];
  final TextEditingController _titleController =
      TextEditingController(); //  Variable qui me permettera de controller le textField plus bas dans le code pour le titre de la tâche
  final TextEditingController _descriptionController = TextEditingController();
  UserService userService = UserService();  //  Variable qui me permettera de controller le textField plus bas dans le code pour la description de la tâche

  @override
  Widget build(BuildContext context) {
    // J'utilise un streambuilder et un snapshot pour écouter les changements d'authentification
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                title: Text('ToDoList de ${widget.user?.displayName}'),
                backgroundColor: Color.fromARGB(255, 189, 223, 150),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.exit_to_app),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut(); //Methode propre au package Firebase pour gérer la déconnexion uniquement sur Firebase

                      await userService.signOut(); //Méthode créer dans UserService qui permet la déconnexion de Google
                      Navigator.pushReplacement(  // Méthode de redirection
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => AuthScreen()));
                    },
                  ),
                ],
              ),
              body: Column(
                children: <Widget>[
                  Container( // Contient les 2 input
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        TextField( // Rien n'a été ajouté dans le onSubmitted de ce TextField
                          controller: _titleController, 
                          onSubmitted: (title) {},
                          decoration: InputDecoration(labelText: 'Titre'),
                        ),
                        TextField( // A la submission de ce TextField, nous ajoutons dans un tableau d'objet les 2 entrées de l'utilisateur
                          controller: _descriptionController,
                          onSubmitted: (description) {
                            setState(
                              () {
                                _toDoList.add({
                                  'title': _titleController.text,
                                  'description': description,
                                });
                                taskCompletion.add(false); // J'ajoute à chaque création de todo une entrée dans mon tableau de complétion de taches. Permet d'avoir des index identique
                                _titleController.clear(); //Nettoie les TextField
                                _descriptionController.clear();
                              },
                            );
                          },
                          decoration: InputDecoration(labelText: 'Description'),
                        ),
                      ],
                    ),
                  ),
                  Expanded( // Va contenir chaque Todo, sous forme de ListTile
                    child: Container(
                       margin: EdgeInsets.symmetric(vertical: 1.0, horizontal: 20.0),
                      child: ListView.builder(
                    
                      primary: false,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _toDoList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          tileColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.white) ),
                          title: Text(_toDoList[index]['title']!,
                              style: TextStyle(
                                  color: Colors.white,
                                  decoration: taskCompletion[index]
                                      ? TextDecoration.lineThrough
                                      : null)),
                          subtitle: Text(
                            _toDoList[index]['description']!,
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  _toDoList.removeAt(index); //Permet de supprimer l'entrée choisit par l'utilisateur, supprime aussi son état de complétion
                                  taskCompletion.removeAt(index);
                                });
                              }),
                          onTap: () {
                            setState(() {
                              taskCompletion[index] = !taskCompletion[
                                  index]; // Sert de toggle, si vrai, devient faux. Si faux, devient vrai.
                            });
                          },
                        );
                      },
                    ),
                  ),),
                ],
              ),
            );
          } else {
            return AuthScreen();
          }
        });
  }
}
