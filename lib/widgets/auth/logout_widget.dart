import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        icon: Icon(Icons.more_vert, color: Theme.of(context).primaryIconTheme.color,),
        items: [
          DropdownMenuItem(
            child: Row(
              children: <Widget>[
                const Icon(Icons.exit_to_app),
                const SizedBox(width: 8,),
                Text(AppLocalizations.of(context).logout)
              ],
            ),
            value: 'logout',
          ),
        ],
        onChanged: (itemIdentifier) {
          if (itemIdentifier == 'logout') {
            FirebaseAuth.instance.signOut();
          }
        }
    );
  }
}
