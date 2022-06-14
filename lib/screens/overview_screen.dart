import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class OverviewScreen extends StatelessWidget {

  static const routeName = '/overview';
  
  const OverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Text(AppLocalizations.of(context).helloWorld)
            ],
          ),
        ),
      ),
    );
  }
}
