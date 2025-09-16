import 'package:ahwa_manager_app/models/drink.dart';
import 'package:ahwa_manager_app/models/order.dart';
import 'package:ahwa_manager_app/services/order_service.dart';
import 'package:ahwa_manager_app/services/reports_service.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final OrderService _orderService = OrderService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  Drink _selectedDrink = const Coffee();

  void _addOrder() {
    if (_nameController.text.isEmpty) return;

    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      customerName: _nameController.text,
      drink: _selectedDrink,
      specialInstructions: _notesController.text.isEmpty
          ? null
          : _notesController.text,
    );

    setState(() {
      _orderService.addOrder(order);
    });

    _nameController.clear();
    _notesController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final pending = _orderService.pendingOrders;
    final completed = _orderService.allOrders
        .where((o) => o.isCompleted)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(' Ahwa App ☕'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
              final report = ReportService(_orderService.allOrders);
              final summary = report
                  .topSellingDrinks()
                  .entries
                  .map((e) => '${e.key}: ${e.value}')
                  .join(', ');

              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Daily Report'),
                  content: Text(
                    'Total Orders: ${report.totalOrders()}\nTop Selling: $summary',
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Dashboard ---
            Text(
              'Pending Orders: ${pending.length}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              'Completed Orders: ${completed.length}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),

            // --- Form ---
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Customer Name'),
            ),
            DropdownButton<Drink>(
              value: _selectedDrink,
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: Coffee(), child: Text('Coffee - \$10')),
                DropdownMenuItem(
                  value: GreenTea(),
                  child: Text('Green Tea - \$10'),
                ),
                DropdownMenuItem(
                  value: BlackTea(),
                  child: Text('Black Tea - \$10'),
                ),
                DropdownMenuItem(
                  value: HibiscusTea(),
                  child: Text('Hibiscus Tea - \$20'),
                ),
                DropdownMenuItem(
                  value: HotChocolate(),
                  child: Text('Hot Chocolate - \$30'),
                ),
              ],
              onChanged: (drink) {
                setState(() => _selectedDrink = drink!);
              },
            ),
            TextField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Special Instructions',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addOrder,
              child: const Text('Add Order'),
            ),
            const Divider(),

            // --- Orders Tabs (Pending & Completed) ---
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    const TabBar(
                      tabs: [
                        Tab(text: "Pending"),
                        Tab(text: "Completed"),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          // Pending Orders
                          pending.isEmpty
                              ? const Center(child: Text('No pending orders.'))
                              : ListView.builder(
                                  itemCount: pending.length,
                                  itemBuilder: (context, index) {
                                    final order = pending[index];
                                    return Card(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 6,
                                        horizontal: 4,
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          '${order.customerName} - ${order.drink.name}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: Text(
                                          'Price: \$${order.drink.price} \nNotes: ${order.specialInstructions ?? 'No notes'}',
                                        ),
                                        trailing: IconButton(
                                          icon: const Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _orderService.markCompleted(
                                                order,
                                              );
                                            });
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),

                          // Completed Orders
                          completed.isEmpty
                              ? const Center(
                                  child: Text('No completed orders yet.'),
                                )
                              : ListView.builder(
                                  itemCount: completed.length,
                                  itemBuilder: (context, index) {
                                    final order = completed[index];
                                    return Card(
                                      color: Colors.grey[200],
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 6,
                                        horizontal: 4,
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          '${order.customerName} - ${order.drink.name}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: Text(
                                          'Price: \$${order.drink.price} \nNotes: ${order.specialInstructions ?? 'No notes'}',
                                        ),
                                        trailing: const Icon(
                                          Icons.check,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
