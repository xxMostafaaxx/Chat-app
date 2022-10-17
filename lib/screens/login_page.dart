import 'package:chat_app/components/TextFormField.dart';
import 'package:chat_app/components/button.dart';
import 'package:chat_app/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helpers/showSnackNar.dart';

class loginPage extends StatefulWidget {
  loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  bool isPassword = true;

  String? email, password;

  GlobalKey<FormState> formKey = GlobalKey();

  RegExp regPass =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  RegExp regEmail =
      RegExp(r'^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~])(?=.*[.]).{8,}$');
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
                padding: const EdgeInsets.only(top: 60),
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
                      "Login",
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
                        onChanged: (data)
                        {
                          email=data;
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
                        onChanged: (data)
                        {
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
                      text: "Login",
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {});
                          try {
                            await signIn();
                            Navigator.pushNamed(context, "ChatPage",arguments: email);
                          } on FirebaseAuthException catch (ex) {
                            if (ex.code == 'user-not-found') {
                              showSnackBar(context, 'user not found');
                            } else if (ex.code == 'wrong-password') {
                              showSnackBar(context, 'wrong password');
                            }
                          } catch (ex) {
                            showSnackBar(context, 'there was an error');
                          }
                          isLoading = false;
                          setState(() {});
                        } else {}
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "don't have an account ? ",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, 'SignUp',);
                          },
                          child: const Text(
                            "Sign Up",
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



  Future<void> signIn() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: email!,
        password: password!
    );
  }
}
