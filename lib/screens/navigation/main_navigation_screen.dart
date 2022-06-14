import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_fit_logger/screens/future_plans_screen.dart';
import 'package:my_fit_logger/screens/my_logs_screen.dart';
import 'package:my_fit_logger/screens/overview_screen.dart';
import 'package:my_fit_logger/widgets/navigation/side_menu_navigation_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../widgets/auth/logout_widget.dart';
import '../auth_screen.dart';
import '../splash_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  
  late List<Widget> _pages;
  late List<String> _pageNames;
  int _selectedPageIndex = 0;
  
  @override
  void initState() {
    _pages = [OverviewScreen(), MyLogsScreen(), FuturePlansScreen(),];
    _pageNames = [
      AppLocalizations.of(context).overview,
      AppLocalizations.of(context).myLogs,
      AppLocalizations.of(context).futurePlans
    ];
    super.initState();
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
