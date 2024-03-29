import 'package:chat_app/firestore/account_firestore.dart';
import 'package:chat_app/pages/create_account_page.dart';
import 'package:chat_app/screens/bottom_tab_bar.dart';
import 'package:chat_app/utils/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoggingIn = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              AnimatedOpacity(
                opacity: isLoggingIn ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
                child: Text(
                  "Chat App",
                  style: TextStyle(
                    fontSize: 50,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 3
                      ..color = CupertinoColors.activeGreen,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextFormField(
                    autofillHints: const [AutofillHints.email],
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Email Address",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: CupertinoColors.activeGreen,
                          width: 2,
                        ),
                      ),
                      errorStyle: const TextStyle(
                        color: CupertinoColors.destructiveRed,
                      ),
                    ),
                    cursorColor: CupertinoColors.activeGreen,
                    cursorWidth: 2.0,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextFormField(
                  autofillHints: const [AutofillHints.password],
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: "Password",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: CupertinoColors.activeGreen,
                        width: 2,
                      ),
                    ),
                    errorStyle: const TextStyle(
                      color: CupertinoColors.destructiveRed,
                    ),
                  ),
                  cursorColor: CupertinoColors.activeGreen,
                  cursorWidth: 2.0,
                  obscureText: true,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: CupertinoColors.black,
                  ),
                  children: [
                    const TextSpan(
                      text: "If you do not have an account ",
                    ),
                    TextSpan(
                      text: "this",
                      style: const TextStyle(
                        color: CupertinoColors.activeGreen,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CreateAccountPage(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(
                    () {
                      isLoggingIn = true;
                    },
                  );
                  if (emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    var result = await Authentication.emailSignIn(
                        emailController.text, passwordController.text);
                    if (result is UserCredential) {
                      var result0 =
                          await AccountFirestore.getMyAccount(result.user!.uid);
                      if (result0 == true) {
                        if (!mounted) return;
                        setState(
                          () {
                            isLoggingIn = false;
                          },
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BottomTabBar(),
                          ),
                        );
                      }
                    }
                  }
                },
                child: const Text("Email Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
