import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SideMenuNavigationWidget extends StatelessWidget {

  final Function onTap;

  SideMenuNavigationWidget(this.onTap);

  @override
  Widget build(BuildContext context) {

    Future<DocumentSnapshot> getUserData() async {
      var firebaseUser = await FirebaseAuth.instance.currentUser;
      return FirebaseFirestore.instance.collection("users").doc(firebaseUser?.uid).get();
    }

    return FutureBuilder(
      future: getUserData(),
      builder: (ctx,  AsyncSnapshot<DocumentSnapshot> userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        } else {
          Map<String, dynamic> userData = userSnapshot.data!.data() as Map<String, dynamic>;
          return SizedBox(
            width: MediaQuery.of(context).size.width*0.8,
            child: Drawer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(
                            width: 70,
                            height: 70,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(userData['imageUrl']),
                            ),
                          ),
                          const SizedBox(height: 15,),
                          Text(
                            "${userData['username']}",
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white,),
                          ),
                          const SizedBox(height: 2,),
                          Text(
                            "${userData['email']}",
                            style: const TextStyle(color: Colors.white, fontSize: 12,),
                          )
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: Text(AppLocalizations.of(context).overview),
                    onTap: ()=>onTap(0),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: Text(AppLocalizations.of(context).myLogs),
                    onTap: ()=>onTap(1),
                  ),ListTile(
                    leading: const Icon(Icons.settings),
                    title: Text(AppLocalizations.of(context).futurePlans),
                    onTap: ()=>onTap(2),
                  ),
                  ListTile(
                    leading: const Icon(Icons.message),
                    title: Text(AppLocalizations.of(context).messages),
                    onTap: ()=>onTap(3),
                  ),
                  const Divider(height: 1,),
                  ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: Text(AppLocalizations.of(context).logout),
                    onTap: () => FirebaseAuth.instance.signOut(),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}





