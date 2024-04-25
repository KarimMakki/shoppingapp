import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/models/cart_item_model.dart';
import 'package:shopping_app/models/shipping_address_model.dart';
import 'package:shopping_app/models/shipping_method_model.dart';
import 'package:shopping_app/providers/cart_provider.dart';
import 'package:shopping_app/providers/coupons_provider.dart';
import 'package:shopping_app/providers/shipping_addresses_provider.dart';
import 'package:shopping_app/screens/choose_address.dart';
import 'package:shopping_app/services/orders_methods.dart';
import 'package:shopping_app/services/getShippingmethods.dart';
import 'package:shopping_app/widgets/loading_widget.dart';
import 'package:shopping_app/widgets/order_item.dart';
import 'package:shopping_app/widgets/tile_button_with_divider.dart';
import '../models/coupon_model.dart';
import '../models/payment_method_model.dart';
import '../services/get_payment_methods.dart';
import '../widgets/show_add_address_dialog.dart';

class CheckoutPage extends StatefulWidget {
  final CartItem? buyNowCartItem;
  const CheckoutPage({super.key, this.buyNowCartItem});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  ShippingAddress? selectedshippingAddress;
  Future? paymentmethods;
  ShippingMethod? selectedShippingMethod;
  PaymentMethod? selectedPaymentMethod;
  Coupon? selectedCoupon;
  final user = userbox.get(1);
  late var formattedtotalPrice = Provider.of<CartProvider>(context).totalPrice;
  @override
  void initState() {
    // show alert dialog if there's no address in shippingAddresses List
    if (context.read<ShippingAddressesProvider>().selectedshippingAddress ==
        null) {
      showAddAddressDialog(context);
    }
    paymentmethods = getPaymentMethods(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int orderTotal = selectedShippingMethod == null
        ? formattedtotalPrice
        : formattedtotalPrice + selectedShippingMethod!.cost!.toInt();
    int totalwithDiscount = selectedCoupon != null
        ? orderTotal - selectedCoupon!.amount!.toInt()
        : orderTotal;
    int buyNowItemTotal = 0;
    if (widget.buyNowCartItem != null) {
      buyNowItemTotal = selectedShippingMethod == null
          ? widget.buyNowCartItem!.quantity! *
              int.parse(widget.buyNowCartItem!.productPrice!)
          : widget.buyNowCartItem!.quantity! *
                  int.parse(widget.buyNowCartItem!.productPrice!) +
              selectedShippingMethod!.cost!.toInt();
      buyNowItemTotal = selectedCoupon == null
          ? buyNowItemTotal
          : buyNowItemTotal - selectedCoupon!.amount!.toInt();
    }
    selectedshippingAddress =
        context.watch<ShippingAddressesProvider>().selectedshippingAddress;
    Future? getShippingCost;
    if (selectedshippingAddress != null) {
      getShippingCost =
          getShippingZonesandMethods(selectedshippingAddress!, context);
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.white,
          leading: const BackButton(color: Colors.black),
          title: const Text(
            "Checkout",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: false,
        ),
        bottomSheet: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5), // Shadow color
                spreadRadius: 2, // Spread radius
                blurRadius: 5, // Blur radius
                offset: const Offset(0, 3), // Offset in x and y direction
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.084,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Row(
              children: [
                const Spacer(),
                Row(
                  children: [
                    const Text("Total: SDG"),
                    Text(
                      widget.buyNowCartItem == null
                          ? totalwithDiscount.toString()
                          : buyNowItemTotal.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 28.0, left: 5, bottom: 5),
                  child: Consumer<CartProvider>(
                    builder: (context, value, child) {
                      return MaterialButton(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        onPressed: () async {
                          await createOrder(
                            context,
                            selectedPaymentMethod,
                            selectedshippingAddress,
                            selectedShippingMethod,
                            Provider.of<CartProvider>(context, listen: false),
                            widget.buyNowCartItem,
                            selectedCoupon,
                            user!,
                          );
                        },
                        color: kPrimaryColor,
                        child: const Text(
                          "Place Order",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ChooseAddressPage(),
                      ));
                      setState(() {
                        selectedShippingMethod = null;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.pin_drop_outlined,
                            color: kPrimaryColor,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          if (selectedshippingAddress != null)
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.73,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Delivery Address",
                                    style: TextStyle(fontSize: 15, height: 1.4),
                                    softWrap: true,
                                    maxLines: 3,
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                      "${selectedshippingAddress?.firstName} ${selectedshippingAddress?.lastName} | ${selectedshippingAddress?.phoneNo}"),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text("${selectedshippingAddress?.address1}"),
                                  Text(
                                      "${selectedshippingAddress?.country!.name}")
                                ],
                              ),
                            ),
                          if (selectedshippingAddress == null)
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.73,
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Select A Delivery Address",
                                    style: TextStyle(fontSize: 15, height: 1.4),
                                    softWrap: true,
                                    maxLines: 3,
                                  ),
                                ],
                              ),
                            ),
                          const Spacer(),
                          const Icon(Icons.chevron_right_outlined)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  const Divider(
                    height: 3,
                    thickness: 1,
                    color: kPrimaryColor,
                  ),
                  Consumer<CartProvider>(
                    builder: (context, value, child) {
                      if (widget.buyNowCartItem == null) {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: value.selectedCartItems.length,
                          itemBuilder: (context, index) {
                            CartItem cartItem =
                                value.selectedCartItems.elementAt(index);
                            return OrderItem(cartItem: cartItem);
                          },
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: OrderItem(cartItem: widget.buyNowCartItem!),
                        );
                      }
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0, top: 10),
                        child: Text(
                          "Shipping Option",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TileButtonwithDivider(
                          content: selectedShippingMethod == null
                              ? "Select Shipping Method"
                              : "${selectedShippingMethod!.methodTitle} - ${selectedShippingMethod!.cost}SDG ",
                          leadingIcon: Icons.delivery_dining,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return FutureBuilder(
                                  future: getShippingCost,
                                  builder: (context, snapshot) {
                                    if (selectedshippingAddress == null) {
                                      return const Center(
                                        child: Text(
                                            "Please select a delivery address"),
                                      );
                                    }
                                    if (snapshot.hasData) {
                                      return ListView.builder(
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (context, index) {
                                          ShippingMethod shippingMethod =
                                              snapshot.data![index];
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedShippingMethod =
                                                    shippingMethod;
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: ListTile(
                                              leading: Text(
                                                  "${shippingMethod.methodTitle}"),
                                              trailing: Text(
                                                  "${shippingMethod.cost}"),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                    return const Center(
                                      child: CustomLoading(),
                                    );
                                  },
                                );
                              },
                            );
                          })
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Payment Methods",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TileButtonwithDivider(
                          content: selectedPaymentMethod == null
                              ? "Choose a Payment Method"
                              : selectedPaymentMethod!.title!,
                          leadingIcon: Icons.toll_outlined,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return FutureBuilder(
                                  future: paymentmethods,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final paymentMethodsWithoutWallet =
                                          snapshot.data
                                              ?.where((element) =>
                                                  element.id != "wallet")
                                              .toList();

                                      return ListView.builder(
                                        itemCount:
                                            paymentMethodsWithoutWallet!.length,
                                        itemBuilder: (context, index) {
                                          PaymentMethod paymentMethod =
                                              snapshot.data![index];
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedPaymentMethod =
                                                    paymentMethod;
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: paymentMethod.enabled == true
                                                ? ListTile(
                                                    leading: Text(
                                                        "${paymentMethod.title}"),
                                                    trailing: Text(
                                                        "${paymentMethod.id}"),
                                                  )
                                                : const SizedBox(),
                                          );
                                        },
                                      );
                                    }
                                    return const Center(
                                      child: CustomLoading(),
                                    );
                                  },
                                );
                              },
                            );
                          })
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer<CouponProvider>(
                        builder: (context, couponprovider, child) {
                          if (couponprovider.userCoupons.isNotEmpty) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "All Coupons",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                TileButtonwithDivider(
                                    content: selectedCoupon == null
                                        ? "Choose a Coupon"
                                        : "Coupon: ${selectedCoupon?.amount}SDG",
                                    leadingIcon: Icons.discount,
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          var usersCoupons =
                                              couponprovider.userCoupons;
                                          return StatefulBuilder(
                                            builder: (context, setModalState) {
                                              return Column(
                                                children: [
                                                  Expanded(
                                                    child: ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: couponprovider
                                                          .userCoupons.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        Coupon coupon =
                                                            usersCoupons[index];
                                                        String expiryDate =
                                                            DateFormat(
                                                                    'yyyy-MM-dd')
                                                                .format(coupon
                                                                    .dateExpires!);

                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: ListTile(
                                                            title: CouponCard(
                                                              clockwise: true,
                                                              curveAxis:
                                                                  Axis.vertical,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.12,
                                                              firstChild:
                                                                  ColoredBox(
                                                                color: coupon
                                                                            .freeShipping ==
                                                                        true
                                                                    ? const Color(
                                                                        0xFF4FAAA2)
                                                                    : Colors
                                                                        .red,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    CircleAvatar(
                                                                      radius:
                                                                          26,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .white,
                                                                      child:
                                                                          Icon(
                                                                        coupon.freeShipping ==
                                                                                true
                                                                            ? Icons.local_shipping
                                                                            : Icons.shopping_cart,
                                                                        size:
                                                                            28,
                                                                        color: coupon.freeShipping ==
                                                                                true
                                                                            ? const Color(0xFF4FAAA2)
                                                                            : Colors.red,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            6),
                                                                    Text(
                                                                      coupon.freeShipping ==
                                                                              true
                                                                          ? "Free Shipping"
                                                                          : "Discount",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              secondChild:
                                                                  ColoredBox(
                                                                color: coupon
                                                                            .freeShipping ==
                                                                        true
                                                                    ? const Color
                                                                            .fromARGB(
                                                                        57,
                                                                        79,
                                                                        170,
                                                                        163)
                                                                    : const Color
                                                                            .fromARGB(
                                                                        35,
                                                                        244,
                                                                        67,
                                                                        54),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          9.0),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        "${coupon.amount?.toInt()}SDG OFF",
                                                                        style: const TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 15),
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                              "Min Spend ${coupon.minimumAmount?.toInt()}SDG"),
                                                                          const Spacer(),
                                                                          Radio(
                                                                            activeColor:
                                                                                kPrimaryColor,
                                                                            value:
                                                                                coupon,
                                                                            groupValue:
                                                                                selectedCoupon,
                                                                            onChanged:
                                                                                (value) {
                                                                              setModalState(() {
                                                                                setState(() {
                                                                                  selectedCoupon = value as Coupon;
                                                                                });
                                                                              });
                                                                            },
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                10,
                                                                          )
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                          "Expires: $expiryDate"),
                                                                      const SizedBox(
                                                                          height:
                                                                              4),
                                                                      const SizedBox(
                                                                        height:
                                                                            6,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              backgroundColor:
                                                                  Colors.white,
                                                            ),
                                                            onTap: () {},
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  MaterialButton(
                                                    minWidth:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                    color: kPrimaryColor,
                                                    child: const Text(
                                                      "Ok",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.03,
                                                  )
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      );
                                    }),
                              ],
                            );
                          }
                          return Container();
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.92,
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 18.0),
                          child: Text(
                            "Merchandise Total",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          widget.buyNowCartItem == null
                              ? "${formattedtotalPrice}SDG"
                              : "${(widget.buyNowCartItem!.quantity! * int.parse(widget.buyNowCartItem!.productPrice!))}SDG ",
                        )
                      ],
                    ),
                  ),
                  if (selectedShippingMethod != null)
                    Column(
                      children: [
                        const SizedBox(
                          height: 18,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.92,
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 18.0),
                                child: Text(
                                  "Shipping cost",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "${selectedShippingMethod?.cost}SDG",
                                style: const TextStyle(),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  if (selectedCoupon != null)
                    Column(
                      children: [
                        const SizedBox(
                          height: 18,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.92,
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 18.0),
                                child: Text(
                                  "Coupon Amount",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "-${selectedCoupon?.amount}SDG",
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 18,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.92,
                    child: Row(
                      children: [
                        const Text(
                          "Order Total",
                          style: TextStyle(fontSize: 15),
                        ),
                        const Spacer(),
                        Text(
                          widget.buyNowCartItem == null
                              ? "${totalwithDiscount.toString()}SDG"
                              : "${buyNowItemTotal.toString()}SDG",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.12,
                  ),
                ],
              );
            },
          ),
        ));
  }
}
