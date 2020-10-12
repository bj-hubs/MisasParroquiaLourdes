import 'package:Misas/screens/help_screen.dart';
import 'package:Misas/screens/login_screen.dart';
import 'package:Misas/screens/mass_screen.dart';
import 'package:Misas/screens/profile_screen.dart';
import 'package:Misas/shared/global.dart';
import 'package:Misas/shared/route_generator.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: child,
          );
        },
        home: LogInScreen(),
        onGenerateRoute: RouteGenerator.generateRoute,
      );
}

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final MassScreen _mass = MassScreen();
  final HelpScreen _help = HelpScreen();
  final ProfileScreen _profile = ProfileScreen();

  GlobalKey _bottonNavigationKey = GlobalKey();

  Widget _showPage = new MassScreen();

  Widget _pageSelector(int index) {
    switch (index) {
      case 0:
        return _profile;
        break;
      case 1:
        return _mass;
        break;
      case 2:
        return _help;
        break;
      default:
        return new Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text('No Page Found')],
        ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        color: Colors.white,
        child: Center(
          child: _showPage,
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        circleColor: Colors.white,
        inactiveIconColor: Colors.white,
        barBackgroundColor: Global.primary,
        activeIconColor: Global.primary,
        textColor: Colors.white,
        tabs: [
          TabData(
            iconData: FontAwesomeIcons.solidIdCard,
            title: 'CUENTA',
          ),
          TabData(
            iconData: FontAwesomeIcons.calendarAlt,
            title: 'MISAS',
          ),
          TabData(iconData: FontAwesomeIcons.question, title: 'AYUDA')
        ],
        initialSelection: 1,
        key: _bottonNavigationKey,
        onTabChangedListener: (position) {
          setState(() {
            _showPage = _pageSelector(position);
          });
        },
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
