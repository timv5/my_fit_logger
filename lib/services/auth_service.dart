import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final _auth = FirebaseAuth.instance;

  void register(String email, String password, String username) async {
    // create user in firebase auth
    final result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    // save additional data to the registered user
    await FirebaseFirestore.instance.collection('users').doc(result.user!.uid).set({
      'username': username,
      'email': email
    });
  }

  void login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

}