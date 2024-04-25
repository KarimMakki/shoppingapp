import 'package:flutter/material.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/screens/mainpage.dart';
import 'package:shopping_app/screens/orders.dart';

class ThankYouPage extends StatelessWidget {
  const ThankYouPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              const Icon(
                Icons.check_circle_rounded,
                color: kPrimaryColor,
                size: 55,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Thank you for your order!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              const SizedBox(
                height: 14,
              ),
              const Text(
                "Your order was placed successfully!",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                      color: kPrimaryColor,
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const MainPage(),
                        ));
                      },
                      child: const Text(
                        "Back to Homepage",
                        style: TextStyle(color: Colors.white),
                      )),
                  const SizedBox(
                    width: 15,
                  ),
                  MaterialButton(
                      color: kPrimaryColor,
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OrdersPage(),
                            ),
                            (Route<dynamic> route) => false);
                      },
                      child: const Text(
                        "Orders Page",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
