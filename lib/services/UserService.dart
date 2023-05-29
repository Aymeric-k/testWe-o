import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserService {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    //Méthode pour se connecter, appelé quand l'utilisateur clique sur le bouton de connection google
  signinWithGoogle() async {
    try {
      //Gère et contrôle l'authentification Google
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      //Créer les variables utiles pour Firebase
      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      
      //Connexion a Firebase
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print(userCredential.user?.displayName);
    } catch (error) {
      print('Impossible de se connecter avec Google');
    }
  }

  //Méthode pour se déconnecter, appelé quand l'utilisateur clique sur l'icône dans l'appbar sur la page todolist.
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
