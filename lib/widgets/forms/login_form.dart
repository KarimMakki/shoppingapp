import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../services/firebase_auth_methods.dart';
import '../../services/wordpress_auth_methods.dart';
import '../loading_widget.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.emailController,
    required this.isObscureText,
    required this.passwordController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController emailController;
  final ValueNotifier<bool> isObscureText;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                validator: (value) {
                  if (value == null) {
                    return 'Email is required';
                  }
                  if (!EmailValidator.validate(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                controller: emailController,
                cursorColor: Colors.grey[700],
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  contentPadding: EdgeInsets.only(top: 20),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Icon(
                      Icons.person_2_outlined,
                      size: 25,
                    ),
                  ),
                  hintText: "Email/Username",
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: ValueListenableBuilder<bool>(
                valueListenable: isObscureText,
                builder: (context, value, child) {
                  return TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field is required";
                      }
                      return null;
                    },
                    controller: passwordController,
                    obscureText: isObscureText.value,
                    cursorColor: Colors.grey[700],
                    decoration: InputDecoration(
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        contentPadding: const EdgeInsets.only(top: 22),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Icon(
                            Icons.lock_outline,
                            size: 25,
                          ),
                        ),
                        hintText: "Password",
                        suffixIcon: IconButton(
                          icon: Icon(isObscureText.value
                              ? Icons.visibility_off_outlined
                              : Icons.remove_red_eye_outlined),
                          onPressed: () {
                            isObscureText.value = !isObscureText.value;
                          },
                        )),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(
                        child: CustomLoading(),
                      );
                    },
                  );
                  await WordpressAuthMethods().loginToWordPress(
                      context, emailController.text, passwordController.text);
                  FirebaseAuthMethods().signInUser(
                      context, emailController.text, passwordController.text);
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.37,
                    vertical: 12),
                backgroundColor: kPrimaryColor,
              ),
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ));
  }
}
