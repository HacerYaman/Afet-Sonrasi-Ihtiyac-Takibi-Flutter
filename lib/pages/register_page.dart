import 'package:dsit_app/firebase_db_helper.dart';
import 'package:flutter/material.dart';
import '../consts/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {

    final emailController= TextEditingController();
    final passwordController= TextEditingController();
    final ilController= TextEditingController();
    final ilceController= TextEditingController();
    final fulladressController= TextEditingController();
    final phoneNoController= TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Üye Ol"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const Spacer(),
            Form(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: CustomTextFormField(
                      controller: emailController,
                      hint: 'E-mail',
                      icon: Icon(Icons.mail),
                      icon_color: AppColors.button_color.withOpacity(1),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 2),
                          child: CustomTextFormField(
                            controller: ilController,
                            hint: 'İl',
                            icon: Icon(Icons.pin_drop_outlined),
                            icon_color: AppColors.button_color.withOpacity(1),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 2),
                          child: CustomTextFormField(
                            controller: ilceController,
                            hint: 'İlçe',
                            icon: Icon(Icons.pin_drop_outlined),
                            icon_color: AppColors.button_color.withOpacity(1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: CustomTextFormField(
                      controller: fulladressController,
                      hint: 'Açık Adres',
                      icon: Icon(Icons.pin_drop_outlined),
                      icon_color: AppColors.button_color.withOpacity(1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: CustomTextFormField(
                      controller: phoneNoController,
                      hint: 'Telefon Numarası',
                      icon: Icon(Icons.phone),
                      icon_color: AppColors.button_color.withOpacity(1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: CustomTextFormField(
                      controller: passwordController,
                      hint: 'Şifre',
                      icon: Icon(Icons.key),
                      icon_color: AppColors.button_color.withOpacity(1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: CustomButtonWidget(
                        onPress: () {
                          try{
                            String fullAdres= ilceController.text+""+ilController.text+""+fulladressController.text;
                            AppHelper().signUpWithEmailAndPassword(emailController.text, passwordController.text, fullAdres, phoneNoController.text);
                            Navigator.pushNamed(context, "/toHome");
                          }catch (e){
                          }
                        },
                        button_text: "Üye Ol"),
                  ),
                ],
              ),
            )),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
