import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/push_notification_widget.dart';

class PushNotificationScreen extends StatelessWidget {

  static const String routeName = '/push_notification';

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: Future.value(FirebaseAuth.instance.currentUser),
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          } else {
            return StreamBuilder(
                stream: FirebaseFirestore.instance.collection('notifications').orderBy('createdDate', descending: true).snapshots(),
                builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
                  if (chatSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(),);
                  }

                  final chatDocs = chatSnapshot.data!.docs;
                  return ListView.builder(
                      itemCount: chatDocs.length,
                      itemBuilder: (ctx, index) => PushNotificationWidget(
                        chatDocs[index]['title'],
                        chatDocs[index]['body'],
                        chatDocs[index]['createdDate'],
                        chatDocs[index].id
                      )
                  );
                }
            );
          }
        }
    );
  }
}

