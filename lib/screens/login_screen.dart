import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcs_app_2/screens/otp_conformation_screen.dart';
import 'package:velocity_x/velocity_x.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late String phoneNo;
  late AnimationController _animationController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _initAnimationController();
    _animationController.forward();
    super.initState();
  }

  _initAnimationController() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var widthPiece = MediaQuery.of(context).size.width / 10;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            VxAnimatedBox()
                .size(context.screenWidth, context.screenHeight)
                .withGradient(const LinearGradient(colors: [
                  Vx.orange400,
                  Vx.purple500,
                ], begin: Alignment.topLeft, end: Alignment.bottomRight))
                .make(),
            Center(
              child: BackdropFilter(
                filter: ImageFilter.blur(),
                child: FadeTransition(
                  opacity: _animationController,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(-2, 0),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: Curves.easeIn,
                      ),
                    ),
                    child: Container(
                      width: context.screenWidth * 9 / 10,
                      height: context.screenWidth * 9 / 10,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16)),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 20),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: widthPiece / 2),
                                child: buildCustomTextFieldForMobileNo()),
                            SizedBox(height: 20),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: widthPiece),
                              child: buildCustomButtonForSendOTPButton(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AppBar(
              title: "Login".text.xl4.bold.white.make().shimmer(
                  primaryColor: Vx.purple300, secondaryColor: Colors.white),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
            ).h(100.0).p16(),
          ],
        ),
      ),
    );
  }

  buildCustomButtonForSendOTPButton(BuildContext context) {
    return CustomButton(
        autoSize: true,
        text: 'Send OTP',
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            print("validated no");
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    OTPConfirmationPage(phoneNo: phoneNo)));
          }
        });
  }

  CustomTextField buildCustomTextFieldForMobileNo() {
    return CustomTextField(
        prefixText: "(+91) ",
        maxLength: 10,
        hintText: 'Enter 10 digit mobile no.',
        inputType: TextInputType.phone,
        onSaved: ((value) {
          phoneNo = '+91$value';
        }),
        validator: (value) {
          if (value!.length < 10 || value.length > 10) {
            return "Invalid";
          } else {
            print(value.length);
            _formKey.currentState!.save();
            return null;
          }
        });
  }
}
