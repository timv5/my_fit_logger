import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyLogsScreen extends StatelessWidget {

  static const routeName = '/my_logs';

  const MyLogsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Text('My logs lists')
            ],
          ),
        ),
      ),
    );
  }
}
