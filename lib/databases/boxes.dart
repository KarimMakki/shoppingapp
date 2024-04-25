import 'package:hive/hive.dart';
import 'package:shopping_app/constants.dart';

import '../models/user_model.dart';

class Boxes {
  static Box<UserModel> getUser() => Hive.box<UserModel>(userboxkey);
}
