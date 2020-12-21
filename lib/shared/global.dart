import 'package:misas/models/subsidiary.dart';
import 'package:misas/models/user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class Global{
  //Colors
  static const Color primary = const Color(0xff0a81a9);
  static const Color secondary = const Color(0xff96d5ee);

  //Database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static const String usersRef = 'users';
  static const String subsidiaryRef = 'subsidiary';
  static const String massRef = 'mass';
  static const String assistandRef = 'assistand';
  static const String reservationsRef = 'reservations';

  //User
  static bool isLogged;

  //Subsidiaries
  static List<Subsidiary> subsidiaries = <Subsidiary>[];
  static fillSubsidiaries() {
    firestore.collection(subsidiaryRef).where('estado', isEqualTo: true).snapshots().listen((event) {
      subsidiaries.clear();
      event.docs.forEach((element) {
        subsidiaries.add(new Subsidiary(element.id, element["picture"], element["name"], element["community"], getColor(element.id)));
      });
    });
  }

  //User Information Form
  static List<String> userQuestions = <String>[];
  static fillUserQuestions(){
    userQuestions.add('Cédula');
    userQuestions.add('Primer Nombre');
    userQuestions.add('Primer Apellido');
    userQuestions.add('Segundo Apellido');
  }

  //User Profile Info
  static UserInfo userInfo;
  static initUserInfo(id, name, lastname, secondLastname, phone){
    userInfo = new UserInfo(id, name, lastname, secondLastname, phone);
  }
  static cleanUserInfo(){
    userInfo = new UserInfo('', '', '', '', '');
  }

  //Days
  static String getDay(day){
    switch(day){
      case 1: return 'Lunes'; break;
      case 2: return 'Martes'; break;
      case 3: return 'Miércoles'; break;
      case 4: return 'Jueves'; break;
      case 5: return 'Viernes'; break;
      case 6: return 'Sábado'; break;
      case 7: return 'Domingo'; break;
      default: return 'error'; break;
    }
  }

  //Months
  static String getMonth(month){
    switch(month){
      case 1: return 'Enero'; break;
      case 2: return 'Febrero'; break;
      case 3: return 'Marzo'; break;
      case 4: return 'Abril'; break;
      case 5: return 'Mayo'; break;
      case 6: return 'Junio'; break;
      case 7: return 'Julio'; break;
      case 8: return 'Agosto'; break;
      case 9: return 'Setiembre'; break;
      case 10: return 'Octubre'; break;
      case 11: return 'Noviembre'; break;
      case 12: return 'Diciembre'; break;
      default: return 'error'; break;
    }
  }

  static Color getColor(id){
    switch(id){
      case '0': return secondary; break;
      case '1': return Colors.amberAccent; break;
      case '2': return Colors.orange[300]; break;
      case '3': return Colors.deepOrange[300]; break;
      default: return secondary; break;
    }
  }
}