import 'package:flutter/material.dart';

import '../constants.dart';

class QuantityButton extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final ValueChanged<int> onChanged;
  const QuantityButton(
      {super.key,
      this.minValue = 1,
      this.maxValue = 10,
      required this.onChanged});

  @override
  State<QuantityButton> createState() => _QuantityButtonState();
}

class _QuantityButtonState extends State<QuantityButton> {
  int counter = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[200]),
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(
              Icons.remove,
              color: counter == 1 ? Colors.grey[400] : kPrimaryColor,
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
            iconSize: 18.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              setState(() {
                if (counter > widget.minValue) {
                  counter--;
                }
                widget.onChanged(counter);
              });
            },
          ),
          Text(
            '$counter',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.add,
              color: kPrimaryColor,
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
            iconSize: 18.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              setState(() {
                if (counter < widget.maxValue) {
                  counter++;
                }
                widget.onChanged(counter);
              });
            },
          ),
        ],
      ),
    );
  }
}
