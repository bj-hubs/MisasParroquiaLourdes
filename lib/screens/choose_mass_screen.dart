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

    int daysToAddSaturday = (DateTime.saturday - DateTime.now().weekday + 7) % 7;
    int daysToAddSunday = (DateTime.sunday - DateTime.now().weekday + 7) % 7;
    int daysToAddMonday = (DateTime.monday - DateTime.now().weekday + 7) % 7;

    if (daysToAddSaturday < 0) daysToAddSaturday *= -1;
    if (daysToAddSunday < 0) daysToAddSunday *= -1;
    if (daysToAddMonday < 0) daysToAddMonday *= -1;

    DateTime nextSat = DateTime.now().add(Duration(days: daysToAddSaturday));
    nextSat = DateTime(nextSat.year, nextSat.month, nextSat.day, 0, 0, 0);

    DateTime nextFri = DateTime(nextSat.year, nextSat.month, nextSat.day, 0, 0, 0).add(Duration(days: -1));

    DateTime nextSun = DateTime.now().add(Duration(days: daysToAddSunday));
    nextSun = DateTime(nextSun.year, nextSun.month, nextSun.day, 0, 0, 0);

    DateTime nextMon = DateTime.now().add(Duration(days: daysToAddMonday));
    nextMon = DateTime(nextMon.year, nextMon.month, nextMon.day, 0, 0, 0);

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
      body: isUnderLimit(nextSat, nextSun) ? SingleChildScrollView(
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
                        isGreaterThanOrEqualTo: nextSat,
                        isLessThan: nextSun,
                        isGreaterThan: nextFri)
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
      ) :
      Center(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Text(
                    'Nuevas Misas disponibles el próximo Lunes ${nextMon.day} de ${Global.getMonth(nextMon.month)}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
                  child: Text(
                    'Horario de reservación de espacios',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Text(
                    'Lunes de 8:30am a Sábados 12:00md',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
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

  bool isUnderLimit(nextSat, nextSun){
    DateTime limit = DateTime(nextSat.year, nextSat.month, nextSat.day, 12, 0, 0);

    if(DateTime.now().isBefore(limit) && nextSun.isAfter(nextSat)){
      return true;
    }
    else{
      return false;
    }
  }
}
