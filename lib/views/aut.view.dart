import 'package:flutter/material.dart';
import 'package:vehicle_fleet_system/utils/index.dart';
import 'package:vehicle_fleet_system/views/home.view.dart';
import 'package:vehicle_fleet_system/widgets/custom.filled.button.dart';
import 'package:vehicle_fleet_system/widgets/custom.input.field.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final _userName = TextEditingController();
    final _password = TextEditingController();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              CustomInputField(
                label: "Username",
                hint: "user_222",
                controller: _userName,
              ),
              CustomInputField(
                label: "Password",
                hint: "********",
                controller: _password,
                isPassword: true,
              ),
              CustomButton(
                text: "Continue",
                onPressed: () {
                  if (_userName.text == "user123" &&
                      _password.text == "password123") {
                    context.navigator(context, const HomeView());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
