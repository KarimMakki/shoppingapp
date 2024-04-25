import 'package:flutter/material.dart';
import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/constants.dart';
import 'package:shopping_app/providers/coupons_provider.dart';
import 'package:shopping_app/widgets/loading_widget.dart';
import '../models/coupon_model.dart';
import '../services/getCoupons.dart';

class CouponsPage extends StatefulWidget {
  const CouponsPage({super.key});

  @override
  State<CouponsPage> createState() => _CouponsPageState();
}

class _CouponsPageState extends State<CouponsPage> {
  late final getcoupons = getCoupons(context);

  @override
  void initState() {
    getcoupons;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: kPrimaryColor,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getcoupons,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset("assets/images/image1.webp")),
                  Consumer<CouponProvider>(
                    builder: (context, couponprovider, child) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          Coupon coupon = snapshot.data![index];
                          var usersCoupons = couponprovider.userCoupons;
                          bool isCouponExist = usersCoupons
                              .any((usercoupon) => usercoupon.id == coupon.id);
                          String expiryDate = DateFormat('yyyy-MM-dd')
                              .format(coupon.dateExpires!);

                          return Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: CouponCard(
                                clockwise: true,
                                curveAxis: Axis.vertical,
                                height:
                                    MediaQuery.of(context).size.height * 0.11,
                                firstChild: ColoredBox(
                                  color: coupon.freeShipping == true
                                      ? const Color(0xFF4FAAA2)
                                      : Colors.red,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 26,
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          coupon.freeShipping == true
                                              ? Icons.local_shipping
                                              : Icons.shopping_cart,
                                          size: 28,
                                          color: coupon.freeShipping == true
                                              ? const Color(0xFF4FAAA2)
                                              : Colors.red,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        coupon.freeShipping == true
                                            ? "Free Shipping"
                                            : "Discount",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                secondChild: ColoredBox(
                                  color: coupon.freeShipping == true
                                      ? const Color.fromARGB(57, 79, 170, 163)
                                      : const Color.fromARGB(35, 244, 67, 54),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 9.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${coupon.amount?.toInt()}SDG OFF",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),

                                        Row(
                                          children: [
                                            Text(
                                                "Min Spend ${coupon.minimumAmount?.toInt()}SDG"),
                                            const Spacer(),
                                            MaterialButton(
                                              height: 28,
                                              minWidth: 10,
                                              onPressed: () {
                                                if (!isCouponExist) {
                                                  couponprovider
                                                      .saveCoupontoDb(coupon);
                                                  setState(() {});
                                                }
                                              },
                                              color: !isCouponExist
                                                  ? kPrimaryColor
                                                  : Colors.grey[500],
                                              child: Text(
                                                !isCouponExist
                                                    ? "Claim "
                                                    : "Claimed",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            )
                                          ],
                                        ),

                                        Text("Expires: $expiryDate"),
                                        const SizedBox(height: 4),
                                        // Align(
                                        //   alignment: Alignment.center,
                                        //   child: MaterialButton(
                                        //     height: 28,
                                        //     onPressed: () {
                                        //       if (!isCouponExist) {
                                        //         couponprovider
                                        //             .saveCoupontoDb(coupon);
                                        //       }
                                        //     },
                                        //     color: !isCouponExist
                                        //         ? kPrimaryColor
                                        //         : Colors.black,
                                        //     child: Text(
                                        //       !isCouponExist
                                        //           ? "Claim Coupon"
                                        //           : "Claimed",
                                        //       style: const TextStyle(
                                        //           fontSize: 12,
                                        //           color: Colors.white,
                                        //           fontWeight: FontWeight.bold),
                                        //     ),
                                        //   ),
                                        // ),
                                        const SizedBox(
                                          height: 6,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                backgroundColor: Colors.white,
                              ));
                        },
                      );
                    },
                  ),
                ],
              );
            } else {
              return const Align(
                  alignment: Alignment.center, child: CustomLoading());
            }
          },
        ),
      ),
    );
  }
}
