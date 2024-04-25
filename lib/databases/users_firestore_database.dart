import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/models/product_model.dart';

Future<void> addUsertoDb(String userEmail, String userId) async {
  await userDatabase
      .doc(userEmail)
      .set({"userEmail": userEmail, "userId": userId});
}
