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
                    child: Text(
                      'Esta es una AUTOEVALUACIÓN, si presenta sintomas o cree que puede portar el virus comuníquese con un médico.',
                      style: TextStyle(fontSize: 18,),
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
