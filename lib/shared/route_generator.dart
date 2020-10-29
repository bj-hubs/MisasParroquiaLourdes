import 'package:Misas/screens/autocheck_screen.dart';
import 'package:Misas/screens/choose_mass_screen.dart';
import 'package:Misas/screens/companions_screen.dart';
import 'package:Misas/screens/delete_reservation_screen.dart';
import 'package:Misas/screens/help_screen.dart';
import 'package:Misas/screens/mass_screen.dart';
import 'package:Misas/screens/profile_screen.dart';
import 'package:Misas/screens/quantity_screen.dart';
import 'package:Misas/screens/questions_screen.dart';
import 'package:Misas/screens/signin_screen.dart';
import 'package:Misas/services/auth_service.dart';
import 'package:flutter/material.dart';

//Routes
const _login = '/login';
const _signin = '/signin';
const _root = '/';
const _mass = '/mass';
const _profile = '/profile';
const _help = '/help';

const _autocheck = '/profile/autocheck';
const _questions = '/profile/autocheck/questions';
const _quantity = '/mass/quantity';
const _companions = '/mass/companions';
const _chooseMass = '/mass/choose';
const _deleteMass = '/mass/delete';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case _login:
        return MaterialPageRoute(builder: (_) => AuthService().handleAuth());
      case _signin:
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case _root:
        return MaterialPageRoute(builder: (_) => BottomAppBar());
      case _mass:
        return MaterialPageRoute(builder: (_) => MassScreen());
      case _deleteMass:
        return MaterialPageRoute(builder: (_) => DeleteReservationScreen());
      case _quantity:
      case _quantity:
        return MaterialPageRoute(builder: (_) => QuantityScreen(subsidiaryIndex: settings.arguments,));
      case _companions:
        List<String> args = settings.arguments;
        int index = int.parse(args[0]);
        int quantity = int.parse(args[1]) - 1;
        return MaterialPageRoute(builder: (_) => CompanionsScreen(subsidiaryIndex: index, quantity: quantity,));
      case _chooseMass:
        List<String> args = settings.arguments;
        int index = int.parse(args[0]);
        int quantity = int.parse(args[1]);
        return MaterialPageRoute(builder: (_) => ChooseMassScreen(subsidiaryIndex: index, quantity: quantity,));
      case _profile:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case _help:
        return MaterialPageRoute(builder: (_) => HelpScreen());
      case _autocheck:
        return MaterialPageRoute(builder: (_) => AutocheckScreen());
      case _questions:
        return MaterialPageRoute(builder: (_) => QuestionsScreen());
      default:
        return _errorPage();
    }
  }

  static Route<dynamic> _errorPage(){
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        appBar: AppBar(
          title: Text("Error"),
        ),
        body: Center(
          child: Text("Error"),
        ),
      );
    });
  }
}