import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareIconButton extends StatelessWidget {
  final String sharedText;
  const ShareIconButton({super.key, required this.sharedText});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Share.share(sharedText);
        },
        icon: const Icon(Icons.share));
  }
}
