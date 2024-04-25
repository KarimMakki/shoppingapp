import 'package:flutter/material.dart';
import 'package:shopping_app/screens/authentication/otp_screen.dart';

import '../../constants.dart';
import '../../services/firebase_auth_methods.dart';

class PhoneLogin extends StatelessWidget {
  const PhoneLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneNumberController = TextEditingController();
    final TextEditingController countryController =
        TextEditingController(text: "+60");
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
          Container(
            height: 55,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 40,
                  child: TextFormField(
                    enabled: false,
                    controller: countryController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Text(
                  "|",
                  style: TextStyle(fontSize: 33, color: Colors.grey),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: TextFormField(
                  maxLength: 11,
                  buildCounter: (context,
                      {required currentLength, required isFocused, maxLength}) {
                    return SizedBox();
                  },
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(),
                    hintText: "Phone",
                  ),
                ))
              ],
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              String phoneNo =
                  "${countryController.text}${phoneNumberController.text.trim()}";
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => OtpScreen(phoneNumber: phoneNo),
              ));
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
        ]),
      ),
    );
  }
}
