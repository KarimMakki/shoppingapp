import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopping_app/screens/authentication/login.dart';
import 'package:shopping_app/screens/authentication/phone_login.dart';
import 'package:shopping_app/services/firebase_auth_methods.dart';
import 'package:shopping_app/services/wordpress_auth_methods.dart';
import '../../constants.dart';
import '../../widgets/forms/registration_form.dart';
import '../../widgets/loading_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final ValueNotifier<bool> passwordisObscureText = ValueNotifier(true);
  final ValueNotifier<bool> confirmPasswordisObscureText = ValueNotifier(true);
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    passwordisObscureText.dispose();
    confirmPasswordisObscureText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          RegisterForm(
              formKey: _formKey,
              usernameController: usernameController,
              emailController: emailController,
              passwordisObscureText: passwordisObscureText,
              passwordController: passwordController,
              confirmPasswordisObscureText: confirmPasswordisObscureText,
              confirmPasswordController: confirmPasswordController),
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
                  "Or register with",
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
                      "Register with Phone Number",
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
                      "Register with Google",
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
                      "Register with Facebook",
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
                "Already a member?",
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(
                width: 4,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginPage()));
                },
                child: const Text(
                  "Login now",
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
