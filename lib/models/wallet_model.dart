class Wallet {
  String? balance;
  String? currency;

  Wallet({required this.balance, required this.currency});

  factory Wallet.fromJson(Map<String, dynamic> data) {
    return Wallet(balance: data["balance"], currency: data["currency"]);
  }
}
