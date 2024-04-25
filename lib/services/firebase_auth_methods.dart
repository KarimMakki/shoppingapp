import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/databases/users_firestore_database.dart';
import 'package:shopping_app/models/user_model.dart';
import 'package:shopping_app/screens/add_password.dart';
import 'package:shopping_app/screens/mainpage.dart';
import 'package:shopping_app/services/wordpress_auth_methods.dart';
import 'package:shopping_app/widgets/loading_widget.dart';
import '../databases/boxes.dart';
import '../widgets/error_message_dialog.dart';

class FirebaseAuthMethods {
  final _auth = FirebaseAuth.instance;
  final box = Boxes.getUser();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> handleGoogleSignIn(BuildContext context) async {
    try {
      // Start the Google Sign-In process
      final GoogleSignInAccount? gUser = await _googleSignIn.signIn();

      if (gUser != null) {
        bool doesUserExist =
            await WordpressAuthMethods().checkUserExistence(gUser.email);
        // Obtain GoogleSignInAuthentication and create GoogleAuthProvider credential
        final GoogleSignInAuthentication googleAuth =
            await gUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in with the Google credential
        final UserCredential authResult =
            await _auth.signInWithCredential(credential);

        // Check if the user is new or already existed
        if (authResult.additionalUserInfo?.isNewUser == true) {
          // This is a new user, handle the new user flow
          if (doesUserExist == false) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPasswordPage(
                    userEmail: gUser.email,
                  ),
                ));
          } else {
            final response =
                await wcApi.getAsync("customers?email=${gUser.email}");

            await addUsertoDb(gUser.email, gUser.email);

            final user = UserModel(
                userEmail: gUser.email,
                userDisplayName: response[0]["username"],
                userId: response[0]["id"].toString());

            box.put(1, user);

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainPage(),
                ),
                (Route<dynamic> route) => false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Login successful'),
                backgroundColor: Colors.green,
                showCloseIcon: true,
                closeIconColor: Colors.white,
              ),
            );
          }
        } else {
          // This is an existing user, handle the existing user flow

          final response =
              await wcApi.getAsync("customers?email=${gUser.email}");

          final user = UserModel(
              userEmail: gUser.email,
              userDisplayName: response[0]["username"],
              userId: response[0]["id"].toString());

          box.put(1, user);

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const MainPage(),
              ),
              (Route<dynamic> route) => false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login successful'),
              backgroundColor: Colors.green,
              showCloseIcon: true,
              closeIconColor: Colors.white,
            ),
          );
        }
      }
    } catch (error) {
      print("Google Sign-In Error: $error");
    }
  }

  void signInUser(BuildContext context, String email, String password) async {
    // show loading circle

    // try sign in
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // pop the loading circle
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const MainPage(),
          ),
          (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);

      // show error message
      errorMessageDialog(e.code, context);
    }
  }

  void signUpUser(BuildContext context, String email, String password,
      String username, String confirmPassword) async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CustomLoading(),
        );
      },
    );

    // try creating the user
    try {
      // check if password and confirm password field is the same
      if (password == confirmPassword) {
        var user = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await addUsertoDb(user.user!.email!, user.user!.uid);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const MainPage(),
            ),
            (Route<dynamic> route) => false);
      } else {
        // pop the loading circle
        Navigator.pop(context);
        // show error message, passwords don't match
        errorMessageDialog("Passwords don't match", context);
      }
      // pop the loading circle
      // Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);

      // show error message
      errorMessageDialog(e.code, context);
    }
  }

  void signUserOut() {
    _auth.signOut();
  }
}
