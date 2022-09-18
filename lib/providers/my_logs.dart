import 'package:flutter/material.dart';
import 'package:my_fit_logger/localdb/dao.dart';

import '../model/log.dart';

class MyLogs with ChangeNotifier {

  List<Log> _myLogs = [];

  List<Log> get myLogs {
    return [..._myLogs];
  }

  void addMyLog(String title, String body) {
    final DateTime createDate = DateTime.now();
    final newLog = Log(DateTime.now().toString(), title, body, createDate);
    _myLogs.add(newLog);
    notifyListeners();

    Dao.insert('my_logs', {
      'id': newLog.id,
      'title': newLog.title,
      'body': newLog.body,
      'create_date': createDate
    });
  }

  void deleteMyLog(String id) {
    _myLogs.removeWhere((element) => element.id == id);
    notifyListeners();

    Dao.delete('my_logs', id);
  }

  Future<void> fetch() async {
    final data = await Dao.fetch('my_logs');
    _myLogs = data.map((e) => Log(e['id'], e['title'], e['body'], e['create_date'])).toList();
    notifyListeners();
  }

}