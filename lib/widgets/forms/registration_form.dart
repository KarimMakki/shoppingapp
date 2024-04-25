import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../services/firebase_auth_methods.dart';
import '../../services/wordpress_auth_methods.dart';
import '../error_message_dialog.dart';
import '../loading_widget.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.usernameController,
    required this.emailController,
    required this.passwordisObscureText,
    required this.passwordController,
    required this.confirmPasswordisObscureText,
    required this.confirmPasswordController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final ValueNotifier<bool> passwordisObscureText;
  final TextEditingController passwordController;
  final ValueNotifier<bool> confirmPasswordisObscureText;
  final TextEditingController confirmPasswordController;

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
                  if (value == null || value.isEmpty) {
                    return "Field is required";
                  }
                  return null;
                },
                controller: usernameController,
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
                  hintText: "Username",
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field is required';
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
                      Icons.email_outlined,
                      size: 25,
                    ),
                  ),
                  hintText: "Email Address",
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: ValueListenableBuilder<bool>(
                valueListenable: passwordisObscureText,
                builder: (context, value, child) {
                  return TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Field is required";
                        }
                        return null;
                      },
                      controller: passwordController,
                      obscureText: passwordisObscureText.value,
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
                          icon: Icon(passwordisObscureText.value
                              ? Icons.visibility_off_outlined
                              : Icons.remove_red_eye_outlined),
                          onPressed: () {
                            passwordisObscureText.value =
                                !passwordisObscureText.value;
                          },
                        ),
                      ));
                },
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: ValueListenableBuilder<bool>(
                valueListenable: confirmPasswordisObscureText,
                builder: (context, value, child) {
                  return TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Field is required";
                        }
                        return null;
                      },
                      controller: confirmPasswordController,
                      obscureText: confirmPasswordisObscureText.value,
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
                        hintText: "Confirm Password",
                        suffixIcon: IconButton(
                          icon: Icon(confirmPasswordisObscureText.value
                              ? Icons.visibility_off_outlined
                              : Icons.remove_red_eye_outlined),
                          onPressed: () {
                            confirmPasswordisObscureText.value =
                                !confirmPasswordisObscureText.value;
                          },
                        ),
                      ));
                },
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  if (passwordController.text ==
                      confirmPasswordController.text) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const Center(
                          child: CustomLoading(),
                        );
                      },
                    );
                    bool doesUserExist = await WordpressAuthMethods()
                        .checkUserExistence(emailController.text);
                    if (doesUserExist) {
                      Navigator.pop(context);
                      errorMessageDialog("User already exist!", context);
                    } else {
                      await WordpressAuthMethods().registertoWoocommerce(
                        usernameController.text,
                        emailController.text,
                        passwordController.text,
                      );
                      FirebaseAuthMethods().signUpUser(
                          context,
                          emailController.text,
                          passwordController.text,
                          usernameController.text,
                          confirmPasswordController.text);
                      WordpressAuthMethods().loginToWordPress(
                        context,
                        usernameController.text,
                        passwordController.text,
                      );
                    }
                  } else {
                    errorMessageDialog("passwords mismatch", context);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.35,
                    vertical: 12),
                backgroundColor: kPrimaryColor,
              ),
              child: const Text(
                "Register",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ));
  }
}
