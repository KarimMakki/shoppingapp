import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/shipping_address_model.dart';
import '../providers/shipping_addresses_provider.dart';
import '../widgets/address_card.dart';
import '../widgets/custom_divider.dart';
import '../widgets/loading_widget.dart';
import 'add_address.dart';

class ChooseAddressPage extends StatefulWidget {
  const ChooseAddressPage({super.key});

  @override
  State<ChooseAddressPage> createState() => _ChooseAddressPageState();
}

class _ChooseAddressPageState extends State<ChooseAddressPage> {
  StreamSubscription<DocumentSnapshot>? _streamSubscription;
  var user = userbox.get(1);
  @override
  void initState() {
    _streamSubscription =
        userDatabase.doc(user!.userEmail).snapshots().listen((event) {});
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text(
          "Choose Address",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: Consumer<ShippingAddressesProvider>(
        builder: (context, value, child) {
          return StreamBuilder<DocumentSnapshot>(
            stream: userDatabase.doc(user!.userEmail).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!.data() as Map<String, dynamic>;
                if (data["shippingAddresses"] != null &&
                    data["shippingAddresses"].isNotEmpty) {
                  final shippingAddressesMap =
                      data['shippingAddresses'] as List<dynamic>;
                  value.shippingAddresses = shippingAddressesMap
                      .map((e) => ShippingAddress.fromFireStoreJson(e))
                      .toList();
                  return Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.shippingAddresses.length,
                        itemBuilder: (context, index) {
                          final shippingAddress =
                              value.shippingAddresses[index];

                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 14.0),
                                child: AddressCard(
                                  isRadioButtonVisible: true,
                                  shippingAddress: shippingAddress,
                                ),
                              ),
                              const CustomDivider()
                            ],
                          );
                        },
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AddAddressPage(),
                          ));
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: kPrimaryColor,
                            ),
                            Text(
                              "Add new Address",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 170,
                            child: Image.asset(
                              "assets/images/no_addresses.png",
                            )),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Your addresses is empty!",
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        MaterialButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const AddAddressPage(),
                            ));
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                color: kPrimaryColor,
                              ),
                              Text(
                                "Add new Address",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
              }
              return const Center(child: CustomLoading());
            },
          );
        },
      ),
    );
  }
}
