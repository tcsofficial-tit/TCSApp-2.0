import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tcs_app_2/screens/login_screen.dart';
import 'package:tcs_app_2/screens/home.dart';
import 'package:tcs_app_2/screens/newbie.dart';
import 'package:tcs_app_2/screens/otp_conformation_screen.dart';

class RoutingBasedOnAuth{
  checkAuth(){
     return StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data != null) {
              User user = snapshot.data as User;
              if(user.displayName==""||user.displayName==null){
                return newMember();
              }
              else {
                print("In stream else");
                print(user.displayName);
                return home();
              }
            } 
            else {
              return LoginScreen();
              // return OTPConfirmationPage(phoneNo: "+911234567899");
            }
          }

          return CircularProgressIndicator();
        });
  }
}