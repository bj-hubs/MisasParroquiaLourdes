import 'dart:async';

import 'package:Misas/services/auth_service.dart';
import 'package:Misas/shared/global.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyCodeDialog extends StatefulWidget {
  final String verificationId;

  VerifyCodeDialog({Key key, @required this.verificationId});

  @override
  _VerifyCodeDialogState createState() =>
      _VerifyCodeDialogState(verificationId);
}

class _VerifyCodeDialogState extends State<VerifyCodeDialog> {
  final _code = TextEditingController();
  final String verId;

  _VerifyCodeDialogState(this.verId);

  @override
  void initState() {
    noCodeHandler();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Timer _timer;
  int _time = 60;
  bool btnEnabled = false;

  void noCodeHandler() {

    _timer = new Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) => setState(
        () {
          if(Global.isLogged){
            Navigator.of(context).pop();
          }
          if (_time < 1) {
            btnEnabled = true;
            timer.cancel();
          } else {
            _time = _time - 1;
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: _buildChild(context, verId, btnEnabled),
      ),
    );
  }

  _buildChild(BuildContext context, String verId, bool btnEnabled) => Container(
        height: 320,
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
                      'Verificación',
                      style: TextStyle(fontSize: 25.0, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    PinCodeTextField(
                      textInputType: TextInputType.number,
                      length: 6,
                      obsecureText: false,
                      animationType: AnimationType.fade,
                      autoDismissKeyboard: true,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeColor: Global.primary,
                        activeFillColor: Global.secondary.withOpacity(.8),
                        inactiveColor: Global.secondary.withOpacity(.5),
                        inactiveFillColor: Colors.white,
                        selectedFillColor: Global.primary.withOpacity(.1),
                        selectedColor: Global.primary.withOpacity(.6),
                      ),
                      animationDuration: Duration(milliseconds: 300),
                      enableActiveFill: true,
                      controller: _code,
                      onCompleted: (v) {
                        AuthService().signInWithOTP(_code.text, verId, context);
                      },
                      onChanged: (value) {
                        setState(() {});
                      },
                      beforeTextPaste: (text) {
                        return true;
                      },
                    ),
                    Text(
                      '¿No ha recibido el código?',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    !btnEnabled ? 
                    Text('$_time', style: TextStyle(color: Global.primary, fontSize: 50),) :
                    Container(
                      width: double.infinity,
                      height: 70,
                      child: RaisedButton(
                        color: Global.secondary,
                        onPressed:() { Navigator.of(context).pop(false); },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: _time < 1 ? Text(
                            'Verifique el número de teléfono',
                            style: TextStyle(fontSize: 20, color: Colors.black54),
                            textAlign: TextAlign.center,
                          ) : Text('$_time'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ));
}
