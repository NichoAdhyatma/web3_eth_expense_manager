class TransactionModel {
  final String address;
  final int amount;
  final String reason;
  final DateTime timestamp;

  TransactionModel({
    required this.address,
    required this.reason,
    required this.amount,
    required this.timestamp,
  });
}
