import 'package:Misas/dialogs/alone_dialog.dart';
import 'package:Misas/dialogs/confirmation_dialog.dart';
import 'package:Misas/dialogs/results_dialog.dart';
import 'package:Misas/dialogs/rules_dialog.dart';
import 'package:flutter/material.dart';

class DialogHelper{
  static int total;
  static int subsidiary;
  static int people;
  static DateTime date;

  //static results(context) => showDialog(context: context, builder: (context) => ResultsDialog(totalPoints: total,));
  static alone(context) => showDialog(context: context, builder: (context) => AloneDialog(subsidiaryIndex: subsidiary,));
  static confirmation(context) => showDialog(context: context, builder: (context) => ConfirmationDialog(people: people, date: date, subsidiaryIndex: subsidiary,));
  static rules(context) => showDialog(context: context, barrierDismissible: false, builder: (context) => RulesDialog());
  static results(context) => showDialog(context: context, builder: (context) => ResultsDialog(totalPoints: total,));
}