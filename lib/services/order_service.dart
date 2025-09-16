import 'package:ahwa_manager_app/models/order.dart';

// * applying SRP
class OrderService {
  // todo store the orders
  final List<Order> _orders = [];
  void addOrder(Order order) {
    _orders.add(order);
  }

  List<Order> get pendingOrders {
    return _orders.where((o) => !o.isCompleted).toList();
  }

  void markCompleted(Order order) {
    order.markItCompleted();
  }

  List<Order> get allOrders => List.unmodifiable(_orders);
}
