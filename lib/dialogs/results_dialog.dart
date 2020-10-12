import 'package:Misas/models/results.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ResultsDialog extends StatefulWidget {
  final int totalPoints;

  const ResultsDialog({Key key, @required this.totalPoints}) : super(key: key);

  @override
  _ResultsDialogState createState() => _ResultsDialogState();
}

class _ResultsDialogState extends State<ResultsDialog> {
  Results _results;

  @override
  void initState() {
    getResults();
    super.initState();
  }

  getResults(){
    switch(widget.totalPoints){
      case 0:
      case 1:
      case 2:
        return _results = new Results('Podría ser estrés, tomá tus precauciones', FontAwesomeIcons.solidLaughBeam, Colors.limeAccent[700]);
        break;
      case 3:
      case 4:
      case 5:
        return _results = new Results('Hidratate, conserva medidas de higiene y reevalua en 2 días', FontAwesomeIcons.solidSmileBeam, Colors.green[400]);
        break;
      case 6:
      case 7:
      case 8:
      case 9:
      case 10:
      case 11:
        return _results = new Results('Acude a consulta a tu centro de salud más cercano', FontAwesomeIcons.solidFrown, Colors.yellow[700]);
        break;
      default:
        return _results = new Results('Llama a los servicios para realizar una prueba de COVID-19', FontAwesomeIcons.solidFrownOpen, Colors.red[600]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) => Container(
        height: 380,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(12)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: _results.color,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          'Resultados',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Icon(_results.icon, size: 100, color: _results.color,),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(_results.text, style: TextStyle(fontSize: 18),textAlign: TextAlign.center,),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).popUntil(ModalRoute.withName('/'));
                      },
                      child: Text('Continuar'),
                      color: _results.color,
                    ),
              ),
            ],
          ),
        ),
      );
}