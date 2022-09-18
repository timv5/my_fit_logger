import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../providers/my_logs.dart';

class MyLogsWidget extends StatelessWidget {

  final String id;
  final String title;
  final String body;
  final DateTime createDate;

  MyLogsWidget(this.id, this.title, this.body, this.createDate);

  @override
  Widget build(BuildContext context) {

    void _delete() async {
      Provider.of<MyLogs>(context, listen: false).deleteMyLog(id);
    }

    return Dismissible(
        key: ValueKey(id),
        onDismissed: (direction) {
          _delete();
        },
        confirmDismiss: (direction) {
          return showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(AppLocalizations.of(context).deleteMyLogsDialogHeader),
                content: Text(AppLocalizations.of(context).deleteMyLogsDialogBody),
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
        direction: DismissDirection.endToStart,
        background: Container(
          color: Theme.of(context).backgroundColor,
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
