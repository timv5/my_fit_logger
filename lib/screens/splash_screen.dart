import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SplashScreen extends StatelessWidget {

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: const Center(
        child: Text('Loading...'),
      ),
    );
  }

}
