import 'package:country_picker/country_picker.dart';

class ShippingAddress {
  String? firstName;
  String? lastName;
  String? phoneNo;
  String? address1;
  String? address2;
  String? city;
  String? postcode;
  Country? country;
  String? state;
  String? countryName;

  ShippingAddress({
    required this.firstName,
    required this.phoneNo,
    this.country,
    this.countryName,
    this.lastName,
    this.address1,
    this.address2,
    this.city,
    this.postcode,
    this.state,
  });

  factory ShippingAddress.fromFireStoreJson(Map<String, dynamic> data) {
    return ShippingAddress(
        firstName: data["firstName"],
        lastName: data["lastName"],
        phoneNo: data["phoneNo"],
        address1: data["address1"],
        address2: data["address2"],
        city: data["city"],
        postcode: data["postcode"],
        country: Country.from(json: data['country']),
        state: data["state"]);
  }

  factory ShippingAddress.fromJson(Map<String, dynamic> data) {
    return ShippingAddress(
        firstName: data["first_name"],
        lastName: data["last_name"],
        phoneNo: data["phone"],
        address1: data["address_1"],
        address2: data["address_2"],
        city: data["city"],
        state: data["state"],
        postcode: data["postcode"],
        countryName: data['country']);
  }

  Map<String, dynamic> toFireStoreJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "phoneNo": phoneNo,
        "address1": address1,
        "address2": address2,
        "city": city,
        "postcode": postcode,
        "country": country?.toJson(),
        "state": state
      };
}
