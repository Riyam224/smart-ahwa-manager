import 'package:ahwa_manager_app/models/drink.dart';

class Order {
  final String id;
  final String customerName;
  final Drink drink;
  final String? specialInstructions;
  bool _isCompleted = false;

  Order({
    required this.id,
    required this.customerName,
    required this.drink,
    this.specialInstructions,
  });
  bool get isCompleted => _isCompleted;

  void markItCompleted() {
    _isCompleted = true;
  }

  @override
  String toString() {
    return 'Order{id: $id, customerName: $customerName, drink: ${drink.name}, specialInstructions: $specialInstructions, completed: $_isCompleted}';
  }
}
