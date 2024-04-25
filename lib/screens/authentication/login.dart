import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/screens/authentication/phone_login.dart';
import 'package:shopping_app/screens/authentication/register.dart';
import 'package:shopping_app/screens/mainpage.dart';
import 'package:shopping_app/services/firebase_auth_methods.dart';
import 'package:shopping_app/services/wordpress_auth_methods.dart';
import 'package:shopping_app/widgets/loading_widget.dart';

import '../../widgets/forms/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ValueNotifier<bool> isObscureText = ValueNotifier(true);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    isObscureText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Image.asset(kLogocoloured)),
          const SizedBox(
            height: 40,
          ),
          LoginForm(
              formKey: _formKey,
              emailController: emailController,
              isObscureText: isObscureText,
              passwordController: passwordController),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.grey[600],
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                Text(
                  "Or continue with",
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * 0.85, 47),
                    side: const BorderSide(width: 1, color: Colors.grey)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PhoneLogin(),
                  ));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.phone),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Continue with Phone Number",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    )
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * 0.85, 47),
                    side: const BorderSide(width: 1, color: Colors.grey)),
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(
                        child: CustomLoading(),
                      );
                    },
                  );
                  await FirebaseAuthMethods().handleGoogleSignIn(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/googleicon.png",
                      height: 30,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Text(
                      "Continue with Google",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    )
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * 0.85, 47),
                    side: const BorderSide(width: 1, color: Colors.grey)),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/facebookicon.png",
                      height: 30,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Text(
                      "Continue with Facebook",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    )
                  ],
                )),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Not a member?",
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(
                width: 4,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const RegisterPage()));
                },
                child: const Text(
                  "Register now",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
        ]),
      ),
    );
  }
}
