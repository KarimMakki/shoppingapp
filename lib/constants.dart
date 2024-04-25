import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shopping_app/databases/boxes.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

const kPrimaryColor = Color(0xFFFF5B00);
const kColorRatingStar = Color(0xfff39c12);
const kLogocoloured = "assets/images/lenzo-coloured.png";
const kLogowhite = "assets/images/lenzo-white.png";
const userboxkey = "userbox";
final consumerKey = dotenv.env["consumerKey"];
final consumerSecret = dotenv.env["consumerSecret"];
final WooCommerceAPI wcApi = WooCommerceAPI(
    url: "https://lenzo.online/",
    consumerKey: consumerKey ?? "",
    consumerSecret: consumerSecret ?? "");
final database = FirebaseFirestore.instance;
final userDatabase = database.collection("users");
final userbox = Boxes.getUser();
final currentLoggedinUser = userbox.get(1);
const baseUrl = 'https://lenzo.online/';
