import 'package:dsit_app/consts/app_const_string.dart';
import 'package:dsit_app/pages/home_page.dart';
import 'package:dsit_app/pages/welcome_page.dart';
import 'package:dsit_app/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp( DsitApp());
}

class DsitApp extends StatelessWidget {
   DsitApp({super.key});

  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      title: AppConstString.app_title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  user == null ? const WelcomePage() : const HomePage(),
    );
  }
}