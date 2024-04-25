import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../constants.dart';
import '../widgets/forms/add_password_form.dart';

class AddPasswordPage extends StatefulWidget {
  final String userEmail;
  const AddPasswordPage({super.key, required this.userEmail});

  @override
  State<AddPasswordPage> createState() => _AddPasswordPageState();
}

class _AddPasswordPageState extends State<AddPasswordPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final ValueNotifier<bool> passwordisObscureText = ValueNotifier(true);
  final ValueNotifier<bool> confirmPasswordisObscureText = ValueNotifier(true);
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
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
        elevation: 0,
        title: const Text("Add Password"),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Image.asset(kLogocoloured)),
          const SizedBox(
            height: 60,
          ),
          const Text(
            "Add a password to your new account",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: AddPasswordForm(
              formKey: _formKey,
              passwordisObscureText: passwordisObscureText,
              passwordController: passwordController,
              confirmPasswordisObscureText: confirmPasswordisObscureText,
              confirmPasswordController: confirmPasswordController,
              userEmail: widget.userEmail,
            ),
          ),
        ],
      ),
    );
  }
}
