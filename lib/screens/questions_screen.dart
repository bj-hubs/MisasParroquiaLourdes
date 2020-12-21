import 'package:misas/dialogs/dialog_helper.dart';
import 'package:misas/models/question.dart';
import 'package:misas/shared/global.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_stepper/progress_stepper.dart';

class QuestionsScreen extends StatefulWidget {
  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  @override
  void initState() {
    if (questions.isEmpty) fillQuestions();
    super.initState();
  }

  List<Question> questions = <Question>[];

  fillQuestions() {
    questions.add(new Question('¿Tienes tos?', 1));
    questions.add(new Question('¿Tienes escalofrios?', 1));
    questions.add(new Question('En este momento o en días previos ¿Has tenido diarrea?', 1));
    questions.add(new Question('¿Tienes dolor de garganta?', 1));
    questions.add(new Question('¿Tienes dolor de cuerpo y malestar general?', 1));
    questions.add(new Question('¿Presentas dolor de cabeza?', 1));
    questions.add(new Question('¿Has tenido fiebre? (38 persistente y con tendencia a incrementar)',1));
    questions.add(new Question('¿Has perdido el olfato?', 1));
    questions.add(new Question('¿Tienes dificulta de respirar? (como si no entrara aire al pecho)',2));
    questions.add(new Question('¿Experimenta Fatiga? (Real deterioro de movimientos y ganas de hacer las cosas)',2));
    questions.add(new Question('¿Has viajado en los últimos 14 días?', 3));
    questions.add(new Question('¿Has viajado o estado en un área afectada por COVID-19?', 3));
    questions.add(new Question('¿Has estado en contacto directo o cuidado de algún paciente positivo de COVID-19?',3));
  }

  int _counter = 0;
  int _totalPoints = 0;

  void _incrementStepper(int points) {
    setState(() {
      _totalPoints += points;
      if (_counter == questions.length - 1) {
        DialogHelper.total = _totalPoints;
        DialogHelper.results(context);
      } else
        _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Autoevaluación COVID-19'),
        backgroundColor: Global.primary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 0, bottom: 25.0),
                  child: Text(
                    questions[_counter].text,
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 100,
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                          _incrementStepper(questions[_counter].points);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              FontAwesomeIcons.solidThumbsUp,
                              color: Colors.white,
                            ),
                            Text(
                              'SI',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        color: Global.primary,
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                          _incrementStepper(0);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              FontAwesomeIcons.solidThumbsDown,
                              color: Colors.white,
                            ),
                            Text(
                              'NO',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        color: Global.primary,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ProgressStepper(
                    width: 350,
                    height: 15,
                    padding: 2,
                    stepCount: questions.length - 1,
                    progressColor: Global.primary,
                    currentStep: _counter,
                    onClick: (index) {
                      setState(() {
                        _counter = index;
                      });
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}