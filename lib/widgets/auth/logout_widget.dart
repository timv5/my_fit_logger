import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        icon: Icon(Icons.more_vert, color: Theme.of(context).primaryIconTheme.color,),
        items: [
          DropdownMenuItem(
            child: Row(
              children: const <Widget>[
                Icon(Icons.exit_to_app),
                SizedBox(width: 8,),
                Text('Logout')
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
