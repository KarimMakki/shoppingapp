import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/wishlist_provider.dart';
import 'package:shopping_app/screens/add_password.dart';
import 'package:shopping_app/widgets/loading_widget.dart';
import '../../constants.dart';
import '../../databases/boxes.dart';
import '../../models/user_model.dart';
import '../../widgets/error_message_dialog.dart';
import '../mainpage.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? verifId;
  final _auth = FirebaseAuth.instance;
  final box = Boxes.getUser();
  @override
  void initState() {
    verifyUserPhoneNumber(widget.phoneNumber);
    super.initState();
  }

  void verifyUserPhoneNumber(String userNumber) {
    _auth.verifyPhoneNumber(
      phoneNumber: userNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) async {
        verifId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verifId = verificationId;
        print('TimeOut');
      },
    );
  }

  void sentOtpCode(String otp) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CustomLoading(),
        );
      },
    );
    // Update the UI - wait for the user to enter the SMS code
    String smsCode = otp;

    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verifId!, smsCode: smsCode);

    // Sign the user in (or link) with the credential
    try {
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      String userphoneNo =
          "${authResult.user!.phoneNumber!.substring(1)}@lenzo.online";
      if (authResult.additionalUserInfo?.isNewUser == true) {
        // This is a new user, perform new user actions

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddPasswordPage(
            userEmail: userphoneNo,
          ),
        ));
        print("New user signed in with phone number");
      } else {
        // This is an existing user, perform existing user actions
        print("Existing user signed in with phone number");
        if (authResult.user != null) {
          final response = await wcApi.getAsync("customers?email=$userphoneNo");

          final user = UserModel(
              userEmail: userphoneNo,
              userDisplayName: response[0]["username"],
              userId: response[0]["id"].toString());

          await box.put(1, user);

          if (context.mounted) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainPage(),
                ),
                (Route<dynamic> route) => false);
          }
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
      // await _auth.signInWithCredential(credential).then((value) {});
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-verification-code") {
        Navigator.pop(context);

        errorMessageDialog("Invalid Verification Code", context);
      }
      errorMessageDialog(e.message.toString(), context);
    }
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
          const Text(
            "Enter the verification code sent to",
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.phoneNumber,
            style: const TextStyle(
                fontSize: 19, letterSpacing: 1, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 17,
          ),
          OtpTextField(
            numberOfFields: 6,
            textStyle:
                const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            margin: const EdgeInsets.only(right: 16),
            focusedBorderColor: kPrimaryColor,
            enabledBorderColor: const Color.fromARGB(73, 0, 0, 0),
            cursorColor: kPrimaryColor,
            onSubmit: (String code) {
              sentOtpCode(code);
            },
          ),
        ]),
      ),
    );
  }
}
