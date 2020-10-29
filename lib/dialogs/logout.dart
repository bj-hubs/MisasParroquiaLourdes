import 'package:Misas/services/auth_service.dart';
import 'package:Misas/shared/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LogOutDialog extends StatefulWidget {
  final DocumentReference ref;

  const LogOutDialog({Key key, this.ref}) : super(key: key);

  @override
  _LogOutDialogState createState() => _LogOutDialogState();
}

class _LogOutDialogState extends State<LogOutDialog> {
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
        height: 270,
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
                          'Cerrar Sesión',
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
                          '¿Desea cerrar la sesión?',
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
                            onPressed:() {
                                    Global.cleanUserInfo();
                                    Navigator.of(context).pop(false);
                                    
                                    Future.delayed(Duration(seconds: 1)).whenComplete(() => {
                                      AuthService().signOut()
                                    });
                                  },
                            child: Icon(
                              FontAwesomeIcons.check,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          child: RaisedButton(
                            color: Colors.red[900],
                            onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
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
            ],
          ),
        ),
      );

}
