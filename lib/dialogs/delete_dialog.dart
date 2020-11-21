import 'package:Misas/shared/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DeleteDialog extends StatefulWidget {
  final DocumentReference ref;

  const DeleteDialog({Key key, this.ref}) : super(key: key);

  @override
  _DeleteDialogState createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  bool btnEnabled = true;
  bool loading = false;

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
      ),
    );
  }

  _content(BuildContext context) => Container(
        height: 300,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(12)),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.red[900],
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          'Cancelación',
                          style: TextStyle(fontSize: 25.0, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          '¿Desea cancelar esta reservación?',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: RaisedButton(
                            color: Colors.red[900],
                            onPressed: btnEnabled
                                ? () {
                                    deleteReservation(context);
                                  }
                                : null,
                            child: Icon(
                              FontAwesomeIcons.check,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          child: RaisedButton(
                            color: Colors.red[900],
                            onPressed: btnEnabled
                                ? () {
                                    Navigator.of(context).pop(false);
                                  }
                                : null,
                            child: Icon(
                              FontAwesomeIcons.times,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              loading
                  ? Center(
                      child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: AlignmentDirectional.center,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      );

  deleteReservation(context) async {
    setState(() {
      loading = true;
      btnEnabled = false;
    });

    try {
      int total = 0;

      await widget.ref.get().then((value) => {total = value['spacesTaken']});

      await widget.ref
          .collection(Global.assistandRef)
          .where('signedBy', isEqualTo: Global.userInfo.id)
          .get()
          .then((value) => {
                if (value.docs.isNotEmpty)
                  value.docs.forEach((element) {
                    element.reference.delete();

                    Global.firestore
                        .collection(Global.usersRef)
                        .where('id', isEqualTo: element['id'])
                        .get()
                        .then((people) => {
                              people.docs.forEach((person) {
                                person.reference
                                    .collection(Global.reservationsRef)
                                    .doc(widget.ref.id)
                                    .delete();
                              })
                            });

                    total--;
                  })
              });

      await widget.ref
          .collection(Global.assistandRef)
          .where('id', isEqualTo: Global.userInfo.id)
          .get()
          .then((value) => {
                if (value.docs.isNotEmpty)
                  value.docs.forEach((element) {
                    element.reference.delete();

                    Global.firestore
                        .collection(Global.usersRef)
                        .where('id', isEqualTo: element['id'])
                        .get()
                        .then((people) => {
                              people.docs.forEach((person) {
                                person.reference
                                    .collection(Global.reservationsRef)
                                    .doc(widget.ref.id)
                                    .delete();
                              })
                            });

                    total--;
                  })
              });

      await widget.ref
          .update({'spacesTaken': total, 'lastUpdate': DateTime.now()});

      setState(() {
        loading = false;
      });

      _displaySnackBar(context, 'Se ha cancelado su reservación con éxito', 2);

      Future.delayed(Duration(seconds: 3)).whenComplete(
          () => Navigator.of(context).pop(false));
    } catch (e) {
      setState(() {
        loading = false;
      });

      _displaySnackBar(context, 'ERROR: No se pudo cancelar su reservación', 2);

      Future.delayed(Duration(seconds: 3))
          .whenComplete(() => Navigator.of(context).pop(false));
    }
  }

  _displaySnackBar(BuildContext context, String message, int time) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: time, milliseconds: 0),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
