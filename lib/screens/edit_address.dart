import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/shipping_address_model.dart';

import '../constants.dart';
import '../providers/shipping_addresses_provider.dart';
import '../widgets/loading_widget.dart';

class EditAddressPage extends StatefulWidget {
  final ShippingAddress shippingAddress;
  const EditAddressPage({super.key, required this.shippingAddress});

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  late Country? selectedCountry = widget.shippingAddress.country;
  @override
  Widget build(BuildContext context) {
    final TextEditingController firstNameController =
        TextEditingController(text: widget.shippingAddress.firstName);
    final TextEditingController lasteNameController =
        TextEditingController(text: widget.shippingAddress.lastName);
    final TextEditingController phoneNumberController =
        TextEditingController(text: widget.shippingAddress.phoneNo);
    final TextEditingController cityController =
        TextEditingController(text: widget.shippingAddress.city);
    final TextEditingController address1Controller =
        TextEditingController(text: widget.shippingAddress.address1);
    final TextEditingController address2Controller =
        TextEditingController(text: widget.shippingAddress.address2);
    final TextEditingController stateController =
        TextEditingController(text: widget.shippingAddress.state);
    final TextEditingController postalCodeController =
        TextEditingController(text: widget.shippingAddress.postcode);

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: false,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Edit Address",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8),
              child: Row(
                children: [
                  const Icon(Icons.person_2_outlined),
                  Text(
                    'Contact Information',
                    style: TextStyle(color: Colors.grey[800], fontSize: 15),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field is required";
                  }
                  return null;
                },
                controller: firstNameController,
                cursorColor: Colors.grey[700],
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!)),
                  contentPadding: const EdgeInsets.only(top: 22),
                  hintText: "First Name",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field is required";
                  }
                  return null;
                },
                controller: lasteNameController,
                cursorColor: Colors.grey[700],
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!)),
                  contentPadding: const EdgeInsets.only(top: 22),
                  hintText: "Last Name",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field is required";
                  }
                  return null;
                },
                controller: phoneNumberController,
                cursorColor: Colors.grey[700],
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!)),
                  contentPadding: const EdgeInsets.only(top: 22),
                  hintText: "Phone Number",
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8),
              child: Row(
                children: [
                  const Icon(Icons.pin_drop_outlined),
                  Text(
                    'Address Information',
                    style: TextStyle(color: Colors.grey[800], fontSize: 15),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field is required";
                  }
                  return null;
                },
                controller: cityController,
                cursorColor: Colors.grey[700],
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!)),
                  contentPadding: const EdgeInsets.only(top: 22),
                  hintText: "City",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field is required";
                  }
                  return null;
                },
                controller: stateController,
                cursorColor: Colors.grey[700],
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!)),
                  contentPadding: const EdgeInsets.only(top: 22),
                  hintText: "State",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field is required";
                  }
                  return null;
                },
                controller: address1Controller,
                cursorColor: Colors.grey[700],
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!)),
                  contentPadding: const EdgeInsets.only(top: 22),
                  hintText: "Address 1",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field is required";
                  }
                  return null;
                },
                controller: address2Controller,
                cursorColor: Colors.grey[700],
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!)),
                  contentPadding: const EdgeInsets.only(top: 22),
                  hintText: "Address 2",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field is required";
                  }
                  return null;
                },
                controller: postalCodeController,
                cursorColor: Colors.grey[700],
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!)),
                  contentPadding: const EdgeInsets.only(top: 22),
                  hintText: "Postal Code",
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    selectedCountry?.flagEmoji == null
                        ? widget.shippingAddress.country!.flagEmoji
                        : selectedCountry!.flagEmoji,
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    selectedCountry?.name == null
                        ? widget.shippingAddress.country!.name
                        : selectedCountry!.name,
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      showCountryPicker(
                        context: context,
                        //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                        exclude: <String>['KN', 'MF'],
                        favorite: <String>['SE'],

                        //Optional. Shows phone code before the country name.
                        showPhoneCode: false,
                        onSelect: (Country country) {
                          setState(() {
                            selectedCountry = country;
                          });
                        },
                        // Optional. Sets the theme for the country list picker.
                        countryListTheme: CountryListThemeData(
                          // Optional. Sets the border radius for the bottomsheet.
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                          ),
                          // Optional. Styles the search field.
                          inputDecoration: InputDecoration(
                            labelText: 'Search',
                            hintText: 'Start typing to search',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color(0xFF8C98A8).withOpacity(0.2),
                              ),
                            ),
                          ),
                          // Optional. Styles the text in the search field
                          searchTextStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      );
                    },
                    child: const Text('Country'),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: kPrimaryColor, width: 1)),
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(
                        child: CustomLoading(),
                      );
                    },
                  );
                  await Provider.of<ShippingAddressesProvider>(context,
                          listen: false)
                      .deleteShippingAddressFromDb(widget.shippingAddress);
                  if (context.mounted) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.delete,
                      color: kPrimaryColor,
                    ),
                    Text(
                      "Delete Address",
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: MaterialButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(
                        child: CustomLoading(),
                      );
                    },
                  );
                  ShippingAddress updatedShippingAddress = ShippingAddress(
                      firstName: firstNameController.text,
                      lastName: lasteNameController.text,
                      phoneNo: phoneNumberController.text,
                      city: cityController.text,
                      state: stateController.text,
                      address1: address1Controller.text,
                      address2: address2Controller.text,
                      postcode: postalCodeController.text,
                      country: selectedCountry);
                  await Provider.of<ShippingAddressesProvider>(context,
                          listen: false)
                      .updateShippingAddress(
                          widget.shippingAddress, updatedShippingAddress);
                  if (context.mounted) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                },
                color: kPrimaryColor,
                height: 37,
                minWidth: 190,
                child: const Text(
                  "Update Address",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
