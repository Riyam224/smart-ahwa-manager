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
    final completed = _orderService.completedOrders;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ahwa App ☕'),
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
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'Pending 🟡'),
              Tab(text: 'Completed ✅'),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Dashboard
              Card(
                color: Colors.brown.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildDashboardItem(
                        "Pending",
                        pending.length.toString(),
                        Colors.orange,
                      ),
                      _buildDashboardItem(
                        "Completed",
                        completed.length.toString(),
                        Colors.green,
                      ),
                      _buildDashboardItem(
                        "Total",
                        _orderService.allOrders.length.toString(),
                        Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Form
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Customer Name'),
              ),
              DropdownButton<Drink>(
                value: _selectedDrink,
                items: const [
                  DropdownMenuItem(
                    value: Coffee(),
                    child: Text('Coffee - \$10'),
                  ),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Add Order'),
              ),
              const Divider(),

              // Tab View (Pending + Completed)
              Expanded(
                child: TabBarView(
                  children: [
                    _buildOrderList(pending, false),
                    _buildOrderList(completed, true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _buildOrderList(List<Order> orders, bool completed) {
    if (orders.isEmpty) {
      return const Center(child: Text("No orders here yet."));
    }

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            title: Text('${order.customerName} - ${order.drink.name}'),
            subtitle: Text(
              'Price: \$${order.drink.price}\nNotes: ${order.specialInstructions ?? "no"}',
            ),
            trailing: completed
                ? const Icon(Icons.check, color: Colors.green)
                : IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: () {
                      setState(() {
                        _orderService.markCompleted(order);
                      });
                    },
                  ),
          ),
        );
      },
    );
  }
}
