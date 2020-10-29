import 'package:Misas/shared/global.dart';
import 'package:cupertino_stepper/cupertino_stepper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    Global.fillUserQuestions();
    super.initState();
  }

  int currentStep = 0;
  var info = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
              switch (orientation) {
                case Orientation.portrait:
                  return _buildStepper(StepperType.vertical, context);
                case Orientation.landscape:
                  return _buildStepper(StepperType.horizontal, context);
                default:
                  throw UnimplementedError(orientation.toString());
              }
            },
          ),
        ),
      ),
    );
  }

  CupertinoStepper _buildStepper(StepperType type, context) {
    final canCancel = currentStep > 0;
    final canContinue = currentStep < Global.userQuestions.length;
    return CupertinoStepper(
      type: type,
      currentStep: currentStep,
      onStepTapped: (step) => setState(() => currentStep = step),
      onStepCancel: canCancel ? () => setState(() => --currentStep) : null,
      onStepContinue: canContinue
          ? currentStep == Global.userQuestions.length - 1
              ? () {
                  validateInfo(context);
                }
              : () {
                  setState(() => ++currentStep);
                }
          : null,
      steps: [
        for (var i = 0; i < Global.userQuestions.length; ++i)
          _buildStep(
            title: Text('${Global.userQuestions[i]}'),
            isActive: i == currentStep,
            state: i == currentStep
                ? StepState.editing
                : i < currentStep ? StepState.complete : StepState.indexed,
            step: i,
          )
      ],
    );
  }

  var maskFormatter = new MaskTextInputFormatter(
      mask: '#########', filter: {"#": RegExp(r'[0-9]')});
  List<TextEditingController> controllers = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController()
  ];
  int _value = 1;
  int minChars = 9;

  Step _buildStep(
      {@required Widget title,
      StepState state = StepState.indexed,
      bool isActive = false,
      int step}) {
    return Step(
      title: title,
      state: state,
      isActive: isActive,
      content: LimitedBox(
        child: Column(
          children: [
            step == 0
                ? Container(
                    width: double.infinity,
                    child: DropdownButton(
                        isExpanded: true,
                        value: _value,
                        items: [
                          DropdownMenuItem(
                            child: Text("Cédula persona física"),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text("Cédula persona jurídica"),
                            value: 2,
                          ),
                          DropdownMenuItem(child: Text("DIMEX"), value: 3),
                          DropdownMenuItem(child: Text("NITE"), value: 4)
                        ],
                        onChanged: (value) {
                          setState(() {
                            _value = value;
                            idFormater(value);
                          });
                        }),
                  )
                : Container(),
            TextField(
              controller: controllers[step],
              inputFormatters: step == 0 ? [maskFormatter] : [],
              keyboardType:
                  step == 0 ? TextInputType.number : TextInputType.text,
            ),
          ],
        ),
      ),
    );
  }

  idFormater(value) {
    switch (value) {
      case 1:
        maskFormatter = new MaskTextInputFormatter(
            mask: '#########', filter: {"#": RegExp(r'[0-9]')});
        minChars = 9;
        break;
      case 2:
        maskFormatter = new MaskTextInputFormatter(
            mask: '##########', filter: {"#": RegExp(r'[0-9]')});
        minChars = 10;
        break;
      case 3:
        maskFormatter = new MaskTextInputFormatter(
            mask: '############', filter: {"#": RegExp(r'[0-9]')});
        minChars = 11;
        break;
      case 4:
        maskFormatter = new MaskTextInputFormatter(
            mask: '##########', filter: {"#": RegExp(r'[0-9]')});
        minChars = 10;
        break;
    }
    controllers[0].clear();
  }

  validateInfo(context) {
    if (controllers[0].text.length >= minChars &&
        controllers[1].text.isNotEmpty &&
        controllers[2].text.isNotEmpty &&
        controllers[3].text.isNotEmpty) {
      var firebaseuser = FirebaseAuth.instance.currentUser;

      Global.firestore.collection(Global.usersRef).doc(firebaseuser.uid).set({
        'id': controllers[0].text.toUpperCase(),
        'name': controllers[1].text.toUpperCase(),
        'lastname': controllers[2].text.toUpperCase(),
        'secondLastname': controllers[3].text.toUpperCase(),
        'phone': firebaseuser.phoneNumber,
        'createdOn': DateTime.now(),
        'lastUpdate': DateTime.now(),
        'state': true
      });
      initUser();
    } else {
      _displaySnackBar(context, 'ERROR: Verifique los datos ingresados');
    }
  }

  _displaySnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3, milliseconds: 0),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  initUser() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;

    Map<String, dynamic> data;
    await Global.firestore
        .collection(Global.usersRef)
        .doc(firebaseUser.uid)
        .get()
        .then(
          (value) => {
            data = value.data(),
            Global.initUserInfo(
              data['id'],
              data['name'],
              data['lastname'],
              data['secondLastname'],
              data['phone'],
            ),
          },
        )
        .whenComplete(() => Navigator.of(context).pop());

    for (int i = 0; i < Global.subsidiaries.length; i++) {
      await Global.firestore
          .collection(Global.subsidiaryRef)
          .doc('$i')
          .collection(Global.massRef)
          .get()
          .then(
            (masses) => {
              masses.docs.forEach(
                (element) async {
                  await Global.firestore
                      .collection(Global.subsidiaryRef)
                      .doc('$i')
                      .collection(Global.massRef)
                      .doc(element.id)
                      .collection(Global.assistandRef)
                      .where('id', isEqualTo: Global.userInfo.id)
                      .get()
                      .then(
                        (value) => {
                          value.docs.forEach(
                            (assistand) {
                              data = element.data();
                              Global.firestore
                                  .collection(Global.usersRef)
                                  .doc(firebaseUser.uid)
                                  .collection(Global.reservationsRef)
                                  .doc(element.id)
                                  .set(
                                {
                                  'date': data['startDate'],
                                  'massRef': Global.firestore
                                      .collection(Global.subsidiaryRef)
                                      .doc('$i')
                                      .collection(Global.massRef)
                                      .doc(element.id),
                                  'subsidiary': i
                                },
                              );
                            },
                          )
                        },
                      );
                },
              )
            },
          );
    }
  }
}
