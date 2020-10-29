import 'package:Misas/main.dart';
import 'package:Misas/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService{
  handleAuth(){
    return StreamBuilder(
      stream:  FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot){
        if(snapshot.hasData){
          return BottomNavBar();
        }else{
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