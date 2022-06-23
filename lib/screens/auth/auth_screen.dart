import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:my_fit_logger/services/auth_service.dart';
import 'package:my_fit_logger/widgets/auth/auth_form_widget.dart';

class AuthScreen extends StatefulWidget {

  static const routeName = '/auth';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  var _isLoading = false;
  AuthService authService = AuthService();

  void _submitAuthForm(String email, String username, String password, bool isLogin, BuildContext authContext) async {
    try {
      setState(() {_isLoading = true;});
      if (isLogin) {
        authService.login(email, password);
      } else {
        authService.register(email, password, username);
      }
      setState(() {_isLoading = false;});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthFormWidget(_submitAuthForm, _isLoading),
    );
  }
}
