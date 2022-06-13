import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthFormWidget extends StatefulWidget {

  final void Function(
      String email,
      String username,
      String passwword,
      bool isLogin,
      BuildContext ctx
  ) submitAuthentication;

  final bool isLoading;

  AuthFormWidget(this.submitAuthentication, this.isLoading);

  @override
  State<AuthFormWidget> createState() => _AuthFormWidgetState();

}

class _AuthFormWidgetState extends State<AuthFormWidget> {

  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String ?_username;
  String ?_userEmail;
  String ?_userPassword;

  void _tryAuthenticate() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      // remove focus off from input field
      FocusScope.of(context).unfocus();

      // trigger onSaved function
      _formKey.currentState!.save();

      // authenticate user
      widget.submitAuthentication(_userEmail!, _username != null ? _username! : '', _userPassword!, _isLogin, context);
    }
  }

  String? _emailValidation(String inputtedEmail) {
    if (inputtedEmail.isEmpty) {
      return 'Email address is a mandatory field';
    }

    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(inputtedEmail);
    if (!emailValid) {
      return 'Please enter a valid email address';
    }

    // input valid
    return null;
  }
  
  String? _usernameValidation(String inputtedUsername) {
    if (inputtedUsername.isEmpty) {
      return 'Username is a mandatory field';
    }
    
    if (inputtedUsername.length < 6) {
      return 'Username must be at least 6 chars long';
    }

    // input valid
    return null;
  }
  
  String? _passwordValidation(String inputtedPassword) {
    if (inputtedPassword.isEmpty) {
      return 'Please select your password';
    }

    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    bool emailValid = RegExp(pattern).hasMatch(inputtedPassword);
    if (!emailValid) {
      return 'Should have one upper case, one lower case, should contain one digit,'
          ' one special character, min 8 chars long';
    }

    // input valid
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    key: const ValueKey('email'),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (inputtedEmailValue) {
                      return _emailValidation(inputtedEmailValue!);
                    },
                    onSaved: (inputtedEmailValue) {
                      _userEmail = inputtedEmailValue!.trim();
                    },
                  ),
                  if (!_isLogin)
                  TextFormField(
                    key: const ValueKey('username'),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(labelText: 'Username'),
                    validator: (inputtedUsernameValue) {
                      return _usernameValidation(inputtedUsernameValue!);
                    },
                    onSaved: (inputtedUsernameValue) {
                      _username = inputtedUsernameValue!.trim();
                    },
                  ),
                  TextFormField(
                    key: const ValueKey('password'),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (inputtedPasswordValue) {
                      return _passwordValidation(inputtedPasswordValue!);
                    },
                    onSaved: (inputtedPasswordValue) {
                      _userPassword = inputtedPasswordValue!.trim();
                    },
                  ),
                  const SizedBox(height: 12,),
                  if (widget.isLoading) const CircularProgressIndicator(),
                  if (!widget.isLoading)
                    ElevatedButton(
                        onPressed: _tryAuthenticate,
                        child: _isLogin ? const Text('Login') : const Text('Sign Up')
                    ),
                  if (!widget.isLoading)
                    TextButton(
                        onPressed: (){
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: _isLogin ? const Text('Create a new account') : const Text('I already have an account')
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
