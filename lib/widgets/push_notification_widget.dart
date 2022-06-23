import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_fit_logger/services/push_notification_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PushNotificationWidget extends StatelessWidget {

  final String title;
  final String body;
  final Timestamp createdDate;
  final String notificationId;

  PushNotificationWidget(this.title, this.body, this.createdDate, this.notificationId);

  @override
  Widget build(BuildContext context) {

    final pushNotificationService = PushNotificationService();

    return Dismissible(
      key: ValueKey(notificationId),
      onDismissed: (direction) {
        // delete notification
        pushNotificationService.deletePushNotification(notificationId);
      },
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(AppLocalizations.of(context).deleteNotificationDialogHeader),
            content: Text(AppLocalizations.of(context).deleteNotificationDialogBody),
            backgroundColor: Theme.of(context).primaryColor,
            actions: [
              TextButton(onPressed: (){
                Navigator.of(context).pop(false);
              }, child: Text(AppLocalizations.of(context).no)),
              TextButton(onPressed: (){
                Navigator.of(context).pop(true);
              }, child: Text(AppLocalizations.of(context).yes)),
            ],
          )
        );
      },
      direction: DismissDirection.endToStart,   // swipe to the right
      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon(Icons.delete, color: Colors.white, size: 25,),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            title: Text(title),
            subtitle: Text(body),
          ),
        ),
      )
    );
  }
}
