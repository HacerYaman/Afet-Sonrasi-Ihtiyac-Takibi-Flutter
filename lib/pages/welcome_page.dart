import 'package:dsit_app/consts/app_assets.dart';
import 'package:dsit_app/consts/app_const_string.dart';
import 'package:dsit_app/pages/login_page.dart';
import 'package:dsit_app/pages/register_page.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstString.welcome_text),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset(
                AppAssets.welcome_image,
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.5),
            CustomButtonWidget(
              onPress: () {
                Navigator.pushNamed(context, "/toLogin");
              },
              button_text: AppConstString.login_button_text,
            ),
            CustomButtonWidget(
                onPress: () {
                  Navigator.pushNamed(context, "/toRegister");
                }, button_text: AppConstString.register_buton_text),
            TextButton(
              onPressed: () {},
              child: Text(
                AppConstString.forgotpw_button_text,
                style: TextStyle(color: Colors.black.withOpacity(0.8)),
              ),
            ),
            Spacer(),
            Text("ya da"),
            CustomButtonWidget(
              onPress: () {
                Navigator.pushNamed(context, "/toHome");
              },
              button_text: AppConstString.edevlet_button_text,
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
