import 'package:Misas/shared/global.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AutocheckScreen extends StatefulWidget {
  @override
  _AutocheckScreenState createState() => _AutocheckScreenState();
}

class _AutocheckScreenState extends State<AutocheckScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Autoevaluación COVID-19'),
        backgroundColor: Global.primary,
      ),
      body: Container(
          color: Colors.white,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      FontAwesomeIcons.infoCircle,
                      size: 50.0,
                      color: Global.primary.withOpacity(0.4),
                    ),
                  ),
                  Text(
                    'Recuerde',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0, bottom: 25.0),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18
                        ),
                        children: [
                          new TextSpan(text: 'Esta es una '),
                          new TextSpan(text: 'AUTOEVALUACIÓN', style: TextStyle(color: Global.primary, fontWeight: FontWeight.bold)),
                          new TextSpan(text: ', si presenta sintomas o cree que puede portar el virus llame a los servicios para realizar una prueba de COVID-19 y '),
                          new TextSpan(text: 'evite el contacto con otras personas.', style: TextStyle(color: Global.primary, fontWeight: FontWeight.bold))
                        ]
                      ),
                    ),
                  ),
                  RaisedButton(
                    onPressed: (){
                      Navigator.of(context).pushNamed('/profile/autocheck/questions');
                    },
                    color: Global.primary,
                    child: Text('Iniciar Evaluación', style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
