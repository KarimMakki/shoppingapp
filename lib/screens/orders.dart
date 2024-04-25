import 'package:flutter/material.dart';
import 'package:shopping_app/screens/mainpage.dart';
import 'package:shopping_app/screens/profile.dart';
import 'package:shopping_app/services/orders_methods.dart';
import 'package:shopping_app/widgets/loading_widget.dart';
import 'package:shopping_app/widgets/order_card.dart';

import '../models/order_model.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final getOrder = getOrders();

  @override
  void initState() {
    getOrder;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
        leading: Navigator.canPop(context)
            ? const BackButton()
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const MainPage();
                        },
                      ),
                    )),
        elevation: 1,
      ),
      body: FutureBuilder(
        future: getOrder,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final Order order = snapshot.data![index];
                  return OrderCard(order: order);
                },
              );
            } else {
              return LayoutBuilder(builder: (context, constraints) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: constraints.maxHeight * 0.18,
                          child: Image.asset(
                            "assets/images/emptyorders.png",
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "No orders available!",
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                );
              });
            }
          }
          return const Center(
            child: CustomLoading(),
          );
        },
      ),
    );
  }
}
