import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/models/shipping_address_model.dart';
import 'package:shopping_app/providers/shipping_addresses_provider.dart';
import 'package:country_picker/country_picker.dart';
import 'package:shopping_app/screens/all_addresses.dart';
import 'package:shopping_app/screens/checkout.dart';
import 'package:shopping_app/services/paypal_services.dart';
import 'package:shopping_app/widgets/error_message_dialog.dart';
import 'package:shopping_app/widgets/loading_widget.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lasteNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController address2Controller = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Country? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: const BackButton(
          color: Colors.black,
        ),
        centerTitle: false,
        title: const Text(
          "Add Address",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
              Row(
                children: [
                  if (selectedCountry != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          Text(
                            selectedCountry!.flagEmoji,
                            style: const TextStyle(fontSize: 25),
                          ),
                          Text(
                            selectedCountry!.name,
                          )
                        ],
                      ),
                    ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
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
                                  color:
                                      const Color(0xFF8C98A8).withOpacity(0.2),
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
                      child: const Text('Show country picker'),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: MaterialButton(
                  onPressed: () async {
                    if (selectedCountry == null) {
                      errorMessageDialog("Please select Country", context);
                    } else if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const Center(
                            child: CustomLoading(),
                          );
                        },
                      );

                      ShippingAddress shippingaddress = ShippingAddress(
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
                          .saveShippingAddresstoDb(shippingaddress);
                      if (context.mounted) {
                        // pop off both the loading indicator and add address page
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                    }
                  },
                  color: kPrimaryColor,
                  height: 37,
                  minWidth: 190,
                  child: const Text(
                    "Submit",
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
      ),
    );
  }
}
