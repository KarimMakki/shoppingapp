import 'package:flutter/material.dart';
import 'package:shopping_app/widgets/customSearchBar.dart';

class MainTabBar extends StatelessWidget implements PreferredSizeWidget {
  const MainTabBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // const CustomSearchBar(),
        // const SizedBox(
        //   height: 6,
        // ),
        TabBar(
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.black,
            tabs: [
              Tab(
                  child: Text(
                "All".toUpperCase(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                ),
              )),
              Tab(
                child: Text(
                  "Men".toUpperCase(),
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w800),
                ),
              ),
              Tab(
                child: Text(
                  "Women".toUpperCase(),
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w800),
                ),
              ),
              Tab(
                child: Text(
                  "Kids".toUpperCase(),
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w800),
                ),
              ),
              Tab(
                child: Text(
                  "Electronics".toUpperCase(),
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w800),
                ),
              ),
              Tab(
                child: Text(
                  "Makeup".toUpperCase(),
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w800),
                ),
              ),
              Tab(
                child: Text(
                  "Skin Care".toUpperCase(),
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w800),
                ),
              )
            ]),
      ],
    );
  }
}
