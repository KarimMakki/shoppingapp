import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/models/user_model.dart';
import 'package:shopping_app/providers/cart_provider.dart';
import 'package:shopping_app/providers/coupons_provider.dart';
import 'package:shopping_app/providers/shipping_addresses_provider.dart';
import 'package:shopping_app/providers/wishlist_provider.dart';
import 'package:shopping_app/screens/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await dotenv.load();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<UserModel>(userboxkey);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WishlistProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ShippingAddressesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CouponProvider(),
        )
      ],
      child: MaterialApp(
          theme: ThemeData(
              colorScheme:
                  ThemeData().colorScheme.copyWith(primary: kPrimaryColor)),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen()),
    );
  }
}
