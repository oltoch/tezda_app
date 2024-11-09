import 'package:intl/intl.dart';

extension Format on double {
  String get formatToCurrency {
    return this == 0 ? '\$0' : '\$${NumberFormat('#,##0.##').format(this)}';
  }
}
