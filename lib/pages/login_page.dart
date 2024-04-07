import 'package:dsit_app/firebase_db_helper.dart';
import 'package:dsit_app/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts/app_colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Giriş Yap"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Spacer(),
            Form(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    cursorColor: Colors.amber,
                    decoration: InputDecoration(
                        label: Text("E-mail"),
                        prefixIcon: Icon(Icons.mail),
                        prefixIconColor: AppColors.button_color.withOpacity(1),
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    cursorColor: Colors.amber,
                    decoration: InputDecoration(
                        label: Text("Şifre"),
                        prefixIcon: Icon(Icons.key),
                        prefixIconColor: AppColors.button_color.withOpacity(1),
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ))),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: CustomButtonWidget(
                        onPress: () {
                          try {
                            AppHelper().signInWithEmailandPassword(
                                _emailController.text,
                                _passwordController.text);
                            Navigator.pushNamed(context, "/toHome");
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.toString()),
                              ),
                            );
                          }
                        },
                        button_text: "Giriş Yap"),
                  ),
                ],
              ),
            )),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
