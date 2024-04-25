import 'package:flutter/material.dart';
import 'package:shopping_app/models/shipping_address_model.dart';
import 'package:shopping_app/models/shipping_zone_model.dart';
import '../constants.dart';
import '../models/shipping_method_model.dart';
import '../widgets/get_data_error_snackbar.dart';

int maxRetries = 3; // Maximum number of retry attempts
int retryDelaySeconds = 3; // Delay between retries in seconds
Future getShippingMethodsByZone(int zoneId, BuildContext context) async {
  for (int retryCount = 0; retryCount < maxRetries; retryCount++) {
    try {
      final response =
          await wcApi.getAsync('shipping/zones/$zoneId/methods?lang=en');
      final List<Map<String, dynamic>> shippingmethods =
          response.cast<Map<String, dynamic>>();
      List<ShippingMethod> shippingMethodsList =
          shippingmethods.map((e) => ShippingMethod.fromJson(e)).toList();
      return shippingMethodsList;
    } catch (e) {
      if (retryCount < maxRetries - 1) {
        print('Retrying in $retryDelaySeconds seconds...');
        await Future.delayed(Duration(seconds: retryDelaySeconds));
      }
      if (retryCount == maxRetries - 1) {
        SnackBarError.show(context, "Error showing data", () => null);
      }
    }
  }
}

Future getShippingZonesandMethods(
    ShippingAddress shippingAddress, BuildContext context) async {
  for (int retryCount = 0; retryCount < maxRetries; retryCount++) {
    try {
      var list;
      final response = await wcApi.getAsync('shipping/zones');
      List shippingZones = response as List<dynamic>;
      List<ShippingZone> shippingZonesList =
          shippingZones.map((data) => ShippingZone.fromJson(data)).toList();
      bool containsValue = shippingZonesList
          .any((element) => element.name == shippingAddress.country!.name);
      for (var element in shippingZonesList) {
        if (element.name == shippingAddress.country!.name) {
          list = getShippingMethodsByZone(element.id!, context);
        }
      }
      if (!containsValue) {
        list = getShippingMethodsByZone(0, context);
      }
      return list;
    } catch (e) {
      if (retryCount < maxRetries - 1) {
        print('Retrying in $retryDelaySeconds seconds...');
        await Future.delayed(Duration(seconds: retryDelaySeconds));
      }
      if (retryCount == maxRetries - 1) {
        SnackBarError.show(context, "Error showing data", () => null);
      }
    }
  }
}
