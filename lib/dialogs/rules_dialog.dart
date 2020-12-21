import 'package:misas/models/rule.dart';
import 'package:misas/shared/global.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_stepper/progress_stepper.dart';

class RulesDialog extends StatefulWidget {
  @override
  _RulesDialogState createState() => _RulesDialogState();
}

class _RulesDialogState extends State<RulesDialog> {
  @override
  void initState() {
    if (rules.isEmpty) fillRules();
    super.initState();
  }

  List<Rule> rules = <Rule>[];

  fillRules() {
    rules.add(new Rule(
        'No ocupa un tiquete para asistir a la santa misa, solo realizar la reservación',
        FontAwesomeIcons.calendarCheck));
    rules.add(new Rule(
        'Todas las personas que asistan a la santa misa deberán dar su número de cédula para ingresar al templo',
        FontAwesomeIcons.idCard));
    rules.add(new Rule(
        'Recuerde utilizar cubre bocas', FontAwesomeIcons.headSideMask));
    rules.add(new Rule(
        'Es recomendable realizar la autoevaluación de COVID-19 de la aplicación antes de asistir a la santa misa',
        FontAwesomeIcons.notesMedical));
  }

  int _counter = 0;

  bool _prevEnabled = false;

  void _incrementStepper(context) {
    setState(() {
      if (_counter == rules.length - 1) {
        Navigator.of(context).popUntil(ModalRoute.withName('/'));
      } else
        _counter++;
    });
  }

  void _decreaseStepper() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_counter == 0)
      _prevEnabled = false;
    else
      _prevEnabled = true;

    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
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
          )),
    );
  }

  _content(BuildContext context) => SingleChildScrollView(
        child: Container(
          height: 550,
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
                        'Instrucciones',
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
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, bottom: 20.0, top: 20),
                          child: Container(
                            width: double.infinity,
                            height: 280,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Global.secondary.withOpacity(0.3),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Icon(
                                    rules[_counter].icon,
                                    color: Global.primary.withOpacity(.5),
                                    size: 100,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Center(
                                    child: Text(
                                      rules[_counter].text,
                                      style: TextStyle(fontSize: 18),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RaisedButton(
                          onPressed: _prevEnabled
                              ? () {
                                  _decreaseStepper();
                                }
                              : null,
                          color: Global.secondary,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              FontAwesomeIcons.chevronLeft,
                              color: Colors.black45,
                            ),
                          ),
                        ),
                        RaisedButton(
                          onPressed: () {
                            _incrementStepper(context);
                          },
                          color: Global.secondary,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: _counter == rules.length - 1 ?  Icon(
                              FontAwesomeIcons.check,
                              color: Colors.black45,
                            ) : Icon(
                              FontAwesomeIcons.chevronRight,
                              color: Colors.black45,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: ProgressStepper(
                        width: 150,
                        height: 15,
                        padding: 2,
                        stepCount: rules.length - 1,
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
        ),
      );
}
