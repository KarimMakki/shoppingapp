import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/constants.dart';

import '../models/coupon_model.dart';

class CouponProvider with ChangeNotifier {
  List<Coupon> userCoupons = [];

  Future<void> saveCoupontoDb(Coupon coupon) async {
    var user = userbox.get(1);
    DocumentReference userRef = userDatabase.doc(user?.userEmail);
    final DocumentSnapshot documentSnapshot = await userRef.get();
    final data = documentSnapshot.data() as Map<String, dynamic>;
    final List<dynamic> couponsMap = await data['coupons'] ?? <dynamic>[];
    couponsMap.add(coupon.toFireStoreJson());
    userCoupons.add(coupon);
    await userRef.update({'coupons': couponsMap});
    notifyListeners();
  }

  Future<void> getCoupons() async {
    var user = userbox.get(1);
    DocumentReference userRef = userDatabase.doc(user?.userEmail);
    final DocumentSnapshot documentSnapshot = await userRef.get();
    final data = documentSnapshot.data() as Map<String, dynamic>;
    final couponslist = await data['coupons'];

    if (userCoupons.isEmpty) {
      if (couponslist != null) {
        for (var coupon in couponslist) {
          userCoupons.add(Coupon.fromFirestoreJson(coupon));
        }
      }
    }

    notifyListeners();
  }
}
