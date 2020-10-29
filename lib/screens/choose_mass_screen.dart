import 'package:Misas/dialogs/dialog_helper.dart';
import 'package:Misas/shared/global.dart';
import 'package:Misas/widgets/event_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChooseMassScreen extends StatefulWidget {
  final int subsidiaryIndex;
  final int quantity;

  const ChooseMassScreen({Key key, this.subsidiaryIndex, this.quantity})
      : super(key: key);

  @override
  _ChooseMassScreenState createState() => _ChooseMassScreenState();
}

class _ChooseMassScreenState extends State<ChooseMassScreen> {
  @override
  Widget build(BuildContext context) {
    DialogHelper.people = widget.quantity;

    int daysToAdd = (DateTime.saturday - DateTime.now().weekday + 7) % 7;

    if (daysToAdd < 0) daysToAdd *= -1;

    DateTime nextSat = DateTime.now().add(Duration(days: daysToAdd));
    nextSat = DateTime(nextSat.year, nextSat.month, nextSat.day, 0, 0, 0);
    DateTime nextSun = DateTime.now().add(Duration(days: daysToAdd + 1));
    nextSun = DateTime(nextSun.year, nextSun.month, nextSun.day, 0, 0, 0);
    DateTime nextMon =
        DateTime(nextSun.year, nextSun.month, nextSun.day, 0, 0, 0)
            .add(Duration(days: 1));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black54),
        title: Text(
          '${Global.subsidiaries[widget.subsidiaryIndex].name}',
          style: TextStyle(fontSize: 20, color: Colors.black54),
        ),
        backgroundColor: Global.subsidiaries[widget.subsidiaryIndex].color,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text(
                  'Sábado ${nextSat.day} de ${Global.getMonth(nextSat.month)}',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Container(
                  child: StreamBuilder(
                stream: Global.firestore
                    .collection(Global.subsidiaryRef)
                    .doc(widget.subsidiaryIndex.toString())
                    .collection(Global.massRef)
                    .where('startDate',
                        isGreaterThanOrEqualTo: DateTime.now(),
                        isLessThan: nextSun)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                        print(mass);
                        return CardEvent(
                          start: getHour(mass['startDate']),
                          end: getHour(mass['endDate']),
                          index: widget.subsidiaryIndex,
                          total: mass['totalSpaces'],
                          current: mass['spacesTaken'],
                          people: widget.quantity,
                          color: Global.subsidiaries[widget.subsidiaryIndex].color,
                          day: 'Sábado',
                          date: mass['startDate'].toDate(),
                          id: mass.id,
                        );
                      }).toList(),
                    ),
                  );
                },
              )),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  'Domingo ${nextSun.day} de ${Global.getMonth(nextSun.month)}',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Container(
                  child: StreamBuilder(
                stream: Global.firestore
                    .collection(Global.subsidiaryRef)
                    .doc(widget.subsidiaryIndex.toString())
                    .collection(Global.massRef)
                    .where('startDate',
                        isGreaterThanOrEqualTo: DateTime.now(),
                        isLessThan: nextMon,
                        isGreaterThan: nextSun)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                        return CardEvent(
                          start: getHour(mass['startDate']),
                          end: getHour(mass['endDate']),
                          index: widget.subsidiaryIndex,
                          total: mass['totalSpaces'],
                          current: mass['spacesTaken'],
                          people: widget.quantity,
                          color:
                              Global.subsidiaries[widget.subsidiaryIndex].color,
                          day: 'Domingo',
                          date: mass['startDate'].toDate(),
                          id: mass.id,
                        );
                      }).toList(),
                    ),
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }

  String getHour(Timestamp time) {
    DateTime date = time.toDate();
    String timeText =
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    return timeText;
  }
}
