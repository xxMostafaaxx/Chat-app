import 'package:chat_app/screens/ChatPage.dart';
import 'package:chat_app/screens/login_page.dart';
import 'package:chat_app/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'LoginPage': (context) => loginPage(),
        'SignUp': (context) => SignUp(),
        'ChatPage': (context) => ChatPage(),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: "LoginPage",
    );
  }
}
