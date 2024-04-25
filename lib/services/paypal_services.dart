import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PaypalServices {
  String domain = "https://api-m.sandbox.paypal.com";

  Future<String?> getAccessToken() async {
    final clientId = dotenv.env["clientId"];
    final clientSecret = dotenv.env["clientSecret"];
    final credentials = '$clientId:$clientSecret';
    final base64Credentials = base64.encode(utf8.encode(credentials));
    final headers = {
      'Authorization': 'Basic $base64Credentials',
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    const body = 'grant_type=client_credentials';

    final response = await http.post(
      Uri.parse('$domain/v1/oauth2/token'),
      headers: headers,
      body: body,
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data["access_token"];
    }
    return null;
  }

  Future<Map<String, dynamic>?> createPaypalPayment() async {
    var accessToken = await getAccessToken();
    final bodymessage = jsonEncode({
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {"currency": "EUR", "total": "72.00"},
          "item_list": {
            "items": [
              {
                "quantity": "4",
                "name": "test1",
                "price": "8",
                "currency": "EUR"
              },
              {
                "quantity": "2",
                "name": "test2",
                "price": "20",
                "currency": "EUR"
              }
            ]
          }
        }
      ],
      "redirect_urls": {
        "return_url": "https://lenzo.online",
        "cancel_url": "https://lenzo.online"
      }
    });
    Response response = await http.post(
        Uri.parse("$domain/v1/payments/payment"),
        body: bodymessage,
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $accessToken"
        });
    final body = jsonDecode(response.body);
    if (response.statusCode == 201) {
      if (body['links'] != null && body['links'].length > 0) {
        List links = body['links'];

        String? executeUrl = '';
        String? approvalUrl = '';
        final item = links.firstWhere((o) => o['rel'] == 'approval_url',
            orElse: () => null);
        if (item != null) {
          approvalUrl = item['href'];
        }
        final item1 =
            links.firstWhere((o) => o['rel'] == 'execute', orElse: () => null);
        if (item1 != null) {
          executeUrl = item1['href'];
        }

        return {
          'executeUrl': executeUrl,
          'approvalUrl': approvalUrl,
          'accessToken': accessToken
        };
      }
    }
    return null;
  }

  Future<String?> executePayment(url, payerId, accessToken) async {
    try {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode({'payer_id': payerId}),
          headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $accessToken'
          });

      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return body['id'];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
