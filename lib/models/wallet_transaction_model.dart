class WalletTransaction {
  String? transactionID;
  String? type;
  double? amount;
  double? balance;
  String? details;
  String? currency;
  DateTime date;

  WalletTransaction(
      {required this.transactionID,
      required this.type,
      required this.amount,
      required this.balance,
      required this.currency,
      required this.date,
      this.details});

  factory WalletTransaction.fromJson(Map<String, dynamic> data) {
    return WalletTransaction(
        transactionID: data["transaction_id"],
        type: data["type"],
        amount: double.parse(data["amount"]),
        balance: double.parse(data["balance"]),
        currency: data["currency"],
        details: data["details"],
        date: DateTime.parse(data["date"]));
  }

  bool get isCredit => type == 'credit';

  bool get isTransfer => type == 'debit' && details!.contains('transfer');

  String get transferNote => details ?? "";
}
