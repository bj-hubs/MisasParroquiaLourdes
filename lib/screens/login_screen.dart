import 'package:Misas/services/auth_service.dart';
import 'package:Misas/shared/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:international_phone_input/international_phone_input.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  String verificationId, phoneNo, smsCode, phoneNumber, phoneIsoCode;
  bool codeSent = false, isBtnEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Container(
                  width: 300,
                  height: 300,
                  child: (ClipRRect(
                    child: Image.asset('assets/images/logo.png',
                        fit: BoxFit.contain),
                  )),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, bottom: 20.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          style: new TextStyle(
                            fontSize: 16.0,
                            color: Global.primary.withOpacity(.7),
                          ),
                          children: <TextSpan>[
                            new TextSpan(text: 'Se le enviará '),
                            new TextSpan(text: 'Un Código De Acceso ', style: TextStyle(color: Global.primary, fontWeight: FontWeight.bold)),
                            new TextSpan(
                                text: 'al siguiente número de teléfono'),
                          ]),
                    )),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30.0, right: 30.0, bottom: 20.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey[300], width: 1.0)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: InternationalPhoneInput(
                        onPhoneNumberChange: onPhoneNumberChange,
                        initialPhoneNumber: phoneNumber,
                        initialSelection: '+506',
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Tel: 61160002'),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Container(
                    width: double.infinity,
                    child: RaisedButton(
                      color: Global.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Continuar',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Icon(
                              FontAwesomeIcons.chevronRight,
                              size: 18,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed failed = (AuthException exception) {
      print('Error ${exception.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      verificationId = verId;
      /*DialogHelper.verId = verId;
      DialogHelper.codeValidation(context);*/
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 30),
        verificationCompleted: verified,
        verificationFailed: failed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      if (internationalizedPhoneNumber.isNotEmpty) {
        isBtnEnabled = true;
        phoneNo = '$internationalizedPhoneNumber';
      } else
        isBtnEnabled = false;
    });
  }
}
