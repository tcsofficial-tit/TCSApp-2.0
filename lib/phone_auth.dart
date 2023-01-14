// ignore_for_file: prefer_function_declarations_over_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tcs_app_2/screens/newbie.dart';
import 'package:tcs_app_2/screens/otp_conformation_screen.dart';

class PhoneAuth {
  final String phoneNo;
  late String verificationId;
  String errorMessage = '';
  // For firebase auth
  final auth = FirebaseAuth.instance;

  PhoneAuth({required this.phoneNo});
//
  Future<void> verifyPhone(BuildContext context) async {
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) async {
      final res = await auth.signInWithCredential(phoneAuthCredential);
      // Todo After Verification Complete
      Navigator.of(context).pop();
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print('Auth Exception is ${authException.message}');
    };


    final PhoneCodeSent codeSent =
        (String verificationId, int? forceResendingToken) {
      print('verification id is $verificationId');
      this.verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this.verificationId = verificationId;
    };

    await auth.verifyPhoneNumber(
      // mobile no. with country code
      phoneNumber: phoneNo,
      timeout: const Duration(seconds: 30),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  signIn(context, PrimitiveWrapper data, {required String smsOTP}) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      final res = await auth.signInWithCredential(credential);
      print("authenticated");
      // Todo After Verification Complete
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        data.isLoading = false;
        showDialog(
            context: context,
            builder: (BuildContext builderContext) {
              return AlertDialog(
                title: Text("Invalid OTP"),
                content: Text("The OTP you entered is invalid"),
                actions: [
                  TextButton(
                    child: Text("Ok"),
                    onPressed: () async {
                      Navigator.of(builderContext).pop();
                    },
                  )
                ],
              );
            });
      }
    } catch (e) {
      print(e);
    }
  }

  void signout() {
    auth.signOut();
  }
}

