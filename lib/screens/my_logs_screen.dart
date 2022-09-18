import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_fit_logger/providers/my_logs.dart';
import 'package:my_fit_logger/widgets/my_logs_widget.dart';
import 'package:provider/provider.dart';

class MyLogsScreen extends StatelessWidget {

  static const routeName = '/my_logs';

  const MyLogsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: MyLogs(),
      child: FutureBuilder(
        future: Provider.of<MyLogs>(context, listen: false).fetch(),
        builder: (context,  snapshot) => snapshot.connectionState == ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator(),)
            : Center(
                child: Consumer<MyLogs>(
                  child: const Center(child: Text('Got no logs yet, start adding some'),),
                  builder: (ctx, data, ch) => data.myLogs.isEmpty
                      ? ch!
                      : ListView.builder(
                      itemCount: data.myLogs.length,
                      itemBuilder: (ctx, index) => MyLogsWidget(
                          data.myLogs[index].id,
                          data.myLogs[index].title,
                          data.myLogs[index].body,
                          data.myLogs[index].createDate
                      )
                  ),
                ),
        ),
      )
    );
  }
}
