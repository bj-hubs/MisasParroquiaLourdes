import 'package:Misas/dialogs/dialog_helper.dart';
import 'package:Misas/shared/global.dart';
import 'package:Misas/widgets/event_card.dart';
import 'package:flutter/material.dart';

class ChooseMassScreen extends StatefulWidget {
  final int subsidiaryIndex;
  final int quantity;

  const ChooseMassScreen({Key key, this.subsidiaryIndex, this.quantity}) : super(key: key);

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
    DateTime nextSun = DateTime.now().add(Duration(days: daysToAdd + 1));

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
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          CardEvent(color: Global.subsidiaries[widget.subsidiaryIndex].color, start: '5:30 pm', end: '6:30 pm',),
                        ],
                      ),
                    );
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:30.0),
                child: Text(
                  'Domingo ${nextSun.day} de ${Global.getMonth(nextSun.month)}',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          CardEvent(color: Global.subsidiaries[widget.subsidiaryIndex].color, start: '7:00 am', end: '8:00 am', ),
                          CardEvent(color: Global.subsidiaries[widget.subsidiaryIndex].color, start: '10:30 am', end: '11:30 am',),
                          CardEvent(color: Global.subsidiaries[widget.subsidiaryIndex].color, start: '5:30 pm', end: '6:30 pm',),
                        ],
                      ),
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

