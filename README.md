# Projet à rendre pour We-O

Suite à un entretien d'embauche, j'ai dû rendre un projet le week-end même en Flutter.

Le cahier des charges était le suivant 


##Titre : Application de gestion de tâches avec authentification Google

###Description :
Vous êtes chargé de développer une application mobile en utilisant Flutter qui permet aux utilisateurs de se connecter avec leur compte Google et de gérer une liste de tâches. L'application doit comporter une page de connexion où les utilisateurs peuvent s'authentifier via Google, puis une deuxième page affichant la liste des tâches, où ils pourront ajouter de nouvelles tâches et supprimer les tâches existantes.

###Objectifs :

1.Concevoir et mettre en place une page de connexion attrayante permettant aux utilisateurs de s'authentifier via Google.
2.Implémenter l'authentification Google en utilisant Firebase Auth pour permettre aux utilisateurs de se connecter à l'application.
3.Créer une deuxième page pour afficher la liste des tâches. Cette page doit être accessible uniquement aux utilisateurs authentifiés.
4.Permettre aux utilisateurs d'ajouter de nouvelles tâches en saisissant un titre et une description.
5.Mettre en œuvre la fonctionnalité permettant aux utilisateurs de supprimer des tâches de la liste.


###Instructions :

1.Créez un nouveau projet Flutter.
2.Concevez et mettez en place une page de connexion attrayante où les utilisateurs pourront se connecter avec leur compte Google.
3.Implémentez l'authentification Google en utilisant Firebase Auth. Lorsqu'un utilisateur se connecte avec succès, redirigez-le vers la page de la liste des tâches.
4.Créez une deuxième page qui affichera la liste des tâches. Cette page doit être accessible uniquement aux utilisateurs authentifiés. Si un utilisateur non authentifié essaie d'y accéder, redirigez-le vers la page de connexion.
5.Mettez en place une liste de tâches dans la deuxième page. Chaque tâche doit afficher un titre et une description.
6.Ajoutez un formulaire permettant aux utilisateurs d'ajouter de nouvelles tâches. Lorsque l'utilisateur soumet le formulaire, la nouvelle tâche doit être ajoutée à la liste.
7.Implémentez la fonctionnalité permettant aux utilisateurs de supprimer des tâches de la liste. Ajoutez un bouton ou un geste de balayage pour supprimer une tâche spécifique.
8.Testez soigneusement votre application pour vous assurer que toutes les fonctionnalités fonctionnent correctement.
9.Héberger votre projet sur un git


Pour utiliser l'authentification Google, j'ai créé mon projet sur Firebase. J'ai paramétré les différents fichiers gradle, et ai ajouté les dépendences dans mon ficher pubspec.yaml.
Grâce à ses dépendances, j'ai pu utiliser les méthodes de Firebase et de Google sign in.

J'ai d'abord créé un fichier "main.dart" qui est mon gestionnaire de vue. Ce fichier a pour but de diriger vers la page de connexion s'il ne trouve pas de données d'utilisateur, et si il en trouve, il dirige vers la page utilisateur.


Les données utilisateur sont générées par ma page de service UserService.dart.
La page d'authentification contient un bouton de connexion google, importé depuis le package "custom_signin_buttons". Ce bouton appelle la méthode de connexion de UserService. 
Une fois l'utilisateur connecté, il est dirigé vers la page utilisateur todolist.
Cette page contient deux input de type TextField, qui permettent à l'utilisateur d'ajouter des entrées dans une liste dynamique. Il est possible a l'utilisateur de barrer les taches en cliquant sur l'une d'entre elles ou de les supprimer.