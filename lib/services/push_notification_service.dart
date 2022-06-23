import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_fit_logger/model/push_notification_model.dart';

class PushNotificationService {

  void insertPushNotification(PushNotificationModel notification,
      String userId) async {
    await FirebaseFirestore.instance.collection('notifications').add({
      'userId': userId,
      'title': notification.title,
      'body': notification.body,
      'createdDate': Timestamp.now()
    });
  }

  void deletePushNotification(String notificationId) async {
    await FirebaseFirestore.instance.collection('notifications')
        .doc(notificationId).delete();
  }
}

