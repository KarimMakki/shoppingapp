import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15),
      child: Container(
          height: 35,
          decoration: BoxDecoration(color: Colors.grey[200]),
          child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                label: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.grey[600],
                        size: 20,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        "Search",
                        style: TextStyle(color: Colors.grey[600]),
                      )
                    ],
                  ),
                ),
                suffixIcon: Icon(
                  Icons.camera_alt_outlined,
                  size: 20,
                  color: Colors.grey[600],
                )),
          )),
    );
  }
}
