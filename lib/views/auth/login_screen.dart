import 'package:flutter/material.dart';
import 'package:unimap_admin/widgets/custom_password_textfield.dart';
import 'package:unimap_admin/widgets/custom_textfield.dart';
import '../bottom_nav/bottom_nav.dart';
import'package:unimap_admin/controllers/user_controller.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final UserController userController = UserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const FlutterLogo(
                    size: 100,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    labelText: 'Email',
                    controller: emailController,
                    textInputType: TextInputType.emailAddress,
                    borderColor: Colors.green,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomPasswordTextField(
                    hintText: 'Password',
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: ()async {
                        await userController.signInWithEmail(emailController.text, passwordController.text, context);
                      },
                      child: const Text('Login'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                ],
              ),
            )));
  }
}
