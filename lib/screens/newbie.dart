import 'package:datetime_picker_formfield_new/datetime_picker_formfield_new.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tcs_app_2/widgets/custom_button.dart';
import 'package:tcs_app_2/widgets/custom_text_field.dart';
import 'package:velocity_x/velocity_x.dart';

class newMember extends StatefulWidget {
  const newMember({Key? key}) : super(key: key);

  @override
  State<newMember> createState() => _newMemberState();
}

class _newMemberState extends State<newMember>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference dbRef =
      FirebaseDatabase.instance.ref().child("Users");
  late String name, email, gender;
  late DateTime date;
  final iconPerPronoun = {
    "he/him": Icons.male,
    "she/her": Icons.female,
    "they/them": Icons.transgender,
    "I prefer not to say": Icons.thumb_up_sharp
  };
  final genderPerPronoun = {
    "he/him": "Male",
    "she/her": "Female",
    "they/them": "Non Binary",
    "I prefer not to say": "Not Disclosed"
  };
  IconData? genderIcon = Icons.circle_outlined;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  bool isLoading = false;

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
    var heightPiece = MediaQuery.of(context).size.height / 10;
    var widthPiece = MediaQuery.of(context).size.width / 10;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          reverse: false,
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
                      Vx.blue500,
                      Vx.purple600,
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight))
                    .make(),
                Center(
                  child: FadeTransition(
                    opacity: _animationController,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(2, 0),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: Curves.easeIn,
                        ),
                      ),
                      child: VxGlassmorphic(
                        opacity: 0.1,
                        width: context.screenWidth * 9 / 10,
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: EdgeInsets.all(widthPiece / 2),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: heightPiece / 3),
                                  child: buildCustomTextFieldForName(),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: heightPiece / 3),
                                  child: buildCustomTextFiledForEMail(),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: heightPiece / 3),
                                  child: buildDateTimeField(),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: heightPiece / 3),
                                  child: buildDropDownButtonFormField(),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width / 4, vertical: 20),
                                  child:
                                      buildCustomButtonForRegistration(context),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                FadeTransition(
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
                        child: AppBar(
                          title: "Registration"
                              .text
                              .xl4
                              .bold
                              .white
                              .make()
                              .shimmer(
                                  primaryColor: Vx.purple300,
                                  secondaryColor: Colors.white),
                          backgroundColor: Colors.transparent,
                          elevation: 0.0,
                          centerTitle: true,
                        ).h(100.0).p16())),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CustomTextField buildCustomTextFieldForName() {
    return CustomTextField(
      prefixIcon: Icons.person,
      hintText: "Enter Full Name",
      inputType: TextInputType.name,
      onSaved: ((input) {
        name = input!;
      }),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Your Full Name';
        }
        _formKey.currentState!.save();
        return null;
      },
    );
  }

  buildCustomTextFiledForEMail() {
    return CustomTextField(
      prefixIcon: Icons.email,
      hintText: "Enter Email Address",
      inputType: TextInputType.emailAddress,
      onSaved: ((input) {
        email = input!;
      }),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter an Email Address';
        } else if (!value.contains('@')) {
          return 'Please enter a valid email address';
        }
        _formKey.currentState!.save();
        return null;
      },
    );
  }

  buildDateTimeField() {
    return DateTimeField(
      decoration: const InputDecoration(
          hintText: "Enter Date of Birth",
          prefixIcon: Icon(
            Icons.date_range,
            color: Colors.grey,
          ),
          border: InputBorder.none,
          fillColor: Color.fromRGBO(255, 255, 255, 1),
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(16.0, 14.0, 15.0, 13.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 1)),
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          )),
      onSaved: ((input) {
        date = input ?? DateTime.now();
      }),
      validator: (value) {
        if (value == null) {
          return 'Enter DOB';
        }
        _formKey.currentState!.save();
        return null;
      },
      format: DateFormat("dd/MM/yyyy"),
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
      },
    );
  }

  buildDropDownButtonFormField() {
    return DropdownButtonFormField<String>(
        onChanged: (String? value) {
          setState(() {
            genderIcon = iconPerPronoun[value!];
            gender = genderPerPronoun[value] as String;
          });
        },
        decoration: InputDecoration(
            hintText: "Preferred Pronoun",
            prefixIcon: Icon(
              genderIcon,
              color: Colors.grey,
            ),
            border: InputBorder.none,
            fillColor: Color.fromRGBO(255, 255, 255, 1),
            filled: true,
            contentPadding: const EdgeInsets.fromLTRB(16.0, 14.0, 15.0, 13.0),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 1)),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            )),
        validator: (value) {
          if (value.toString().isEmpty || value == null) {
            return 'What pronoun do you use?';
          }
          _formKey.currentState!.save();
          return null;
        },
        items:
            iconPerPronoun.keys.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList());
  }

  buildCustomButtonForRegistration(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : CustomButton(
            text: 'Continue',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save;
                print("validated newbie");
                print(email);
                try {
                  setState(() {
                    isLoading = true;
                  });
                  final user = _auth.currentUser;
                  final phone = user!.phoneNumber;
                  user.updateEmail(email).catchError((e) {
                    if (e.code == 'requires-recent-login') {
                      showMessage(
                          "Sorry, there was an error.\nTry signing in again!");
                      _auth.signOut();
                    }
                  }).then((_) async {
                    final finalDate = DateFormat('dd/MM/yyyy').format(date);
                    print(finalDate.toString());
                    await dbRef.child(phone.toString()).set({
                      "email": email,
                      "name": name,
                      "DOB": finalDate.toString(),
                      "gender": gender
                    });
                  }).then((value) {
                    user.updateDisplayName(name);
                  });
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'requires-recent-login') {
                    setState(() {
                      isLoading = false;
                    });
                    showMessage(
                        "Sorry, you need to Log Out.\nTry signing in again!");
                    _auth.signOut();
                  }
                } catch (e) {
                  setState(() {
                    isLoading = false;
                  });
                  print(e.toString());
                }
              }
            });
  }

  void showMessage(String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(errorMessage),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () async {
                  Navigator.of(builderContext).pop();
                },
              )
            ],
          );
        }).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }
}
