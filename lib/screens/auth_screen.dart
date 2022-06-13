import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:my_fit_logger/widgets/auth/auth_form_widget.dart';

class AuthScreen extends StatefulWidget {

  static const routeName = '/auth';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();

}

class _AuthScreenState extends State<AuthScreen> {

  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(String email, String username, String password, bool isLogin, BuildContext authContext) async {
    try {
      _authenticate(email, username, password, isLogin);
    } on PlatformException catch (error) {
      setState(() {_isLoading = false;});
      var message = 'An error occurred, please check your credentials';
      if (error.message != null) {
        message = error.message!;
      }

      // show error popup to the user
      ScaffoldMessenger.of(authContext).showSnackBar(
          SnackBar(content: Text('Error: $message'), backgroundColor: Theme.of(authContext).errorColor,)
      );
    } catch (error) {
      setState(() {_isLoading = false;});
      // show error popup to the user
      ScaffoldMessenger.of(authContext).showSnackBar(
          SnackBar(content: const Text('Unknown error occurred'), backgroundColor: Theme.of(authContext).errorColor,)
      );
    }
  }

  void _authenticate(String email, String username, String password, bool isLogin) async {
    setState(() {_isLoading = true;});
    if (isLogin) {
      _login(email, password);
    } else {
      _register(email, password, username);
    }
    setState(() {_isLoading = false;});
  }

  void _register(String email, String password, String username) async {
    // create user in firebase auth
    final result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    // save additional data to the registered user
    await FirebaseFirestore.instance.collection('users').doc(result.user!.uid).set({
      'username': username,
      'email': email
    });
  }

  void _login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthFormWidget(_submitAuthForm, _isLoading),
    );
  }
}
