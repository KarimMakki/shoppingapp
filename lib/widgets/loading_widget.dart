import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SpinKitRing(
      color: kPrimaryColor,
      size: 30,
      lineWidth: 4,
    );
  }
}
