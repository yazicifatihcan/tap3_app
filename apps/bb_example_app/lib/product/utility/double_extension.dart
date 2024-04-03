import 'package:intl/intl.dart';

extension DoubleExtension on double {
  String formatPrice() {
    final formatter = NumberFormat('#,##0.00', 'pt_BR');
    return formatter.format(this);
  }
}
