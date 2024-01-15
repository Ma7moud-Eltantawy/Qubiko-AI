import '../enums.dart';

class Proplandataitem {
  final PaymentPLAN paymentplan;
  final String subscription;
  final int amount;
  final int tax;
  final int total;

  // Constructor
  Proplandataitem({required this.paymentplan,required this.subscription,
    required this.amount})
      : tax = (0.2 * amount).toInt(),
        total = amount + (0.2 * amount).toInt();
}

