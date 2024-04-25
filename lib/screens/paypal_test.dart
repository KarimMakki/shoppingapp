import 'package:flutter/material.dart';
import 'package:shopping_app/screens/cart.dart';
import 'package:shopping_app/widgets/loading_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../services/paypal_services.dart';

class PaypalTest extends StatefulWidget {
  const PaypalTest({super.key});

  @override
  State<PaypalTest> createState() => _PaypalTestState();
}

class _PaypalTestState extends State<PaypalTest> {
  PaypalServices paypalServices = PaypalServices();
  late final WebViewController controller;
  PaypalServices services = PaypalServices();

  @override
  void initState() {
    paypalServices.createPaypalPayment();
    super.initState();
    Future.delayed(Duration.zero, () async {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: paypalServices.createPaypalPayment(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            WebViewController webViewController = WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setNavigationDelegate(NavigationDelegate(
                onProgress: (progress) {},
                onPageStarted: (String url) {},
                onPageFinished: (String url) {},
                onWebResourceError: (WebResourceError error) {},
                onNavigationRequest: (NavigationRequest request) {
                  if (request.url.startsWith('https://lenzo.online')) {
                    final uri = Uri.parse(request.url);
                    print(uri);

                    final payerID = uri.queryParameters['PayerID'];
                    paypalServices.executePayment(snapshot.data?["executeUrl"],
                        payerID, snapshot.data?["accessToken"]);
                  }

                  return NavigationDecision.navigate;
                },
              ))
              ..loadRequest(Uri.parse(snapshot.data?["approvalUrl"]));

            return SizedBox(
                width: double.infinity,
                child: WebViewWidget(controller: webViewController));
          }
          return const CustomLoading();
        },
      ),
    );
  }
}
