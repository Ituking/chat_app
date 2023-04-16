import 'package:chat_app/pages/create_account_page.dart';
import 'package:chat_app/screens/bottom_tab_bar.dart';
import 'package:chat_app/utils/authentication.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              Text(
                "Chat App",
                style: TextStyle(
                  fontSize: 50,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 3
                    ..color = Colors.teal,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: "Email Address",
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      errorStyle: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    cursorColor: Colors.black,
                    cursorWidth: 2.0,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    hintText: "Password",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    errorStyle: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  cursorColor: Colors.black,
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
                    color: Colors.black,
                  ),
                  children: [
                    const TextSpan(
                      text: "If you do not have an account ",
                    ),
                    TextSpan(
                      text: "this",
                      style: const TextStyle(
                        color: Colors.teal,
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
                  if (emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    var result = await Authentication.emailSignIn(
                        emailController.text, passwordController.text);
                    if (result == true) {
                      if (!mounted) return;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BottomTabBar(),
                        ),
                      );
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
