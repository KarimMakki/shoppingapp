import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../constants.dart';
import '../../databases/users_firestore_database.dart';
import '../../screens/mainpage.dart';
import '../../services/wordpress_auth_methods.dart';
import '../error_message_dialog.dart';
import '../loading_widget.dart';

class AddPasswordForm extends StatelessWidget {
  const AddPasswordForm(
      {super.key,
      required GlobalKey<FormState> formKey,
      required this.passwordisObscureText,
      required this.passwordController,
      required this.confirmPasswordisObscureText,
      required this.confirmPasswordController,
      required this.userEmail})
      : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final ValueNotifier<bool> passwordisObscureText;
  final TextEditingController passwordController;
  final ValueNotifier<bool> confirmPasswordisObscureText;
  final TextEditingController confirmPasswordController;
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            ValueListenableBuilder(
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
                    contentPadding: const EdgeInsets.only(top: 20),
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
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder(
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
                    contentPadding: const EdgeInsets.only(top: 20),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Icon(
                        Icons.lock_outline,
                        size: 25,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(confirmPasswordisObscureText.value
                          ? Icons.visibility_off_outlined
                          : Icons.remove_red_eye_outlined),
                      onPressed: () {
                        confirmPasswordisObscureText.value =
                            !confirmPasswordisObscureText.value;
                      },
                    ),
                    hintText: "Confirm Password",
                  ),
                );
              },
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
                    await WordpressAuthMethods().registertoWoocommerce(
                        userEmail, userEmail, passwordController.text);
                    await WordpressAuthMethods().loginToWordPress(
                        context, userEmail, passwordController.text);
                    await addUsertoDb(userEmail, userEmail);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainPage(),
                        ),
                        (Route<dynamic> route) => false);
                  } else {
                    errorMessageDialog("passwords mismatch", context);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.33,
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
