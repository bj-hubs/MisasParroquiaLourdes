import 'package:misas/shared/global.dart';
import 'package:misas/widgets/delete_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DeleteReservationScreen extends StatefulWidget {
  @override
  _DeleteReservationScreenState createState() => _DeleteReservationScreenState();
}

class _DeleteReservationScreenState extends State<DeleteReservationScreen> {
  @override
  Widget build(BuildContext context) {

    int daysToAdd = (DateTime.saturday - DateTime.now().weekday + 7) % 7;

    if (daysToAdd < 0) daysToAdd *= -1;

    DateTime nextSat = DateTime.now().add(Duration(days: daysToAdd));
    nextSat = DateTime(nextSat.year, nextSat.month, nextSat.day, 0, 0, 0);
    DateTime nextSun = DateTime.now().add(Duration(days: daysToAdd + 1));
    nextSun = DateTime(nextSun.year, nextSun.month, nextSun.day, 0, 0, 0);
    DateTime nextMon = DateTime(nextSun.year, nextSun.month, nextSun.day, 0, 0, 0).add(Duration(days: 1));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cancelar Reservación'),
        backgroundColor: Global.primary,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: StreamBuilder(
            stream: Global.firestore
                .collection(Global.usersRef)
                .doc(FirebaseAuth.instance.currentUser.uid)
                .collection(Global.reservationsRef)
                .where('date',
                    isGreaterThanOrEqualTo: DateTime.now(),
                    isLessThan: nextMon)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  shrinkWrap: true,
                  children: snapshot.data.docs.map((mass) {
                    return DeleteCard(
                      date: mass['date'].toDate(),
                      subsidiary: mass['subsidiary'],
                      ref: mass['massRef'],
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
