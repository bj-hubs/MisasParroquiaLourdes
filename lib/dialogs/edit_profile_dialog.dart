import 'package:misas/shared/global.dart';
import 'package:misas/widgets/button_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfileDialog extends StatefulWidget {
  @override
  _EditProfileDialogState createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  String uid = FirebaseAuth.instance.currentUser.uid;
  String code;

  @override
  Widget build(BuildContext context) {
    code = uid.substring(uid.length - 5);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _content(context),
    );
  }

  _content(BuildContext context) => Container(
        height: 450,
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
                      'Editar Información',
                      style: TextStyle(fontSize: 25.0, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Si desea cambiar algún dato de su perfil, por favor comunicarse a la siguiente dirección de correo electrónico',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      'bj_hubs@hotmail.com',
                      style: TextStyle(color: Global.primary, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Deberá proporcionar su número de identificación y el siguiente código',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      '$code',
                      style: TextStyle(color: Global.primary, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ButtonContainer(
                        text: 'volver',
                        action: (){
                          Navigator.of(context).pop(false);
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
