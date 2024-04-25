import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/shipping_address_model.dart';
import 'package:shopping_app/providers/shipping_addresses_provider.dart';
import 'package:shopping_app/screens/edit_address.dart';

import '../constants.dart';

class AddressCard extends StatelessWidget {
  final ShippingAddress shippingAddress;
  final bool isRadioButtonVisible;
  const AddressCard(
      {super.key,
      required this.shippingAddress,
      required this.isRadioButtonVisible});

  @override
  Widget build(BuildContext context) {
    return Consumer<ShippingAddressesProvider>(
      builder: (context, shippingAddressProvider, child) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EditAddressPage(
                shippingAddress: shippingAddress,
              ),
            ));
          },
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Row(
              children: [
                Visibility(
                  visible: isRadioButtonVisible ? true : false,
                  child: Radio<String>(
                    activeColor: kPrimaryColor,
                    value: shippingAddress.firstName!,
                    groupValue: shippingAddressProvider
                        .selectedShippingAddressFirstName,
                    onChanged: (value) {
                      shippingAddressProvider.selectingaddress(value!);
                      shippingAddressProvider
                          .storeSelectedShippingAddress(value);
                    },
                  ),
                ),
                const Icon(
                  Icons.pin_drop_outlined,
                  color: kPrimaryColor,
                ),
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.73,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Delivery Address",
                        style: TextStyle(fontSize: 15, height: 1.4),
                        softWrap: true,
                        maxLines: 3,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                          "${shippingAddress.firstName} ${shippingAddress.lastName} | ${shippingAddress.phoneNo}"),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(shippingAddress.address1 ?? ""),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                          "${shippingAddress.state} | ${shippingAddress.country!.name}")
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_outlined)
              ],
            ),
          ),
        );
      },
    );
  }
}
