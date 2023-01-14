import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tcs_app_2/phone_auth.dart';
import 'package:velocity_x/velocity_x.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class PrimitiveWrapper {
  bool isLoading;
  PrimitiveWrapper(this.isLoading);
}

class OTPConfirmationPage extends StatefulWidget {
  final String phoneNo;

  const OTPConfirmationPage({Key? key, required this.phoneNo})
      : super(key: key);

  @override
  _OTPConfirmationPageState createState() => _OTPConfirmationPageState();
}

class _OTPConfirmationPageState extends State<OTPConfirmationPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late String phoneNo;
  String _otp = '0';
  final FocusNode _blankFocusNode = FocusNode();
  late PhoneAuth phoneAuth;
  bool isLoading = false;
  PrimitiveWrapper data = PrimitiveWrapper(false);
  @override
  void initState() {
    super.initState();
    phoneNo = widget.phoneNo;
    phoneAuth = PhoneAuth(phoneNo: widget.phoneNo);
    phoneAuth.verifyPhone(context);
    _initAnimationController();
    _animationController.forward();
  }

  _initAnimationController() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String? numberCountValidator(value, int requiredCount) {
    if (value.length < requiredCount || value.length > requiredCount) {
      return "Invalid";
    } else {
      _formKey.currentState!.save();
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var heightPiece = MediaQuery.of(context).size.height / 10;
    var widthPiece = MediaQuery.of(context).size.width / 10;
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        reverse: true,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
          ),
          child: Stack(
            children: [
              VxAnimatedBox()
                  .size(context.screenWidth, context.screenHeight)
                  .withGradient(const LinearGradient(colors: [
                    Vx.orange400,
                    Vx.purple500,
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight))
                  .make(),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  FocusScope.of(context).requestFocus(_blankFocusNode);
                },
                child: FadeTransition(
                  opacity: _animationController,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.3),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: Curves.easeIn,
                      ),
                    ),
                    child: Center(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(),
                        child: Container(
                          width: context.screenWidth * 9 / 10,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(16)),
                          child: Form(
                            key: _formKey,
                            child: Padding(
                              padding: EdgeInsets.all(widthPiece / 2),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: heightPiece / 3),
                                        child: buildOTPsentText()),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: heightPiece / 3),
                                        child: showRegisteredMobileNumber()),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: heightPiece / 3),
                                        child: buildEnterOTPText()),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: heightPiece / 2),
                                        child: Center(
                                          child: otpInputFieldConfig(),
                                        )),
                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: heightPiece / 2,
                                            bottom: heightPiece / 3),
                                        child: data.isLoading
                                            ? const CircularProgressIndicator(
                                                color: Vx.purple600,
                                              )
                                            : CustomButton(
                                                autoSize: true,
                                                text: 'Proceed',
                                                onPressed: () async {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    setState(() {
                                                      data.isLoading = true;
                                                    });
                                                    phoneAuth.signIn(
                                                        context, data,
                                                        smsOTP: _otp);
                                                  }
                                                },
                                              ),
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              AppBar(
                title: "OTP Verification".text.xl3.bold.white.make().shimmer(
                    primaryColor: Vx.purple300, secondaryColor: Colors.white),
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                centerTitle: true,
              ).h(130.0).px12(),
            ],
          ),
        ),
      ),
    ));
  }

  otpInputFieldConfig() {
    return VxPinView(
      keyboardType: TextInputType.number,
      radius: 10,
      space: 2,
      size: 45,
      contentColor: Colors.black,
      color: Vx.purple700,
      count: 6,
      obscureText: false,
      onSubmitted: ((value) {
        _otp = value;
      }),
      onChanged: ((value) {
        _otp = value;
      }),
    );
  }

  buildOTPsentText() {
    return const Text(
      'Verify the otp sent to this number',
      style: TextStyle(fontSize: 22),
    );
  }

  showRegisteredMobileNumber() {
    final x = widget.phoneNo;
    return ("${x.substring(0, x.length - 10)} ${x.substring(x.length - 10, x.length)}")
        .text
        .xl4
        .bold
        .white
        .make()
        .shimmer(primaryColor: Vx.black, secondaryColor: Colors.purple);
  }

  buildEnterOTPText() {
    return const Text('Enter OTP', style: TextStyle(fontSize: 22));
  }
}
