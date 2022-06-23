import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_fit_logger/screens/future_plans_screen.dart';
import 'package:my_fit_logger/screens/my_logs_screen.dart';
import 'package:my_fit_logger/screens/overview_screen.dart';
import 'package:my_fit_logger/screens/push_notification_screen.dart';
import 'package:my_fit_logger/services/push_notification_service.dart';
import 'package:my_fit_logger/widgets/navigation/side_menu_navigation_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../model/push_notification_model.dart';
import '../../widgets/auth/logout_widget.dart';
import '../auth/auth_screen.dart';
import '../splash/splash_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {

  late PushNotificationService pushNotificationService;
  final user = FirebaseAuth.instance.currentUser;
  late final FirebaseMessaging _messaging;
  late final List<Widget> _pages = [OverviewScreen(), MyLogsScreen(), FuturePlansScreen(), PushNotificationScreen()];
  late final List<String> _pageNames = [
    AppLocalizations.of(context).overview,
    AppLocalizations.of(context).myLogs,
    AppLocalizations.of(context).futurePlans,
    AppLocalizations.of(context).messages,
  ];
  int _selectedPageIndex = 0;
  
  @override
  void initState() {
    super.initState();
    pushNotificationService = PushNotificationService();
    checkForInitialMessage();
    handleForegroundNotifications();
    handleBackgroundNotification();
  }

  // when user taps a message
  // For handling notification when the app is in terminated state
  void checkForInitialMessage() async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      PushNotificationModel notification = PushNotificationModel(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
      );
      _savePushNotification(notification);
      _selectPage(3);
    }
  }

  // message is not tapped
  // handle foreground messages
  void handleForegroundNotifications() async {
    _messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await _messaging.requestPermission(alert: true,
      announcement: false, badge: true, carPlay: false, criticalAlert: false, provisional: false, sound: true,);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        PushNotificationModel notification = PushNotificationModel(
          title: message.notification?.title,
          body: message.notification?.body,
        );
        _savePushNotification(notification);
      });
    }
  }

  // When user taps on message
  // For handling notification when the app is in background but not terminated
  void handleBackgroundNotification() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      PushNotificationModel notification = PushNotificationModel(
        title: message.notification?.title,
        body: message.notification?.body,
      );
      _savePushNotification(notification);
      _selectPage(3);
    });
  }

  void _savePushNotification(PushNotificationModel notification) {
    if (user != null && user?.uid != null) {
      String? id = user?.uid;
      pushNotificationService.insertPushNotification(notification, id!);
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          if (userSnapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text(_pageNames[_selectedPageIndex]),
                actions: const <Widget>[LogoutWidget()],
              ),
              body: _pages[_selectedPageIndex],
              bottomNavigationBar: BottomNavigationBar(
                onTap: _selectPage,
                backgroundColor: Theme.of(context).primaryColor,
                unselectedItemColor: Theme.of(context).unselectedWidgetColor,
                selectedItemColor: Theme.of(context).secondaryHeaderColor,
                currentIndex: _selectedPageIndex,
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.home),
                      label: AppLocalizations.of(context).overview
                  ),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.next_plan),
                      label: AppLocalizations.of(context).myLogs
                  ),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.fitness_center),
                      label: AppLocalizations.of(context).futurePlans
                  ),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.message),
                      label: AppLocalizations.of(context).messages
                  ),
                ],
              ),
              drawer: SideMenuNavigationWidget(_selectPage),
            );
          }
          return const AuthScreen();
        },
      ),
    );
  }

}
