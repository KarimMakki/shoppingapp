import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/screens/authentication/login.dart';
import 'package:shopping_app/widgets/appbars/wishlist_appbar.dart';
import 'package:shopping_app/widgets/loading_widget.dart';
import 'package:shopping_app/widgets/wishlist_item_card.dart';
import '../models/product_model.dart';

class WishListPage extends StatelessWidget {
  const WishListPage({super.key});

  @override
  Widget build(BuildContext context) {
    var user = userbox.get(1);
    if (userbox.isEmpty) {
      // If the user is not logged in, navigate to LoginPage
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      });

      return Container(); // Return an empty container temporarily
    }
    return Scaffold(
      appBar: wishlistAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('userEmail', isEqualTo: user!.userEmail)
                  .limit(1)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (!snapshot.hasData) {
                  return const CustomLoading(); // Loading indicator
                }

                QueryDocumentSnapshot userDoc = snapshot.data!.docs.first;

                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(userDoc.id)
                      .collection('wishlist')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (!snapshot.hasData) {
                      return const CustomLoading(); // Loading indicator
                    }

                    List<Product> products =
                        snapshot.data!.docs.map((DocumentSnapshot doc) {
                      Map<String, dynamic> data =
                          doc.data() as Map<String, dynamic>;
                      return Product.fromFireStoreJson(data);
                    }).toList();
                    if (snapshot.data!.docs.isNotEmpty) {
                      return Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 0.62),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            Product product = products[index];
                            return WishlistItemCard(product: product);
                          },
                        ),
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.18,
                            child:
                                Image.asset("assets/images/wishlist_empty.png"),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            "Your wishlist is empty!",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
