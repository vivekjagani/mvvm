import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../res/components/round_button.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';
import '../view_model/auth_view_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  ValueNotifier<bool> obsecurePassword = ValueNotifier<bool>(true);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    obsecurePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Signup"),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              focusNode: emailFocusNode,
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
                prefixIcon: Icon(Icons.email),
                label: Text("Email"),
              ),
              onFieldSubmitted: (value) {
                Utils.fieldFocusChange(
                    context, emailFocusNode, passwordFocusNode);
              },
            ),
            ValueListenableBuilder(
              valueListenable: obsecurePassword,
              builder: (context, value, child) {
                return TextFormField(
                  focusNode: passwordFocusNode,
                  obscureText: obsecurePassword.value,
                  obscuringCharacter: '*',
                  controller: passwordController,
                  decoration: InputDecoration(
                      hintText: 'password',
                      prefixIcon: const Icon(Icons.lock),
                      label: const Text("password"),
                      suffixIcon: IconButton(
                          onPressed: () {
                            obsecurePassword.value = !obsecurePassword.value;
                          },
                          icon: obsecurePassword.value
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility))),
                );
              },
            ),
            SizedBox(
              height: height * 0.085,
            ),
            RoundButton(
              onPress: () {
                if (emailController.text.isEmpty &&
                    passwordController.text.isEmpty) {
                  Utils.flushBarErrorMessage(
                      "Please Enter Email And Password", context);
                } else if (emailController.text.isEmpty) {
                  Utils.flushBarErrorMessage("Please Enter email", context);
                } else if (passwordController.text.isEmpty) {
                  Utils.flushBarErrorMessage("Please Enter Password", context);
                } else if (passwordController.text.length < 6) {
                  Utils.flushBarErrorMessage(
                      "Please Enter 6 digit Password", context);
                } else {
                  Map data = {
                    'email': emailController.text,
                    'password': passwordController.text
                  };
                  authViewModel.signUpApi(
                    data,
                    context,
                  );
                  debugPrint("APi call");
                }
              },
              title: 'Loging',
              loading: authViewModel.signUpLoading,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.login);
              },
              child: const Text("Don't Have Account ? LogIn"),
            )
          ],
        ));
  }
}
