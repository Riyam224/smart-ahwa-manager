import '../models/order.dart';

class ReportService {
  final List<Order> _orders;
  ReportService(this._orders);

  Map<String, int> topSellingDrinks() {
    final report = <String, int>{};
    for (final order in _orders) {
      final drinkName = order.drink.name;
      report[drinkName] = (report[drinkName] ?? 0) + 1;
    }
    return report;
  }

  int totalOrders() {
    return _orders.length;
  }
}
