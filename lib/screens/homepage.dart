import 'package:flutter/material.dart';
import 'package:shopping_app/screens/tabpages/all.dart';
import 'package:shopping_app/screens/tabpages/electronics.dart';
import 'package:shopping_app/screens/tabpages/makeup.dart';
import 'package:shopping_app/screens/tabpages/men.dart';
import 'package:shopping_app/screens/tabpages/skincare.dart';
import 'package:shopping_app/screens/tabpages/women.dart';

import '../widgets/appbars/homepage_appbar.dart';
import 'tabpages/kids.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with AutomaticKeepAliveClientMixin<Homepage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: homepageAppBar(context),
        body: const TabBarView(children: [
          All(),
          Men(),
          Women(),
          Kids(),
          Electronics(),
          Makeup(),
          SkinCare()
        ]),
      ),
    );
  }
}
