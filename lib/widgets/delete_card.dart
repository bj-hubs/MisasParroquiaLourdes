import 'package:Misas/dialogs/dialog_helper.dart';
import 'package:Misas/shared/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DeleteCard extends StatefulWidget {
  final int subsidiary;
  final DocumentReference ref;
  final DateTime date;
  final String document;

  const DeleteCard({Key key, this.subsidiary, this.ref, this.date, this.document})
      : super(key: key);

  @override
  _DeleteCardState createState() => _DeleteCardState();
}

class _DeleteCardState extends State<DeleteCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Global.primary,
      child: Container(
        height: 100,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${Global.subsidiaries[widget.subsidiary].community}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${Global.getDay(widget.date.weekday)} ${widget.date.day} de ${Global.getMonth(widget.date.month)}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Hora: ${widget.date.hour.toString().padLeft(2, '0')} : ${(widget.date.minute).toString().padLeft(2, '0')}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              MaterialButton(
                onPressed: () {
                  DialogHelper.subsidiary = widget.subsidiary;
                  DialogHelper.date = widget.date;
                  DialogHelper.massRef = widget.ref;
                  DialogHelper.delete(context);
                },
                color: Colors.white,
                textColor: Colors.black54,
                child: Icon(
                  FontAwesomeIcons.times,
                  size: 24,
                ),
                padding: EdgeInsets.all(10),
                shape: CircleBorder(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
