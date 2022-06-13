import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_fit_logger/screens/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_fit_logger/screens/future_plans_screen.dart';
import 'package:my_fit_logger/screens/log_detail_screen.dart';
import 'package:my_fit_logger/screens/my_logs_screen.dart';
import 'package:my_fit_logger/screens/navigation/main_navigation_screen.dart';
import 'package:my_fit_logger/screens/new_log_screen.dart';
import 'package:my_fit_logger/screens/overview_screen.dart';
import 'package:my_fit_logger/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Fit Logger',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        secondaryHeaderColor: Colors.orange,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.orange,
            onPrimary: Colors.white
          )
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.orange
          )
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: Colors.orange,
            side: const BorderSide(color: Colors.orange)
          )
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Colors.white
        ),
        unselectedWidgetColor: Colors.white,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          if (userSnapshot.hasData) {
            return const MainNavigationScreen();
          }
          return const AuthScreen();
        },
      ),
      routes: {
        AuthScreen.routeName: (context) => AuthScreen(),
        NewLogScreen.routeName: (context) => NewLogScreen(),
        LogDetailScreen.routeName: (context) => LogDetailScreen(),
        MyLogsScreen.routeName: (context) => MyLogsScreen(),
        OverviewScreen.routeName: (context) => OverviewScreen(),
        FuturePlansScreen.routeName: (context) => FuturePlansScreen()
      },
    );
  }
}
