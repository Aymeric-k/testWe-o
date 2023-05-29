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
  List<String> _toDoList =
      []; //Représente la liste de tache, qui récupérera toutes les taches
  List<bool> taskCompletion = [];
  final TextEditingController _titleController =
      TextEditingController(); //  Variable qui me permettera de controller le textField plus bas dans le code pour le titre de la tâche
  final TextEditingController _descriptionController = TextEditingController();
  UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text('ToDoList de ${widget.user?.displayName}'),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.exit_to_app),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();

                      await userService.signOut();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => AuthScreen()));
                    },
                  ),
                ],
              ),
              body: Column(
                children: <Widget>[
                  TextField(
                    controller: _titleController,
                    onSubmitted: (value) {
                      setState(() {
                        _toDoList.add(value);
                        taskCompletion.add(false);
                      });
                      _titleController.clear();
                    },
                  ),
                  TextField(
                    controller: _descriptionController,
                    onSubmitted: (value) {
                      setState(() {
                        _toDoList.add(value);
                        taskCompletion.add(false);
                      });
                      _descriptionController.clear();
                    },
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _toDoList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_toDoList[index],
                              style: TextStyle(
                                  decoration: taskCompletion[index]
                                      ? TextDecoration.lineThrough
                                      : null)),
                          trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  _toDoList.removeAt(index);
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
                  ),
                ],
              ),
            );
          } else {
            return AuthScreen();
          }
        });
  }
}
