import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/shipping_address_model.dart';
import 'package:shopping_app/providers/shipping_addresses_provider.dart';
import 'package:shopping_app/screens/add_address.dart';
import 'package:shopping_app/widgets/address_card.dart';
import 'package:shopping_app/widgets/custom_divider.dart';
import 'package:shopping_app/widgets/loading_widget.dart';
import '../constants.dart';

class AllAddressesPage extends StatelessWidget {
  const AllAddressesPage({super.key});

  @override
  Widget build(BuildContext context) {
    var user = userbox.get(1);

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text(
          "All Addresses",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: Consumer<ShippingAddressesProvider>(
        builder: (context, shippingAddressProvider, child) {
          return StreamBuilder<DocumentSnapshot>(
            stream: userDatabase.doc(user!.userEmail).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!.data() as Map<String, dynamic>;
                if (data["shippingAddresses"] != null &&
                    data["shippingAddresses"].isNotEmpty) {
                  final shippingAddressesMap =
                      data['shippingAddresses'] as List<dynamic>;
                  shippingAddressProvider.shippingAddresses =
                      shippingAddressesMap
                          .map((e) => ShippingAddress.fromFireStoreJson(e))
                          .toList();
                  return Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            shippingAddressProvider.shippingAddresses.length,
                        itemBuilder: (context, index) {
                          final shippingAddress =
                              shippingAddressProvider.shippingAddresses[index];
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 14.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: AddressCard(
                                    isRadioButtonVisible: false,
                                    shippingAddress: shippingAddress,
                                  ),
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
