import 'package:flutter/material.dart';

class EditQuantityButton extends StatefulWidget {
  final int counter;
  final ValueChanged<int> onChanged;

  const EditQuantityButton(
      {super.key, required this.counter, required this.onChanged});

  @override
  State<EditQuantityButton> createState() => _EditQuantityButtonState();
}

class _EditQuantityButtonState extends State<EditQuantityButton> {
  @override
  Widget build(BuildContext context) {
    int minValue = 1;
    int maxValue = 50;
    int localCounter = widget
        .counter; // Create a local mutable variable so we can make the counter variable final

    return Row(
      children: [
        IconButton(
          onPressed: () {
            if (localCounter > minValue) {
              setState(() {
                localCounter--;
              });
              widget.onChanged(localCounter);
            }
          },
          icon: const Icon(Icons.remove),
        ),
        Text("$localCounter"),
        IconButton(
          onPressed: () {
            if (localCounter < maxValue) {
              setState(() {
                localCounter++;
              });
              widget.onChanged(localCounter);
            }
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
