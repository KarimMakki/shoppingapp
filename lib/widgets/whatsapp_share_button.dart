import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsappIconShareButton extends StatelessWidget {
  final String sharedText;
  const WhatsappIconShareButton({super.key, required this.sharedText});

  @override
  Widget build(BuildContext context) {
    launchURL(Uri url) async {
      try {
        launchUrl(url);
      } catch (e) {
        print(e);
      }
    }

    final Uri whatsappURl =
        Uri.parse("https://api.whatsapp.com/send?text=$sharedText");
    return IconButton(
      onPressed: () {
        launchURL(whatsappURl);
      },
      icon: Image.asset(
        "assets/images/whatsapp.png",
        scale: 10,
      ),
    );
  }
}
