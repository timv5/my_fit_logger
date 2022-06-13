import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FuturePlansScreen extends StatelessWidget {

  static const routeName = '/future_plans';

  const FuturePlansScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Text('Future plans list')
            ],
          ),
        ),
      ),
    );
  }

}
