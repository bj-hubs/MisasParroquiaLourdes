import 'package:Misas/dialogs/dialog_helper.dart';
import 'package:Misas/shared/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConfirmationDialog extends StatefulWidget {
  final int people;
  final DateTime date;
  final int subsidiaryIndex;
  final String day;
  final String massId;
  final List<dynamic> assistands;

  const ConfirmationDialog(
      {Key key,
      this.people,
      this.date,
      this.subsidiaryIndex,
      this.day,
      this.massId,
      this.assistands})
      : super(key: key);

  @override
  _ConfirmationDialogState createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  bool _nextEnabled = true;
  bool _cancelEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Builder(
          builder: (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: _content(context),
          ),
        ));
  }

  _content(BuildContext context) => SingleChildScrollView(
        child: Container(
          height: 370,
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(12)),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Global.primary,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        'Verifique los Datos',
                        style: TextStyle(fontSize: 25.0, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Global.secondary.withOpacity(0.3),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Misa del ${widget.day} ${widget.date.day} de ${Global.getMonth(widget.date.month)}',
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                Global
                                    .subsidiaries[widget.subsidiaryIndex].name,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                Global.subsidiaries[widget.subsidiaryIndex]
                                    .community,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Horario de ${widget.date.hour}:${widget.date.minute.toString().padLeft(2, '0')}',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: widget.people == 1
                                  ? Text(
                                      '1 Campo Reservado',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    )
                                  : Text(
                                      '${widget.people} Campos Reservados',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RaisedButton(
                              onPressed: _nextEnabled
                                  ? () {
                                      saveSpace(context);
                                    }
                                  : null,
                              color: Colors.green[400],
                              child: Icon(
                                FontAwesomeIcons.check,
                                color: Colors.black45,
                              ),
                            ),
                            RaisedButton(
                              onPressed: _cancelEnabled
                                  ? () {
                                      DialogHelper.assistands = null;
                                      Navigator.of(context).pop(false);
                                    }
                                  : null,
                              color: Colors.red[300],
                              child: Icon(
                                FontAwesomeIcons.times,
                                color: Colors.black45,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );

  saveSpace(context) async {
    int total = 0;
    int current = 0;

    List<dynamic> result = new List<dynamic>();

    result.add(true);

    if (widget.assistands != null &&
        (widget.assistands.isNotEmpty ||
            widget.assistands[0] != 'empty' ||
            widget.assistands[0] != '')) result = await checkList();

    var mass = Global.firestore
        .collection(Global.subsidiaryRef)
        .doc(widget.subsidiaryIndex.toString())
        .collection(Global.massRef)
        .doc(widget.massId);

    if (result[0]) {
      await mass.collection(Global.assistandRef).add({
        'id': Global.userInfo.id,
        'fullName':
            '${Global.userInfo.name} ${Global.userInfo.lastname} ${Global.userInfo.secondLastname}',
        'phone': Global.userInfo.phone,
        'signedBy': Global.userInfo.id
      });

      if (widget.assistands != null)
        for (int i = 0; i < widget.people - 1; i += 3) {
          await mass.collection(Global.assistandRef).add({
            'id': widget.assistands[i],
            'phone': widget.assistands[i + 1],
            'fullName': widget.assistands[i + 2],
            'signedBy': Global.userInfo.id
          });

          await Global.firestore
              .collection(Global.usersRef)
              .where('id', isEqualTo: widget.assistands[i])
              .get()
              .then((value) => {
                    if(value.docs.isNotEmpty){
                        Global.firestore
                          .collection(Global.usersRef)
                          .doc(value.docs.first.id)
                          .collection(Global.reservationsRef)
                          .doc(widget.massId)
                          .set({
                        'massRef': mass,
                        'date': widget.date,
                        'subsidiary': widget.subsidiaryIndex
                      })
                    }
                  });
        }

      await mass.get().then(
            (value) => {
              total = value['totalSpaces'],
              current = value['spacesTaken'] + widget.people,
              if (current <= total)
                {
                  mass.update(
                    {
                      'spacesTaken': current,
                      'lastUpdate': DateTime.now(),
                    },
                  )
                }
            },
          );

      await Global.firestore
          .collection(Global.usersRef)
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection(Global.reservationsRef)
          .doc(widget.massId)
          .set({
        'massRef': mass,
        'date': widget.date,
        'subsidiary': widget.subsidiaryIndex
      });

      widget.people > 1
          ? _displaySnackBar(
              context, 'Sus espacios han sido reservados con éxito', 2)
          : _displaySnackBar(
              context, 'Su espacio ha sido reservado con éxito', 2);

      setState(() {
        _nextEnabled = false;
        _cancelEnabled = false;
      });

      new Future.delayed(Duration(seconds: 3)).whenComplete(() =>
          {Navigator.of(context).pop(false), DialogHelper.rules(context)});
    } else {
      setState(() {
        _nextEnabled = false;
      });

      _displaySnackBar(
          context,
          'ERROR: La persona con la cédula ${result[1]} ya se encuentra registrada en esta misa',
          8);
    }
  }

  Future<dynamic> checkList() async {
    String tempId;
    bool ok = true;

    for (int i = 0; i < widget.people; i++) {
      if (ok)
        await Global.firestore
            .collection(Global.subsidiaryRef)
            .doc(widget.subsidiaryIndex.toString())
            .collection(Global.massRef)
            .doc(widget.massId)
            .collection(Global.assistandRef)
            .where('id', isEqualTo: widget.assistands[i * 3])
            .get()
            .then((value) => {
                  if (value.docs.isNotEmpty)
                    {ok = false, tempId = value.docs.first['id']}
                });
      else
        break;
    }
    return [ok, tempId];
  }

  _displaySnackBar(BuildContext context, String message, int time) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: time, milliseconds: 0),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
