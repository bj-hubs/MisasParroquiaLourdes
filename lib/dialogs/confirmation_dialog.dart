import 'package:Misas/dialogs/dialog_helper.dart';
import 'package:Misas/shared/global.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConfirmationDialog extends StatefulWidget {
  final int people;
  final DateTime date;
  final int subsidiaryIndex;

  const ConfirmationDialog(
      {Key key, this.people, this.date, this.subsidiaryIndex})
      : super(key: key);

  @override
  _ConfirmationDialogState createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  bool _nextEnabled = true;

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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
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
                              'Misa del Domingo 11 de Octubre',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              Global.subsidiaries[widget.subsidiaryIndex].name,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              Global.subsidiaries[widget.subsidiaryIndex].community,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Horario de 10:30 am',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: widget.people == 1
                                ? Text(
                                    '1 Campo Reservado',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  )
                                : Text(
                                    '${widget.people} Campos Reservados',
                                    style: TextStyle(
                                      fontSize: 18,
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
                            onPressed: _nextEnabled ? () {
                              setState(() {
                                _displaySnackBar(context,
                                    'Su espacio ha sido reservado con éxito');
                                _nextEnabled = false;
                                new Future.delayed(Duration(seconds: 3))
                                    .whenComplete(() => {
                                          Navigator.of(context).pop(false),
                                          DialogHelper.rules(context)
                                        });
                              });
                            } : null,
                            color: Colors.green[400],
                            child: Icon(
                              FontAwesomeIcons.check,
                              color: Colors.black45,
                            ),
                          ),
                          RaisedButton(
                            onPressed: _nextEnabled
                                ? () {
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
                )
              ],
            ),
          ),
        ),
      );

  _displaySnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2, milliseconds: 0),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
