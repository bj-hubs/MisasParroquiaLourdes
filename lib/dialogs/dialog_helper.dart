import 'package:misas/dialogs/alone_dialog.dart';
import 'package:misas/dialogs/confirmation_dialog.dart';
import 'package:misas/dialogs/delete_dialog.dart';
import 'package:misas/dialogs/edit_profile_dialog.dart';
import 'package:misas/dialogs/logout.dart';
import 'package:misas/dialogs/results_dialog.dart';
import 'package:misas/dialogs/rules_dialog.dart';
import 'package:misas/dialogs/verification_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DialogHelper{
  static int total;
  static int subsidiary;
  static int people;
  static DateTime date;
  static String verId;
  static int position;

  static String day;
  static String hour;
  static String massId;

  static DocumentReference massRef;

  static List<dynamic> assistands;

  //static results(context) => showDialog(context: context, builder: (context) => ResultsDialog(totalPoints: total,));
  static codeValidation(context) => showDialog(context: context, barrierDismissible: false, builder: (context) => VerifyCodeDialog(verificationId: verId));
  static alone(context) => showDialog(context: context, builder: (context) => AloneDialog(subsidiaryIndex: subsidiary, inArrayPosition: position));
  static confirmation(context) => showDialog(context: context, builder: (context) => ConfirmationDialog(people: people, date: date, subsidiaryIndex: subsidiary, day: day, massId: massId, assistands: assistands, inArrayPosition: position,));
  static rules(context) => showDialog(context: context, barrierDismissible: false, builder: (context) => RulesDialog());
  static results(context) => showDialog(context: context, builder: (context) => ResultsDialog(totalPoints: total,));
  static editProfile(context) => showDialog(context: context, builder: (context) => EditProfileDialog());
  static delete(context) => showDialog(context: context, builder: (context) => DeleteDialog(ref: massRef,));
  static logout(context) => showDialog(context: context, builder: (context) => LogOutDialog());
}