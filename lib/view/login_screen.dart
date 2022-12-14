import 'package:flutter/material.dart';
import 'package:mvvm/res/components/round_button.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
          title: const Text("Login"),
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
                  authViewModel.loginApi(
                    data,
                    context,
                  );
                  debugPrint("APi call");
                }
              },
              title: 'Loging',
              loading: authViewModel.loading,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.signUp);
              },
              child: Text("Don't Have Account ? SingUp"),
            )
          ],
        ));
  }
}
