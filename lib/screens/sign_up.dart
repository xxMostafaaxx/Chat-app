import 'package:chat_app/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/TextFormField.dart';
import '../components/button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helpers/showSnackNar.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? email;

  String? password;

  bool isPassword = true;
  RegExp regPass =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  RegExp regEmail = RegExp(r'^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: Container(
          color: kPrimaryColor,
          height: double.infinity,
          child: Form(
            key: formKey,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/login.png",
                      color: Colors.lightBlueAccent,
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Chat With Other",
                      style: GoogleFonts.gemunuLibre(
                          textStyle: const TextStyle(
                              color: Colors.lightBlueAccent,
                              fontSize: 35,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "SignUp",
                      style: GoogleFonts.gemunuLibre(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),


                    defaultTextForm(
                        validator: (data) {
                          if (data!.isEmpty) {
                            return 'Please enter Email';
                          } else {
                            if (!regEmail.hasMatch(data)) {
                              return 'Enter valid Email';
                            } else {
                              return null;
                            }
                          }
                        },
                        type: TextInputType.emailAddress,
                        onChanged: (data) {
                          email = data;
                        },
                        pref: const Icon(
                          Icons.email_rounded,
                          color: Colors.white,
                        ),
                        labelText: "Email",
                        hintText: "Enter your e-mail"),


                    defaultTextForm(
                        validator: (data) {
                          if (data!.isEmpty) {
                            return 'Please enter password';
                          } else {
                            if (!regPass.hasMatch(data)) {
                              return 'Enter valid password';
                            } else {
                              return null;
                            }
                          }
                        },
                        type: TextInputType.visiblePassword,
                        onChanged: (data) {
                          password = data;
                        },
                        pref: const Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        suffix: isPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        isPassword: isPassword,
                        suffixPressed: () {
                          setState(() {
                            isPassword = !isPassword;
                          });
                        },
                        labelText: "Password",
                        hintText: "Enter your Password"),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                        text: "SignUp",
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            isLoading = true;
                            setState(() {});
                            try {
                              await signUp();
                              Navigator.pushNamed(context, "ChatPage");
                              showSnackBar(context, 'SignUp Success');
                            } on FirebaseAuthException catch (e) {
                              if (e.code == "Weak-password") {
                                showSnackBar(context, "Weak Password");
                              } else if (e.code == 'email-already-in-use') {
                                showSnackBar(context, "Email Already exists");
                              }
                            }
                            isLoading = false;

                            setState(() {});
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "already have an account   ",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.lightBlueAccent,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }



  Future<void> signUp() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
