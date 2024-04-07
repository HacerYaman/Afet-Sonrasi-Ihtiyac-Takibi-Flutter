import 'package:dsit_app/pages/help.dart';
import 'package:dsit_app/pages/home_page.dart';
import 'package:dsit_app/pages/login_page.dart';
import 'package:dsit_app/pages/my_requests.dart';
import 'package:dsit_app/pages/need.dart';
import 'package:dsit_app/pages/register_page.dart';
import 'package:dsit_app/pages/welcome_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    const String toAuthRoute = "/toAuthRoute";
    const String toLogin= "/toLogin";
    const String toRegister= "/toRegister";
    const String toHome="/toHome";
    const String toNeed="/toNeed";
    const String toHelp="/toHelp";
    const String toMyRequests="/toMyRequests";

    switch (settings.name) {
      case toAuthRoute:
        return MaterialPageRoute(builder: (_) => WelcomePage());
      case toLogin:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case toRegister:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case toHome:
        return MaterialPageRoute(builder: (_) => HomePage());
      case toNeed:
        return MaterialPageRoute(builder: (_) => NeedPage());
      case toHelp:
        return MaterialPageRoute(builder: (_) => HelpPage());
      case toMyRequests:
        return MaterialPageRoute(builder: (_)=> MyRequests());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              appBar: AppBar(),
              body: const Text("ters giden bir şey oldu"),
            ));
    }
  }
}
