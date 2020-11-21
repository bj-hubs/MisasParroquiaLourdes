import 'package:Misas/dialogs/dialog_helper.dart';
import 'package:Misas/shared/global.dart';
import 'package:flutter/material.dart';

class CardEvent extends StatefulWidget {
  const CardEvent({
    Key key,
    this.color,
    this.start,
    this.end,
    this.people,
    this.index,
    this.total,
    this.current,
    this.day,
    this.date,
    this.id,
  }) : super(key: key);

  final Color color;
  final String start;
  final String end;

  final String day;

  final DateTime date;

  final int total;
  final int current;

  final int people;
  final int index;

  final String id;

  @override
  _CardEventState createState() => _CardEventState();
}

class _CardEventState extends State<CardEvent> {
  bool ok = true;

  @override
  Widget build(BuildContext context) {
    checkMass();
    return GestureDetector(
      onTap: widget.current + widget.people > widget.total || !ok
          ? null
          : () {
              DialogHelper.day = widget.day;
              DialogHelper.hour = widget.start;
              DialogHelper.date = widget.date;
              DialogHelper.massId = widget.id;

              widget.people > 1
                  ? Navigator.of(context).pushNamed('/mass/companions',
                      arguments: [
                          widget.index.toString(),
                          widget.people.toString()
                        ])
                  : DialogHelper.confirmation(context);
            },
      child: Card(
        color: widget.current + widget.people > widget.total || !ok
            ? widget.color.withOpacity(0.2)
            : widget.color,
        child: Container(
          height: 100,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Inicia: ${widget.start}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'Finaliza: ${widget.end}',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Container(
                color: Colors.white.withOpacity(0.6),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Espacios',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        '${widget.current}/${widget.total}',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  checkMass() {
    Global.firestore
        .collection(Global.subsidiaryRef)
        .doc(widget.index.toString())
        .collection(Global.massRef)
        .doc(widget.id)
        .collection(Global.assistandRef)
        .where('id', isEqualTo: Global.userInfo.id)
        .get()
        .then((value) => {
              if (value.docs.isNotEmpty)
                {
                  setState(() {
                    ok = false;
                  })
                }
            });
  }
}
