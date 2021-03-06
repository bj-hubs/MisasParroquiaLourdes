import 'package:misas/main.dart';
import 'package:misas/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:misas/shared/global.dart';

class AuthService{
  handleAuth(){
    return StreamBuilder(
      stream:  FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot){
        if(snapshot.hasData){
          Global.isLogged = true;
          if (Global.subsidiaries.isEmpty) Global.fillSubsidiaries();
          return BottomNavBar();
        }else{
          Global.isLogged = false;
          return LogInScreen();
        }
      },
    );
  }

  signIn(AuthCredential authCreds){
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }

  signInWithOTP(smsCode, verId, context) {
    AuthCredential authCreds = PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    signIn(authCreds);
  }

  signOut(){
    FirebaseAuth.instance.signOut();
  }

}