import 'package:misas/screens/help_screen.dart';
import 'package:misas/screens/mass_screen.dart';
import 'package:misas/screens/profile_screen.dart';
import 'package:misas/services/auth_service.dart';
import 'package:misas/shared/global.dart';
import 'package:misas/shared/route_generator.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: child,
          );
        },
        home: AuthService().handleAuth(),
        onGenerateRoute: RouteGenerator.generateRoute,
      );
}

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  var firebaseUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    isRegistered(context);
    super.initState();
  }

  isRegistered(context) async {
    Global.firestore
        .collection(Global.usersRef)
        .doc(firebaseUser.uid)
        .get()
        .then((value) {
      if (!value.exists)
        Navigator.of(context).pushNamed('/signin');
      else {
        initUser();
      }
    });
  }

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
          TabData(
            iconData: FontAwesomeIcons.phone,
            title: 'CONTÁCTO',
          ),
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

  initUser() async {
    Map<String, dynamic> data;
    await Global.firestore
        .collection(Global.usersRef)
        .doc(firebaseUser.uid)
        .get()
        .then(
          (value) => {
            data = value.data(),
            Global.initUserInfo(
              data['id'],
              data['name'],
              data['lastname'],
              data['secondLastname'],
              data['phone'],
            ),
          },
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
