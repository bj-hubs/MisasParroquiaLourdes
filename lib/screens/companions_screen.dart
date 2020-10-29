import 'package:Misas/dialogs/dialog_helper.dart';
import 'package:Misas/shared/global.dart';
import 'package:cupertino_stepper/cupertino_stepper.dart';
import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CompanionsScreen extends StatefulWidget {
  final int subsidiaryIndex;
  final int quantity;

  const CompanionsScreen({Key key, this.subsidiaryIndex, this.quantity})
      : super(key: key);

  @override
  _CompanionsScreenState createState() => _CompanionsScreenState();
}

class _CompanionsScreenState extends State<CompanionsScreen> {
  String verificationId, phoneNo, smsCode, phoneNumber, phoneIsoCode;
  int currentStep = 0, pos = 0;
  var info = [];

  @override
  Widget build(BuildContext context) {
    int spaces = widget.quantity * 3;
    for (var i = 0; i < spaces; i++) {
      info.add('empty');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Acompañantes'),
        backgroundColor: Global.primary,
        centerTitle: true,
      ),
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
    );
  }

  CupertinoStepper _buildStepper(StepperType type, context) {
    final canCancel = currentStep > 0;
    final canContinue = currentStep < widget.quantity;
    pos = currentStep != 0 ? pos = currentStep + 2 : currentStep;
    return CupertinoStepper(
      type: type,
      currentStep: currentStep,
      onStepTapped: (step) => setState(() => currentStep = step),
      onStepCancel: canCancel
          ? () => setState(() {
                --currentStep;
              })
          : null,
      onStepContinue: canContinue
          ? currentStep == widget.quantity - 1
              ? () {
                  validateInfo(context);
                }
              : () {
                  setState(() {
                    ++currentStep;
                  });
                }
          : null,
      steps: [
        for (var i = 0; i < widget.quantity; ++i)
          _buildStep(
            title: Text('Acompañante ${i + 1}'),
            isActive: i == currentStep,
            state: i == currentStep
                ? StepState.editing
                : i < currentStep ? StepState.complete : StepState.indexed,
            step: i,
          )
      ],
    );
  }

  List<TextEditingController> controllers = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController()
  ];

  List<int> idType = [1, 1, 1, 1, 1];

  var masks = [
    new MaskTextInputFormatter(
        mask: '#########', filter: {"#": RegExp(r'[0-9]')}),
    new MaskTextInputFormatter(
        mask: '#########', filter: {"#": RegExp(r'[0-9]')}),
    new MaskTextInputFormatter(
        mask: '#########', filter: {"#": RegExp(r'[0-9]')}),
    new MaskTextInputFormatter(
        mask: '#########', filter: {"#": RegExp(r'[0-9]')}),
    new MaskTextInputFormatter(
        mask: '#########', filter: {"#": RegExp(r'[0-9]')}),
  ];

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
            Container(
              width: double.infinity,
              child: DropdownButton(
                  isExpanded: true,
                  value: idType[currentStep],
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
                      idType[currentStep] = value;
                      idFormater(value);
                    });
                  }),
            ),
            TextField(
              controller: controllers[currentStep],
              onChanged: (value) {
                setState(() {
                  if (value.length >= minChars){
                    if(value == Global.userInfo.id)
                      info[pos] = 'sameID';
                    else
                      info[pos] = controllers[currentStep].text;
                  }
                  else
                    info[pos] = 'empty';
                });
              },
              inputFormatters: [masks[currentStep]],
              decoration: InputDecoration(hintText: 'Identificación'),
              keyboardType: TextInputType.number,
            ),
            Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: InternationalPhoneInput(
                  onPhoneNumberChange: onPhoneNumberChange,
                  initialPhoneNumber: phoneNumber,
                  initialSelection: '+506',
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Tel: 61160002'),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    info[pos + 2] = value.toUpperCase();
                  });
                },
                decoration: InputDecoration(hintText: 'Nombre Completo'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  idFormater(value) {
    switch (value) {
      case 1:
        masks[currentStep] = new MaskTextInputFormatter(
            mask: '#########', filter: {"#": RegExp(r'[0-9]')});
        minChars = 9;
        break;
      case 2:
        masks[currentStep] = new MaskTextInputFormatter(
            mask: '##########', filter: {"#": RegExp(r'[0-9]')});
        minChars = 10;
        break;
      case 3:
        masks[currentStep] = new MaskTextInputFormatter(
            mask: '############', filter: {"#": RegExp(r'[0-9]')});
        minChars = 11;
        break;
      case 4:
        masks[currentStep] = new MaskTextInputFormatter(
            mask: '##########', filter: {"#": RegExp(r'[0-9]')});
        minChars = 10;
        break;
    }
    idType[currentStep] = value;
    controllers[currentStep].clear();
  }

  validateInfo(context) {
    bool ok = true;
    int spaces = widget.quantity * 3;
    for (var i = 0; i < spaces; i++) {
      if (info[i] == 'empty' || info[i].toString().isEmpty) {
        _displaySnackBar(context, 'ERROR: Verifique los datos ingresados $i', 3);
        ok = false;
        break;
      }
      if(info[i] == 'sameID'){
        _displaySnackBar(context, 'ERROR: Coloque ÚNICAMENTE la información de sus ACOMPAÑANTES, la suya no es necesaria.', 6);
        ok = false;
        break;
      }
    }
    if(ok){
      DialogHelper.assistands = info;
      DialogHelper.confirmation(context);
    } 
  }

  _displaySnackBar(BuildContext context, String message, int time) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: time, milliseconds: 0),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      if (internationalizedPhoneNumber.isNotEmpty) {
        phoneNo = '$internationalizedPhoneNumber';
        info[pos + 1] = phoneNo;
      } else {
        info[pos + 1] = 'empty';
      }
    });
  }
}
